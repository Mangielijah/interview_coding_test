import 'package:firebase_database/firebase_database.dart' as database;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final databaseServiceProvider =
    Provider<DatabaseService>((_) => DatabaseService());

class DatabaseService {
  final database.FirebaseDatabase _database =
      database.FirebaseDatabase.instance;
  Future<void> saveUserCount(String uid, int count) async {
    return _database.reference().child(uid).set(count);
  }

  Future<int?> getUserCount(uid) async {
    database.DataSnapshot snapshot =
        await _database.reference().child(uid).once();
    return snapshot.value;
  }
}
