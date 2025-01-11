import 'package:equatable/equatable.dart';

class ProgressEntity extends Equatable {
  const ProgressEntity({
    required this.habitId, // Unique ID
    required this.date,
    required this.completed,
    required this.synced,
    required this.uid, // User ID
    required this.email,
  });

  final int habitId;
  final DateTime date;
  final bool completed;
  final bool synced;
  final String uid;
  final String email;

  @override
  List<Object?> get props => [
        habitId,
        date,
        completed,
        synced,
        uid,
        email,
      ];
}
