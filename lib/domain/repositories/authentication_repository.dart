import 'package:autom_app_registration/domain/cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../data/models/user_model.dart';

class SignUpFailure implements Exception {}

class ConfirmCode implements Exception {}

class AuthenticationRepository {
  AuthenticationRepository(
      {firebase_auth.FirebaseAuth? firebaseAuth, CacheClient? cacheClient})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _cache = cacheClient ?? CacheClient();

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final CacheClient _cache;
  static const userCacheKey = '__user_cache_key__';
  String _verify = '';
  int? _resendToken;

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }

  User get currentUser {
    return _cache.read<User>(key: userCacheKey) ?? User.empty;
  }

  Future<void> getSMSCode({required String phoneNumber}) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted:
            (firebase_auth.PhoneAuthCredential credential) async {
          await _firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (firebase_auth.FirebaseAuthException e) {
          throw e;
        },
        codeSent: (String verificationId, int? resendToken) {
          _verify = verificationId;
          _resendToken = resendToken;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on firebase_auth.FirebaseAuthException {
      throw SignUpFailure();
    }
  }

  Future<void> confirmCode({required String code}) async {
    try {
      firebase_auth.PhoneAuthCredential credential =
          firebase_auth.PhoneAuthProvider.credential(
              verificationId: _verify, smsCode: code);

      await _firebaseAuth.signInWithCredential(credential);
    } on firebase_auth.FirebaseAuthException {
      throw ConfirmCode();
    }
  }

  Future<void> resendCode({required String phoneNumber}) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        forceResendingToken: _resendToken,
        phoneNumber: phoneNumber,
        verificationCompleted:
            (firebase_auth.PhoneAuthCredential credential) async {
          await _firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (firebase_auth.FirebaseAuthException e) {
          throw e;
        },
        codeSent: (String verificationId, int? resendToken) {
          _verify = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on firebase_auth.FirebaseAuthException {
      throw SignUpFailure();
    }
  }

  Future<void> logOut() async {
    await Future.wait([_firebaseAuth.signOut()]);
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid);
  }
}
