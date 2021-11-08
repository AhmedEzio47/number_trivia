import 'package:firebase_auth/firebase_auth.dart';
import 'package:number_trivia/core/errors/exceptions.dart';
import 'package:number_trivia/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> register(
      {required String email, required String password, required String name});
  Future<UserModel> fetchUser();
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  AuthRemoteDataSourceImpl({required this.firebaseAuth});

  @override
  Future<UserModel> login(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        UserModel userModel = UserModel(
            name: userCredential.user?.displayName ?? '',
            email: userCredential.user?.email ?? '');
        return userModel;
      } else {
        throw ServerException();
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException(errorCode: e.code, errorMessage: e.message);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> register(
      {required String email,
      required String password,
      required String name}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        await userCredential.user?.updateDisplayName(name);
        User? user = firebaseAuth.currentUser;
        UserModel userModel =
            UserModel(name: user?.displayName ?? '', email: user?.email ?? '');
        return userModel;
      } else {
        throw ServerException();
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException(errorCode: e.code, errorMessage: e.message);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> fetchUser() async {
    try {
      User? user = firebaseAuth.currentUser;
      if (user != null) {
        UserModel userModel =
            UserModel(name: user.displayName ?? '', email: user.email ?? '');
        return userModel;
      } else {
        throw ServerException();
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException(errorCode: e.code, errorMessage: e.message);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> logout() async {
    try {
      firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw ServerException(errorCode: e.code, errorMessage: e.message);
    } catch (e) {
      throw ServerException();
    }
  }
}
