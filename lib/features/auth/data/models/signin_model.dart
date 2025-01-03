import 'package:freezed_annotation/freezed_annotation.dart';

part 'signin_model.freezed.dart';
part 'signin_model.g.dart';

@freezed
class SignInModel with _$SignInModel {
  const factory SignInModel({
    required String email,
    required String password,
  }) = _SignInModel;

  factory SignInModel.fromJson(Map<String, dynamic> json) =>
      _$SignInModelFromJson(json);
}
