import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_dl/models/fire_result.dart';

class FirebaseService {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<FireResult?> init() async {
    final _res = await fireStore.collection("youtube-dl").doc("server").get();
    if (_res.data() == null) {
      print("firebase Error : FireStore Data Empty!");
      return null;
    }
    return FireResult.fromMap(_res.data());
  }
}
