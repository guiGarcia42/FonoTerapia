import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:convert';
import 'dart:math';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Stream that listens to authentication state changes
  Stream<User?> get userStream => _auth.authStateChanges();

  // Fetch the current authenticated user
  User? get currentUser => _auth.currentUser;

  // Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();
      if (googleAccount != null) {
        final GoogleSignInAuthentication googleAuth = await googleAccount.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        return userCredential.user;
      }
    } catch (e) {
      print("Google Sign-In Error: $e");
    }
    return null;
  }

  // Sign in with Apple
  Future<User?> signInWithApple() async {
    try {
      final rawNonce = generateNonce();
      final nonceHash = sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonceHash,
      );

      print(AppleIDAuthorizationScopes.email);

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(oauthCredential);

      print(userCredential.user!.email);

      return userCredential.user;

    } catch (e, stackTrace) {
      print("Apple Sign-In Error: $e");
      print("Stack Trace: $stackTrace");
      return null;
    }
  }

  // Sign out from all services
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    // Handle sign out from Apple if necessary (depends on your application logic)
  }

  // Utility to generate a secure nonce
  String generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  // Utility to hash a string using SHA-256
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}