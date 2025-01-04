import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_model.freezed.dart';
part 'signup_model.g.dart';

@freezed
class SignUpModel with _$SignUpModel {
  const factory SignUpModel({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String joinedOn,
    required String uid,
    required String fcmToken,
  }) = _SignUpModel;

  factory SignUpModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpModelFromJson(json);
}
