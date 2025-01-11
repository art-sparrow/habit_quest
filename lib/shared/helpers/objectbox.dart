import 'package:habit_quest/features/auth/data/models/signup_objectbox.dart';
import 'package:habit_quest/features/habit/data/models/habit_objectbox.dart';
import 'package:habit_quest/features/habit/data/models/progress_objectbox.dart';
import 'package:habit_quest/objectbox.g.dart'; // Import generated code
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ObjectBox {
  ObjectBox._create(this.store);
  late final Store store;

  // Initialize the ObjectBox store
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Use the generated `openStore()` method
    final store = await openStore(directory: p.join(docsDir.path, 'objectbox'));
    return ObjectBox._create(store);
  }

  // Access the Box for SignUpEntity
  Box<SignUpEntity> get signUpBox => store.box<SignUpEntity>();
  // Access the Box for HabitEntity
  Box<HabitEntity> get habitBox => store.box<HabitEntity>();
  // Access the Box for ProgressEntity
  Box<ProgressEntity> get progressBox => store.box<ProgressEntity>();
}
