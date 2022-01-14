import 'package:dio/dio.dart';
import 'package:youtube_dl/repos/down_repo/down_repo.dart';
import 'package:youtube_dl/services/down_service/down_service.dart';
import 'package:youtube_dl/services/firebase_service/firebase_service.dart';

class DownImpl extends DownRepo {
  late DownService _service;
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Future initRepo() async {
    final _fireResult = await _firebaseService.init();
    if (_fireResult == null) return;
    _service = DownService(_fireResult.tunnels
        .firstWhere((element) => element.proto == "https")
        .publicUrl);
  }

  @override
  Future audio(String videoId, ProgressCallback onReceiveProgress) {
    // TODO: implement audio
    throw UnimplementedError();
  }
}
