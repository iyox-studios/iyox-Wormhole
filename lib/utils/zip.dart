import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pick_or_save/pick_or_save.dart';
import 'package:uri_content/uri_content.dart';

Stream<ZipProgress> zipFolder(String folderUri, List<DocumentFile> files) async* {
  final archive = Archive();
  final folderName = Uri.parse(folderUri).pathSegments.last.split(':').last.split('/').last;
  final totalFiles = files.length;
  int processedFiles = 0;

  for (final file in files) {
    final fileName =
        Uri.parse(file.uri).pathSegments.last.split(':').last.substring(folderName.length);

    if (file.isDirectory) {
      archive.add(ArchiveFile.directory(fileName));
      processedFiles++;
      yield ZipProgress(processedFiles: processedFiles, totalFiles: totalFiles, zipFilePath: null);
      continue;
    }

    final bytes = await readFileBytes(file.uri);
    archive.add(ArchiveFile(fileName, bytes.lengthInBytes, bytes));
    processedFiles++;
    yield ZipProgress(processedFiles: processedFiles, totalFiles: totalFiles, zipFilePath: null);
  }

  final zipBytes = ZipEncoder().encode(archive);
  final tempDir = await getTemporaryDirectory();
  final zipFile = File('${tempDir.path}/$folderName.zip');
  await zipFile.writeAsBytes(zipBytes);
  yield ZipProgress(processedFiles: totalFiles, totalFiles: totalFiles, zipFilePath: zipFile.path);
}

Future<Uint8List> readFileBytes(String uriString) async {
  //final content = await ContentResolver.resolveContent(uri);
  //final bytes = content.data;
  final uri = Uri.parse(uriString);
  final content = await uri.getContent();

  return content;
}

class ZipProgress {
  final int processedFiles;
  final int totalFiles;
  final String? zipFilePath;

  ZipProgress({required this.processedFiles, required this.totalFiles, this.zipFilePath});
}
