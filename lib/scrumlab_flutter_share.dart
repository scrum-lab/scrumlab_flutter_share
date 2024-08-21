import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class Share {
  static const MethodChannel _channel = const MethodChannel(
      'channel:github.com/orgs/scrum-lab/scrumlab-flutter-share');

  /// Sends a text to other apps.
  static Future<void> text(String title, String text, String mimeType) async {
    Map<String, String> argsMap = <String, String>{
      'title': title,
      'text': text,
      'mimeType': mimeType
    };
    await _channel.invokeMethod('text', argsMap);
  }

  /// Sends a file to other apps.
  static Future<void> file(
      String title, String name, List<int> bytes, String mimeType,
      {String text = ''}) async {
    Map<String, String> argsMap = <String, String>{
      'title': title,
      'name': name,
      'mimeType': mimeType,
      'text': text
    };

    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/$name').create();
    await file.writeAsBytes(bytes);

    await _channel.invokeMethod('file', argsMap);
  }

  /// Sends multiple files to other apps.
  static Future<void> files(
      String title, Map<String, List<int>> files, String mimeType,
      {String text = ''}) async {
    Map<String, dynamic> argsMap = <String, dynamic>{
      'title': title,
      'names': files.keys.toList(),
      'mimeType': mimeType,
      'text': text
    };

    final tempDir = await getTemporaryDirectory();

    for (var entry in files.entries) {
      final file = await File('${tempDir.path}/${entry.key}').create();
      await file.writeAsBytes(entry.value);
    }

    await _channel.invokeMethod('files', argsMap);
  }
}
