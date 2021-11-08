import 'package:number_trivia/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required String name, required String email})
      : super(name: name, email: email);
}
