// lib/data/local/app_database.dart

import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'tables.dart';
part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir  = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'db.sqlite'));
    return NativeDatabase(file, logStatements: true);
  });
}

@DriftDatabase(tables: [UsersModel, MenuItemModel])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // ¡Incrementa esto cada vez que cambies tablas!
  @override
  int get schemaVersion => 2;

  // Aquí indicas a Drift cómo pasar de la versión 1 → 2
  @override
  MigrationStrategy get migration => MigrationStrategy(
    // Si no existía la base, crea todo el esquema
    onCreate: (migrator) async {
      await migrator.createAll();
    },
    // Al actualizar de versiones
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        // Creamos la tabla que acabamos de añadir
        await migrator.createTable(menuItemModel);
      }
      // Si en el futuro llegas a v3, aquí pondrías:
      // if (from < 3) { ... }
    },
    // (opcional) limpia datos obsoletos antes de abrir
    beforeOpen: (details) async {
      if (details.hadUpgrade) {
        // puedes ejecutar un PRAGMA foreign_keys = ON; u otras tareas
      }
    },
  );
}
