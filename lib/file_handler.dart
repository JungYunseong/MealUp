import 'dart:convert';
import 'dart:io';

import 'package:meal_up/model/intakes.dart';
import 'package:path_provider/path_provider.dart';

class FileHandler {
  FileHandler._privateConstructor();
  static final FileHandler instance = FileHandler._privateConstructor();

  static File? _file;

  static const _fileName = 'user_file.txt';

  Future<File> get file async {
    if (_file != null) return _file!;

    _file = await _initFile();
    return _file!;
  }

  Future<File> _initFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    return File('$path/$_fileName');
  }

  static Set<Intakes> intakesSet = {};

  Future<void> writeIntakes(Intakes intakes) async {
    final File fl = await file;
    intakesSet.add(intakes);

    final userListMap = intakesSet.map((e) => e.toJson()).toList();

    await fl.writeAsString(jsonEncode(userListMap));
  }

  Future<List<Intakes>> readIntakes() async {
    final File fl = await file;
    final content = await fl.readAsString();

    final List<dynamic> jsonData = jsonDecode(content);
    final List<Intakes> intakes = jsonData
        .map(
          (e) => Intakes.fromJson(e as Map<String, dynamic>),
        )
        .toList();
    return intakes;
  }

  Future<void> deleteUser(Intakes intakes) async {
    final File fl = await file;

    intakesSet.removeWhere((e) => e == intakes);
    final intakeListMap = intakesSet.map((e) => e.toJson()).toList();

    await fl.writeAsString(jsonEncode(intakeListMap));
  }

  Future<void> updateUser({
    required int id,
    required Intakes updatedIntakes,
  }) async {
    intakesSet.removeWhere((e) => e.id == updatedIntakes.id);
    await writeIntakes(updatedIntakes);
  }
}
