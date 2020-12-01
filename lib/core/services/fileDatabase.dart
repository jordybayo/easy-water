
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileDatabase{
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localFile async {
    final path = await _localPath;
    return File('$path/config.eaw');
  }

  Future<File> writeDbFile(int vWalkthrough, int vLogin) async {
    final file = await this.localFile;

    // Write the file.
    //return file.writeAsString('$variable');
    file.writeAsBytesSync([vWalkthrough, vLogin]);
  }

  Future<List> readDbFile() async {
    try {
      final file = await this.localFile;

      // Read the file.
      // String contents = await file.readAsString();
      List contents = await file.readAsBytesSync();
      /* 1. bool if viewed walkthrough
      *  2. bool if logged
      * */
      // return int.parse(contents);
      return contents;
    } catch (e) {
      // If encountering an error, return 0.
      return [0, 0];
    }
  }
}