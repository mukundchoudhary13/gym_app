import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  createBasicInfo(
      String collectionName,
      String documentName,
      String name,
      int age,
      int weight,
      int height,
      int bmi,
      int duration,
      String id,
      int calories
      ) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(documentName)
        .set({
      'Name': name,
      'Height (cm)': height,

      'bmi': bmi,
      'age': age,
      'Weight (cm)':weight,
      'duration':duration

    }).then((value) => createFoodPlan(collectionName, documentName, "plan", true, duration,id,calories));
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

  createFoodPlan(String collectionName, String documentName,
      String collectionHistoryName, bool isPending,int duration,String id,int calories) async {
    late String uid;
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(documentName)
        .collection(collectionHistoryName)
        .add({
      'pending': isPending,
      'Lunch': [""],
      'Dinner': [""],
      'Snack':[""],
      'BreakFast':[""],
      'id':id,
      'duration(days)':duration,
      'total_calories':calories
    }).then((value) {
      // print("???????Bhai?????");
      // print(value.id);
      uid = value.id;
    });
    return uid;
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

}
