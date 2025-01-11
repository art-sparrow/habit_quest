import 'package:equatable/equatable.dart';

class HabitEntity extends Equatable {
  const HabitEntity({
    required this.habitId, // Unique ID
    required this.name,
    required this.description,
    required this.frequency,
    required this.startDate,
    required this.endDate,
    required this.synced,
    required this.uid, // User ID
    required this.email,
  });

  final int habitId;
  final String name;
  final String description;
  final String frequency;
  final DateTime startDate;
  final DateTime endDate;
  final bool synced;
  final String uid;
  final String email;

  @override
  List<Object?> get props => [
        habitId,
        name,
        description,
        frequency,
        startDate,
        endDate,
        synced,
        uid,
        email,
      ];
}
