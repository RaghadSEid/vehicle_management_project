import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class StorageService {
  Future<String> _getPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _getFile(String fileName) async {
    final path = await _getPath();
    return File('$path/$fileName.json');
  }

  Future<void> saveList(String name, List list) async {
    final file = await _getFile(name);
    final jsonList = list.map((e) => e.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await file.writeAsString(jsonString);
  }

  Future<List> loadList(String name, Function fromJson) async {
    final file = await _getFile(name);
    if (!await file.exists()) {
      return [];
    }
    final jsonString = await file.readAsString();
    final List data = jsonDecode(jsonString);
    return data.map((e) => fromJson(e)).toList();
  }
}
