import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethodes {
  Future addUserInfoToDb(
      String userId, Map<String, dynamic> userInfoMap) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(userInfoMap);
  }
}
