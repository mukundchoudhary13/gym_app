import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  create(
      String collectionName,
      String documentName,
      String firstname,
      String lastname,
      String gender,
      int age,
      String phoneNumber,
      String careGiverFirstName,
      String careGiverLastName,
      String careGiverPhoneNo) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(documentName)
        .set({
      'firstname': firstname,
      'lastname': lastname,
      'gender': gender,
      'age': age,
      'UserPhoneNumber': phoneNumber,
      'CareGiverFirstName': careGiverFirstName,
      'CareGiverLastName': careGiverLastName,
      'CareGiverPhoneno': careGiverPhoneNo,
      'Bluetooth MAC Address': "00:00:00:00:00:00",
      'Total Epilepsy Detected': 0
    });
    // print("Database Updated");
  }

  update(String collectionName, String documentName, field,
      var newFieldValue) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(documentName)
        .update({field: newFieldValue});
    // print("Fields Updated");
  }

  delete(
    String collectionName,
    String documentName,
  ) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(documentName)
        .delete();
    // print("Document Deleted");
  }

  createEpilepsyHistory(String collectionName, String documentName,
      String collectionHistoryName, int seizureDuration) async {
    late String uid;
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(documentName)
        .collection(collectionHistoryName)
        .add({
      'Real Seizure': true,
      'Seizure Duration (sec)': seizureDuration,
      'Time': DateTime.now()
    }).then((value) {
      // print("???????Bhai?????");
      // print(value.id);
      uid = value.id;
    });
    return uid;
  }

  updateEpilepsyHistory(
      String collectionName,
      String documentName,
      String collectionHistoryName,
      String uidHistory,
      field,
      var newFieldValue) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(documentName)
        .collection(collectionHistoryName)
        .doc(uidHistory)
        .update({field: newFieldValue});
    // print("Fields Updated");
  }

  Future<bool?> formDataIsExists(String userId) async {
    bool exists = false;
    await FirebaseFirestore.instance
        .collection('info')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // print('Document exists on the database');
        exists = true;
      }
    });
    return exists;
  }

  Future<int?> getExistingDetectionValue(String userId) async {
    int? totalDetection;
    await FirebaseFirestore.instance
        .collection('info')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        totalDetection = documentSnapshot.get("Total Epilepsy Detected") as int;
      }
    });
    return totalDetection;
  }

  Future<List<String?>> getContact(String userId) async {
    List<String?> details = []..length = 3;

    await FirebaseFirestore.instance
        .collection('info')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        details[0] = documentSnapshot.get("firstname") as String;
        details[1] = documentSnapshot.get("CareGiverPhoneno") as String;
        details[2] =
            documentSnapshot.get("gender") as String == "Male" ? "He" : "She";
      }
    });

    return details;
  }
}
