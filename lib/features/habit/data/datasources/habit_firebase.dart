// ignore_for_file: lines_longer_than_80_chars

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habit_quest/features/habit/data/models/habit_model.dart';
import 'package:habit_quest/features/habit/data/models/progress_model.dart';

class HabitFirebase {
  HabitFirebase({
    required this.firebaseAuth,
    required this.firestore,
  });

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  // Create a new habit in Firestore
  Future<void> createHabit(HabitModel habit) async {
    try {
      await firestore
          .collection('habits')
          .doc('${habit.uid}_${habit.habitId}')
          .set(habit.toJson());
    } catch (e) {
      throw Exception('Failed to create habit: $e');
    }
  }

  // Update an existing habit in Firestore
  Future<void> updateHabit(HabitModel habit) async {
    try {
      await firestore
          .collection('habits')
          .doc('${habit.uid}_${habit.habitId}')
          .update(habit.toJson());
    } catch (e) {
      throw Exception('Failed to update habit: $e');
    }
  }

  // Delete a habit from Firestore
  Future<void> deleteHabit(int habitId, String uid) async {
    try {
      await firestore.collection('habits').doc('${uid}_$habitId').delete();
    } catch (e) {
      throw Exception('Failed to delete habit: $e');
    }
  }

  // Fetch habits for the current user
  Future<List<HabitModel>> fetchHabits(String uid) async {
    try {
      final snapshot = await firestore
          .collection('habits')
          .where('uid', isEqualTo: uid)
          .get();
      return snapshot.docs
          .map((doc) => HabitModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch habits: $e');
    }
  }

  // Create a new progress entry in Firestore
  Future<void> createProgress(ProgressModel progress) async {
    try {
      await firestore
          .collection('progress')
          .doc(
            '${progress.uid}_${progress.habitId}_${progress.date.toIso8601String()}',
          )
          .set(progress.toJson());
    } catch (e) {
      throw Exception('Failed to create progress: $e');
    }
  }

  // Fetch progress for a specific habit
  Future<List<ProgressModel>> fetchProgress(int habitId, String uid) async {
    try {
      final snapshot = await firestore
          .collection('progress')
          .where('uid', isEqualTo: uid)
          .where('habitId', isEqualTo: habitId)
          .get();
      return snapshot.docs
          .map((doc) => ProgressModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch progress: $e');
    }
  }
}
