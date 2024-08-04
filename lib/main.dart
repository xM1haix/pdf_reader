import 'dart:io';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'package:uri_to_file/uri_to_file.dart';
import 'home.dart';
import 'view.dart';

Future<File?> getFileFromUri(String? uriString) async {
  try {
    if (uriString != null) {
      return await toFile(uriString);
    }
  } catch (e) {
    return null;
  }
  return null;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await clearTemporaryFiles();
  String? uriString = await getInitialLink();
  File? file;
  try {
    if (uriString != null) {
      file = await getFileFromUri(uriString);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  runApp(MyApp(file));
}

class MyApp extends StatefulWidget {
  final File? file;
  const MyApp(this.file, {super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: (widget.file != null)
          ? widget.file!.path.split('.').last.toLowerCase() == 'pdf'
              ? ViewPage(widget.file!.path)
              : const Home()
          : const Home(),
    );
  }
}
