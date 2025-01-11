import 'package:objectbox/objectbox.dart';

@Entity()
class ProgressEntity {
  ProgressEntity({
    required this.habitId,
    required this.date,
    required this.uid,
    required this.email,
    this.id = 0,
    this.completed = false,
    this.synced = false,
  });

  @Id()
  int id;

  int habitId; // Foreign key referencing HabitEntity
  DateTime date;
  bool completed;
  bool synced;

  // User identification
  String uid;
  String email;
}
