import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageMethod{

  Future<String> uploadImageToFirebase(image) async {
    String fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
    try {
      TaskSnapshot snapshot = await FirebaseStorage.instance
          .ref()
          .child('images/$fileName')
          .putFile(image);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print(e.toString());
      return "error when uploading Image";
    }
  }

  Future<String> uploadPDF(File file) async {
    try {
      String filePath = 'pdfs/${file.path.split('/').last}'; // The path in your Firebase Storage bucket where you want to store the file
      Reference storageRef = FirebaseStorage.instance.ref().child(filePath);
      await storageRef.putFile(file);
      String downloadURL = await storageRef.getDownloadURL();
      return downloadURL;
    }on FirebaseException catch(error){
      print('Error uploading PDF file: $error');
      print("********************************************************************************");
      return "error when uploading file from fire base";
    } catch (error) {
      print('Error uploading PDF file: $error');
      print("-------------------------------------------------------------------------------------------");

      return "error when uploading file";
    }
  }

}