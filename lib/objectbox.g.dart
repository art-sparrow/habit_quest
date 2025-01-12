// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again
// with `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:habit_quest/features/auth/data/models/signup_objectbox.dart';
import 'package:habit_quest/features/habit/data/models/habit_objectbox.dart';
import 'package:habit_quest/features/habit/data/models/progress_objectbox.dart';
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
    id: const obx_int.IdUid(1, 6097746650099591581),
    name: 'SignUpEntity',
    lastPropertyId: const obx_int.IdUid(7, 455850070869920379),
    flags: 0,
    properties: <obx_int.ModelProperty>[
      obx_int.ModelProperty(
        id: const obx_int.IdUid(1, 5881732214593905184),
        name: 'id',
        type: 6,
        flags: 1,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(2, 3015474243489475691),
        name: 'name',
        type: 9,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(3, 4584925641497610420),
        name: 'phone',
        type: 9,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(4, 2529381364971740421),
        name: 'email',
        type: 9,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(5, 4852999366518805700),
        name: 'joinedOn',
        type: 9,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(6, 1661644909567516600),
        name: 'uid',
        type: 9,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(7, 455850070869920379),
        name: 'fcmToken',
        type: 9,
        flags: 0,
      ),
    ],
    relations: <obx_int.ModelRelation>[],
    backlinks: <obx_int.ModelBacklink>[],
  ),
  obx_int.ModelEntity(
    id: const obx_int.IdUid(2, 1465892337140245005),
    name: 'HabitEntity',
    lastPropertyId: const obx_int.IdUid(10, 1091668921416905677),
    flags: 0,
    properties: <obx_int.ModelProperty>[
      obx_int.ModelProperty(
        id: const obx_int.IdUid(1, 3563573197047396683),
        name: 'id',
        type: 6,
        flags: 1,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(2, 7391214662862301184),
        name: 'habitId',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(3, 7413798244599457794),
        name: 'name',
        type: 9,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(4, 7897907600445817444),
        name: 'description',
        type: 9,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(5, 6038520595145540244),
        name: 'frequency',
        type: 9,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(6, 942067235152536468),
        name: 'startDate',
        type: 10,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(7, 7029794377243375676),
        name: 'endDate',
        type: 10,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(8, 3101632517757302508),
        name: 'synced',
        type: 1,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(9, 4575807872351939050),
        name: 'uid',
        type: 9,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(10, 1091668921416905677),
        name: 'email',
        type: 9,
        flags: 0,
      ),
    ],
    relations: <obx_int.ModelRelation>[],
    backlinks: <obx_int.ModelBacklink>[],
  ),
  obx_int.ModelEntity(
    id: const obx_int.IdUid(3, 3329002344210227593),
    name: 'ProgressEntity',
    lastPropertyId: const obx_int.IdUid(7, 2140353204069064342),
    flags: 0,
    properties: <obx_int.ModelProperty>[
      obx_int.ModelProperty(
        id: const obx_int.IdUid(1, 3412432252258581399),
        name: 'id',
        type: 6,
        flags: 1,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(2, 2843921930515978986),
        name: 'habitId',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(3, 7437987854268039898),
        name: 'date',
        type: 10,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(4, 5572936755527715433),
        name: 'completed',
        type: 1,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(5, 1486155371263118949),
        name: 'synced',
        type: 1,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(6, 4272115938544525019),
        name: 'uid',
        type: 9,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(7, 2140353204069064342),
        name: 'email',
        type: 9,
        flags: 0,
      ),
    ],
    relations: <obx_int.ModelRelation>[],
    backlinks: <obx_int.ModelBacklink>[],
  ),
];

/// Shortcut for [obx.Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [obx.Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
Future<obx.Store> openStore({
  String? directory,
  int? maxDBSizeInKB,
  int? maxDataSizeInKB,
  int? fileMode,
  int? maxReaders,
  bool queriesCaseSensitiveDefault = true,
  String? macosApplicationGroup,
}) async {
  await loadObjectBoxLibraryAndroidCompat();
  return obx.Store(
    getObjectBoxModel(),
    directory: directory ?? (await defaultStoreDirectory()).path,
    maxDBSizeInKB: maxDBSizeInKB,
    maxDataSizeInKB: maxDataSizeInKB,
    fileMode: fileMode,
    maxReaders: maxReaders,
    queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
    macosApplicationGroup: macosApplicationGroup,
  );
}

/// Returns the ObjectBox model definition for this project for use with
/// [obx.Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
    entities: _entities,
    lastEntityId: const obx_int.IdUid(3, 3329002344210227593),
    lastIndexId: const obx_int.IdUid(0, 0),
    lastRelationId: const obx_int.IdUid(0, 0),
    lastSequenceId: const obx_int.IdUid(0, 0),
    retiredEntityUids: const [],
    retiredIndexUids: const [],
    retiredPropertyUids: const [],
    retiredRelationUids: const [],
    modelVersion: 5,
    modelVersionParserMinimum: 5,
    version: 1,
  );

  final bindings = <Type, obx_int.EntityDefinition>{
    SignUpEntity: obx_int.EntityDefinition<SignUpEntity>(
      model: _entities[0],
      toOneRelations: (SignUpEntity object) => [],
      toManyRelations: (SignUpEntity object) => {},
      getId: (SignUpEntity object) => object.id,
      setId: (SignUpEntity object, int id) {
        object.id = id;
      },
      objectToFB: (SignUpEntity object, fb.Builder fbb) {
        final nameOffset = fbb.writeString(object.name);
        final phoneOffset = fbb.writeString(object.phone);
        final emailOffset = fbb.writeString(object.email);
        final joinedOnOffset = fbb.writeString(object.joinedOn);
        final uidOffset = fbb.writeString(object.uid);
        final fcmTokenOffset = fbb.writeString(object.fcmToken);
        fbb.startTable(8);
        fbb.addInt64(0, object.id);
        fbb.addOffset(1, nameOffset);
        fbb.addOffset(2, phoneOffset);
        fbb.addOffset(3, emailOffset);
        fbb.addOffset(4, joinedOnOffset);
        fbb.addOffset(5, uidOffset);
        fbb.addOffset(6, fcmTokenOffset);
        fbb.finish(fbb.endTable());
        return object.id;
      },
      objectFromFB: (obx.Store store, ByteData fbData) {
        final buffer = fb.BufferContext(fbData);
        final rootOffset = buffer.derefObject(0);
        final nameParam = const fb.StringReader(asciiOptimization: true)
            .vTableGet(buffer, rootOffset, 6, '');
        final phoneParam = const fb.StringReader(asciiOptimization: true)
            .vTableGet(buffer, rootOffset, 8, '');
        final emailParam = const fb.StringReader(asciiOptimization: true)
            .vTableGet(buffer, rootOffset, 10, '');
        final joinedOnParam = const fb.StringReader(asciiOptimization: true)
            .vTableGet(buffer, rootOffset, 12, '');
        final uidParam = const fb.StringReader(asciiOptimization: true)
            .vTableGet(buffer, rootOffset, 14, '');
        final fcmTokenParam = const fb.StringReader(asciiOptimization: true)
            .vTableGet(buffer, rootOffset, 16, '');
        final object = SignUpEntity(
          name: nameParam,
          phone: phoneParam,
          email: emailParam,
          joinedOn: joinedOnParam,
          uid: uidParam,
          fcmToken: fcmTokenParam,
        )..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);

        return object;
      },
    ),
    HabitEntity: obx_int.EntityDefinition<HabitEntity>(
      model: _entities[1],
      toOneRelations: (HabitEntity object) => [],
      toManyRelations: (HabitEntity object) => {},
      getId: (HabitEntity object) => object.id,
      setId: (HabitEntity object, int id) {
        object.id = id;
      },
      objectToFB: (HabitEntity object, fb.Builder fbb) {
        final nameOffset = fbb.writeString(object.name);
        final descriptionOffset = fbb.writeString(object.description);
        final frequencyOffset = fbb.writeString(object.frequency);
        final uidOffset = fbb.writeString(object.uid);
        final emailOffset = fbb.writeString(object.email);
        fbb.startTable(11);
        fbb.addInt64(0, object.id);
        fbb.addInt64(1, object.habitId);
        fbb.addOffset(2, nameOffset);
        fbb.addOffset(3, descriptionOffset);
        fbb.addOffset(4, frequencyOffset);
        fbb.addInt64(5, object.startDate.millisecondsSinceEpoch);
        fbb.addInt64(6, object.endDate.millisecondsSinceEpoch);
        fbb.addBool(7, object.synced);
        fbb.addOffset(8, uidOffset);
        fbb.addOffset(9, emailOffset);
        fbb.finish(fbb.endTable());
        return object.id;
      },
      objectFromFB: (obx.Store store, ByteData fbData) {
        final buffer = fb.BufferContext(fbData);
        final rootOffset = buffer.derefObject(0);
        final habitIdParam =
            const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
        final nameParam = const fb.StringReader(asciiOptimization: true)
            .vTableGet(buffer, rootOffset, 8, '');
        final frequencyParam = const fb.StringReader(asciiOptimization: true)
            .vTableGet(buffer, rootOffset, 12, '');
        final startDateParam = DateTime.fromMillisecondsSinceEpoch(
          const fb.Int64Reader().vTableGet(buffer, rootOffset, 14, 0),
        );
        final endDateParam = DateTime.fromMillisecondsSinceEpoch(
          const fb.Int64Reader().vTableGet(buffer, rootOffset, 16, 0),
        );
        final uidParam = const fb.StringReader(asciiOptimization: true)
            .vTableGet(buffer, rootOffset, 20, '');
        final emailParam = const fb.StringReader(asciiOptimization: true)
            .vTableGet(buffer, rootOffset, 22, '');
        final idParam =
            const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
        final descriptionParam = const fb.StringReader(asciiOptimization: true)
            .vTableGet(buffer, rootOffset, 10, '');
        final syncedParam =
            const fb.BoolReader().vTableGet(buffer, rootOffset, 18, false);
        final object = HabitEntity(
          habitId: habitIdParam,
          name: nameParam,
          frequency: frequencyParam,
          startDate: startDateParam,
          endDate: endDateParam,
          uid: uidParam,
          email: emailParam,
          id: idParam,
          description: descriptionParam,
          synced: syncedParam,
        );

        return object;
      },
    ),
    ProgressEntity: obx_int.EntityDefinition<ProgressEntity>(
      model: _entities[2],
      toOneRelations: (ProgressEntity object) => [],
      toManyRelations: (ProgressEntity object) => {},
      getId: (ProgressEntity object) => object.id,
      setId: (ProgressEntity object, int id) {
        object.id = id;
      },
      objectToFB: (ProgressEntity object, fb.Builder fbb) {
        final uidOffset = fbb.writeString(object.uid);
        final emailOffset = fbb.writeString(object.email);
        fbb.startTable(8);
        fbb.addInt64(0, object.id);
        fbb.addInt64(1, object.habitId);
        fbb.addInt64(2, object.date.millisecondsSinceEpoch);
        fbb.addBool(3, object.completed);
        fbb.addBool(4, object.synced);
        fbb.addOffset(5, uidOffset);
        fbb.addOffset(6, emailOffset);
        fbb.finish(fbb.endTable());
        return object.id;
      },
      objectFromFB: (obx.Store store, ByteData fbData) {
        final buffer = fb.BufferContext(fbData);
        final rootOffset = buffer.derefObject(0);
        final habitIdParam =
            const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
        final dateParam = DateTime.fromMillisecondsSinceEpoch(
          const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0),
        );
        final uidParam = const fb.StringReader(asciiOptimization: true)
            .vTableGet(buffer, rootOffset, 14, '');
        final emailParam = const fb.StringReader(asciiOptimization: true)
            .vTableGet(buffer, rootOffset, 16, '');
        final idParam =
            const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
        final completedParam =
            const fb.BoolReader().vTableGet(buffer, rootOffset, 10, false);
        final syncedParam =
            const fb.BoolReader().vTableGet(buffer, rootOffset, 12, false);
        final object = ProgressEntity(
          habitId: habitIdParam,
          date: dateParam,
          uid: uidParam,
          email: emailParam,
          id: idParam,
          completed: completedParam,
          synced: syncedParam,
        );

        return object;
      },
    ),
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [SignUpEntity] entity fields to define ObjectBox queries.
class SignUpEntity_ {
  /// See [SignUpEntity.id].
  static final id =
      obx.QueryIntegerProperty<SignUpEntity>(_entities[0].properties[0]);

  /// See [SignUpEntity.name].
  static final name =
      obx.QueryStringProperty<SignUpEntity>(_entities[0].properties[1]);

  /// See [SignUpEntity.phone].
  static final phone =
      obx.QueryStringProperty<SignUpEntity>(_entities[0].properties[2]);

  /// See [SignUpEntity.email].
  static final email =
      obx.QueryStringProperty<SignUpEntity>(_entities[0].properties[3]);

  /// See [SignUpEntity.joinedOn].
  static final joinedOn =
      obx.QueryStringProperty<SignUpEntity>(_entities[0].properties[4]);

  /// See [SignUpEntity.uid].
  static final uid =
      obx.QueryStringProperty<SignUpEntity>(_entities[0].properties[5]);

  /// See [SignUpEntity.fcmToken].
  static final fcmToken =
      obx.QueryStringProperty<SignUpEntity>(_entities[0].properties[6]);
}

/// [HabitEntity] entity fields to define ObjectBox queries.
class HabitEntity_ {
  /// See [HabitEntity.id].
  static final id =
      obx.QueryIntegerProperty<HabitEntity>(_entities[1].properties[0]);

  /// See [HabitEntity.habitId].
  static final habitId =
      obx.QueryIntegerProperty<HabitEntity>(_entities[1].properties[1]);

  /// See [HabitEntity.name].
  static final name =
      obx.QueryStringProperty<HabitEntity>(_entities[1].properties[2]);

  /// See [HabitEntity.description].
  static final description =
      obx.QueryStringProperty<HabitEntity>(_entities[1].properties[3]);

  /// See [HabitEntity.frequency].
  static final frequency =
      obx.QueryStringProperty<HabitEntity>(_entities[1].properties[4]);

  /// See [HabitEntity.startDate].
  static final startDate =
      obx.QueryDateProperty<HabitEntity>(_entities[1].properties[5]);

  /// See [HabitEntity.endDate].
  static final endDate =
      obx.QueryDateProperty<HabitEntity>(_entities[1].properties[6]);

  /// See [HabitEntity.synced].
  static final synced =
      obx.QueryBooleanProperty<HabitEntity>(_entities[1].properties[7]);

  /// See [HabitEntity.uid].
  static final uid =
      obx.QueryStringProperty<HabitEntity>(_entities[1].properties[8]);

  /// See [HabitEntity.email].
  static final email =
      obx.QueryStringProperty<HabitEntity>(_entities[1].properties[9]);
}

/// [ProgressEntity] entity fields to define ObjectBox queries.
class ProgressEntity_ {
  /// See [ProgressEntity.id].
  static final id =
      obx.QueryIntegerProperty<ProgressEntity>(_entities[2].properties[0]);

  /// See [ProgressEntity.habitId].
  static final habitId =
      obx.QueryIntegerProperty<ProgressEntity>(_entities[2].properties[1]);

  /// See [ProgressEntity.date].
  static final date =
      obx.QueryDateProperty<ProgressEntity>(_entities[2].properties[2]);

  /// See [ProgressEntity.completed].
  static final completed =
      obx.QueryBooleanProperty<ProgressEntity>(_entities[2].properties[3]);

  /// See [ProgressEntity.synced].
  static final synced =
      obx.QueryBooleanProperty<ProgressEntity>(_entities[2].properties[4]);

  /// See [ProgressEntity.uid].
  static final uid =
      obx.QueryStringProperty<ProgressEntity>(_entities[2].properties[5]);

  /// See [ProgressEntity.email].
  static final email =
      obx.QueryStringProperty<ProgressEntity>(_entities[2].properties[6]);
}
