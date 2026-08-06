import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  User? _firebaseUser;
  UserModel? _userModel;
  bool _loading = false;
  String? _error;

  User? get firebaseUser => _firebaseUser;
  UserModel? get userModel => _userModel;
  bool get loading => _loading;
  String? get error => _error;
  bool get isLoggedIn => _firebaseUser != null;
  bool get isAdmin => _userModel?.isAdmin ?? false;

  AuthProvider() {
    _authService.authStateChanges.listen(_onAuthChanged);
  }

  void _onAuthChanged(User? user) {
    _firebaseUser = user;
    if (user != null) {
      _firestoreService.userStream(user.uid).listen((model) {
        _userModel = model;
        notifyListeners();
      });
    } else {
      _userModel = null;
    }
    notifyListeners();
  }

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
    String? referralCode,
  }) async {
    _setLoading(true);
    try {
      await _authService.signUpWithEmail(
        email: email,
        password: password,
        displayName: displayName,
        referralCode: referralCode?.isEmpty == true ? null : referralCode,
      );
      _error = null;
    } on FirebaseAuthException catch (e) {
      _error = _mapAuthError(e.code);
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    try {
      await _authService.signInWithEmail(email: email, password: password);
      _error = null;
    } on FirebaseAuthException catch (e) {
      _error = _mapAuthError(e.code);
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signInWithGoogle({String? referralCode}) async {
    _setLoading(true);
    try {
      await _authService.signInWithGoogle(referralCode: referralCode);
      _error = null;
    } on FirebaseAuthException catch (e) {
      _error = _mapAuthError(e.code);
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> sendPasswordReset(String email) async {
    await _authService.sendPasswordReset(email);
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }

  void _setLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  String _mapAuthError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Invalid email or password.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
