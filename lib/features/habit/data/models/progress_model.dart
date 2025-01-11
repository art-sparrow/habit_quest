import 'package:freezed_annotation/freezed_annotation.dart';

part 'progress_model.freezed.dart';
part 'progress_model.g.dart';

@freezed
class ProgressModel with _$ProgressModel {
  const factory ProgressModel({
    required int habitId, // Unique ID
    required DateTime date,
    required bool completed,
    required bool synced,
    required String uid, // User ID
    required String email,
  }) = _ProgressModel;

  factory ProgressModel.fromJson(Map<String, dynamic> json) =>
      _$ProgressModelFromJson(json);
}
