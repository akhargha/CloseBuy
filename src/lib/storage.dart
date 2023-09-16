import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> getLocalFile() async {
  final path = await _localPath;
  return File('$path/items.json');
}

void saveItemsToFile(List<Map<String, String>> items) async {
  final file = await getLocalFile();
  await file.writeAsString(jsonEncode(items));
}
