import 'dart:developer';

import 'package:habit_quest/features/auth/data/models/signup_model.dart';
import 'package:habit_quest/features/auth/data/models/signup_objectbox.dart';
import 'package:habit_quest/objectbox.g.dart';
import 'package:habit_quest/shared/extensions/auth_extensions.dart';
import 'package:habit_quest/shared/helpers/objectbox.dart';

class AuthObjectBox {
  AuthObjectBox({required this.objectBox});

  final ObjectBox objectBox;

  Future<void> saveUserData(SignUpModel model) async {
    final modelEntity = model.toEntity();
    final entity = SignUpEntity(
      name: modelEntity.name,
      phone: modelEntity.phone,
      email: modelEntity.email,
      joinedOn: modelEntity.joinedOn,
      uid: modelEntity.uid,
      fcmToken: modelEntity.fcmToken,
    );
    objectBox.signUpBox.put(entity);
    log('User data saved to signUpBox: $entity');
  }

  Future<SignUpModel?> getUserData(String uid) async {
    final entity = objectBox.signUpBox
        .query(
          SignUpEntity_.uid.equals(uid),
        )
        .build()
        .findFirst();
    if (entity == null) return null;
    return SignUpModel(
      name: entity.name,
      phone: entity.phone,
      email: entity.email,
      password: '',
      joinedOn: entity.joinedOn,
      uid: entity.uid,
      fcmToken: entity.fcmToken,
    );
  }
}
