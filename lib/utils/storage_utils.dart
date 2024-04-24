import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';

class StorageUtils {
  static final StorageUtils _instance = StorageUtils._internal();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  factory StorageUtils() {
    return _instance;
  }

  StorageUtils._internal();

  Future<String?> uploadImage(String folderName) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      File imageFile = File(result.files.single.path!);
      String fileName = basename(imageFile.path);
      Reference reference = _storage.ref().child(folderName).child(fileName);
      UploadTask uploadTask = reference.putFile(imageFile);

      TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
      return await snapshot.ref.getDownloadURL();
    } else {
      return null;
    }
  }

  Future<String?> uploadPDF(String folderName) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File pdfFile = File(result.files.single.path!);
      String fileName = basename(pdfFile.path);
      Reference reference = _storage.ref().child(folderName).child(fileName);
      UploadTask uploadTask = reference.putFile(pdfFile);

      TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
      return await snapshot.ref.getDownloadURL();
    } else {
      return null;
    }
  }
}