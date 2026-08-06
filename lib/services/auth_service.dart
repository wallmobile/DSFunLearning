import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'firestore_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  // ── Email / Password ──────────────────────────────────────────────────────
  Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
    String? referralCode,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await cred.user!.updateDisplayName(displayName);
    await FirestoreService().createUserDocument(
      uid: cred.user!.uid,
      email: email,
      displayName: displayName,
      referredBy: referralCode,
    );
    return cred;
  }

  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    await FirestoreService().updateLastActive(cred.user!.uid);
    return cred;
  }

  // ── Google Sign-In ────────────────────────────────────────────────────────
  Future<UserCredential?> signInWithGoogle({String? referralCode}) async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final cred = await _auth.signInWithCredential(credential);

    // Create Firestore doc only on first sign-in
    if (cred.additionalUserInfo?.isNewUser ?? false) {
      await FirestoreService().createUserDocument(
        uid: cred.user!.uid,
        email: cred.user!.email ?? '',
        displayName: cred.user!.displayName ?? 'User',
        photoUrl: cred.user!.photoURL,
        referredBy: referralCode,
      );
    } else {
      await FirestoreService().updateLastActive(cred.user!.uid);
    }
    return cred;
  }

  // ── Password Reset ────────────────────────────────────────────────────────
  Future<void> sendPasswordReset(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    await Future.wait([_auth.signOut(), _googleSignIn.signOut()]);
  }
}
