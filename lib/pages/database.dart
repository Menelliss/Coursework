import 'package:postgres/postgres.dart';
import 'dart:async';
import 'package:bcrypt/bcrypt.dart';

class Database {
  final PostgreSQLConnection conn;

  Database(this.conn);

  Future<void> open() async {
    await conn.open();
  }

  Future<void> close() async {
    await conn.close();
  }

  Future<int> checkEmail(String email) async {
    final result = await conn.query(
      '''
    SELECT COUNT(*) FROM "User_reg"
    WHERE email = @email
    ''',
      substitutionValues: {
        'email': email,
      },
    );

    if (result.isNotEmpty && result.first[0] > 0) {
      return 0;
    }

    return 1;
  }

  Future<void> registration(String email, String password, String username, String number) async {
    String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
    await conn.query(
        'INSERT INTO "User_reg" (email, password, username, number) VALUES (@email, @password, @username, @number)',
        substitutionValues: {
          'email': email,
          'password': hashedPassword,
          'username': username,
          'number': number,
        } as Map<String, dynamic>
    );
  }

  Future<int> getUserIdByEmail(String email) async {
      final results = await conn.query(
        'SELECT id FROM "User_reg" WHERE email = @email',
        substitutionValues: {
          'email': email,
        },
      );
      return results.first[0] as int;
  }

  Future<String> getUserNameByEmail(String email) async {
      final results = await conn.query(
        'SELECT username FROM "User_reg" WHERE email = @email',
        substitutionValues: {
          'email': email,
        },
      );
      return results.first[0];
  }

  Future<String> getUserNumberByEmail(String email) async {
      final results = await conn.query(
        'SELECT number FROM "User_reg" WHERE email = @email',
        substitutionValues: {
          'email': email,
        },
      );
      return results.first[0];
  }

  Future<int> checkUserLogin(String email, String password) async {
    final result = await conn.query(
      'SELECT password FROM "User_reg" WHERE email = @email',
      substitutionValues: {
        'email': email,
      },
    );

    if (result.isNotEmpty) {
      final storedPasswordHash = result.first[0] as String;

      if (BCrypt.checkpw(password, storedPasswordHash)) {
        return 0;
      }
    }
    return 1;
  }

  Future<List<Map<String, dynamic>>> getRowsLost() async {
    final results = await conn.query(
        'SELECT * FROM "Lost_things" WHERE status = false ORDER BY id'
    );

    return results.map((row) {
      return {
        'title': row[2],
        'lost_date': row[3],
        'time_1': row[4].toString(),
        'time_2': row[5].toString(),
        'description' : row[6],
        'address' : row[7],
        'number' : row[8],
      };
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getRowsFind() async {
    final results = await conn.query(
        'SELECT * FROM "Find_things" WHERE status = false ORDER BY id'
    );

    return results.map((row) {
      return {
        'title': row[2],
        'find_date': row[3],
        'time_1': row[4].toString(),
        'time_2': row[5].toString(),
        'description' : row[6],
        'address' : row[7],
        'number' : row[8],
      };
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getRowsContainingTitle(String word) async {
    final results = await conn.query(
      'SELECT * FROM "Lost_things" WHERE title ILIKE @word',
      substitutionValues: {
        'word': '%$word%',
      },
    );
    return results.map((row) {
      return {
        'title': row[0],
        'lost_date': row[1],
        'time_1': row[2],
        'time_2': row[3],
        'description' : row[4],
        'image' : row[5],
      };
    }).toList();
  }

  Future<void> lostThingAdd(int userid, String title, DateTime lostDate, String time1, String time2, String description, String address, String number) async {
    await conn.query(
        'INSERT INTO "Lost_things" (user_id, title, lost_date, time_1, time_2, description, address, number, image) VALUES (@user_id, @title, @lost_date, @time_1, @time_2, @description, @address, @number, @image)',
        substitutionValues: {
          'user_id': userid,
          'title': title,
          'lost_date': lostDate,
          'time_1': time1,
          'time_2': time2,
          'description': description,
          'address': address,
          'number': number,
          'image': '',
        } as Map<String, dynamic>
    );
  }

  Future<void> findThingAdd(int userid, String title, DateTime findDate, String time1, String time2, String description, String address, String number ) async {
    await conn.query(
        'INSERT INTO "Find_things" (user_id, title, find_date, time_1, time_2, description, address, number, image) VALUES (@user_id, @title, @find_date, @time_1, @time_2, @description, @address, @number, @image)',
        substitutionValues: {
          'user_id': userid,
          'title': title,
          'find_date': findDate,
          'time_1': time1,
          'time_2': time2,
          'description': description,
          'address': address,
          'number': number,
          'image': '',
        } as Map<String, dynamic>
    );
  }

  Future<int> getUserAvatarByEmail(String email) async {
      final results = await conn.query(
        'SELECT avatar FROM "User_reg" WHERE email = @email',
        substitutionValues: {
          'email': email,
        },
      );
      return results.first[0];
  }

  Future<void> changeAvatar(String email, int avatar) async {
    await conn.query(
      'UPDATE "User_reg" SET avatar = @avatar WHERE email = @email',
      substitutionValues: {
        'avatar': avatar,
        'email': email,
      },
    );
  }
}
