import 'package:objectbox/objectbox.dart';

@Entity()
class HabitEntity {
  HabitEntity({
    required this.habitId,
    required this.name,
    required this.frequency,
    required this.startDate,
    required this.endDate,
    required this.uid,
    required this.email,
    this.id = 0,
    this.description = '',
    this.synced = false,
  });

  @Id()
  int id;

  // Habit identification
  int habitId;
  String name;
  String description;
  String frequency;
  DateTime startDate;
  DateTime endDate;
  bool synced;

  // User identification
  String uid;
  String email;
}
