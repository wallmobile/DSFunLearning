import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart' as ap;
import 'screens/splash_screen.dart';

bool _firebaseReady = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    _firebaseReady = true;
  } catch (_) {
    _firebaseReady = false;
  }
  runApp(DSFunLearningApp(firebaseReady: _firebaseReady));
}

class DSFunLearningApp extends StatelessWidget {
  final bool firebaseReady;
  const DSFunLearningApp({super.key, required this.firebaseReady});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ap.AuthProvider())],
      child: MaterialApp(
        title: 'DS Fun Learning',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF4A6CF7),
            brightness: Brightness.light,
          ),
          scaffoldBackgroundColor: const Color(0xFFF5F7FF),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Color(0xFF4A6CF7),
            foregroundColor: Colors.white,
          ),
        ),
        home: firebaseReady ? const SplashScreen() : const _FirebaseSetupScreen(),
      ),
    );
  }
}

class _FirebaseSetupScreen extends StatelessWidget {
  const _FirebaseSetupScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4A6CF7), Color(0xFF6A3DE8)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('🔧', style: TextStyle(fontSize: 64)),
                const SizedBox(height: 24),
                const Text(
                  'Firebase Setup Required',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Step(n: '1', text: 'Go to console.firebase.google.com\nSign in as developer.techotd@gmail.com'),
                      _Step(n: '2', text: 'Create project "ds-fun-learning"\nEnable Auth (Email + Google) & Firestore'),
                      _Step(n: '3', text: 'Install FlutterFire CLI:\ndart pub global activate flutterfire_cli'),
                      _Step(n: '4', text: 'Run in terminal:\nflutterfire configure --account developer.techotd@gmail.com'),
                      _Step(n: '5', text: 'Rebuild & run the app'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'See FIREBASE_SETUP.md in the project root for full details.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Step extends StatelessWidget {
  final String n;
  final String text;
  const _Step({required this.n, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                n,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
