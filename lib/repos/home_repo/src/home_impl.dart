import 'package:youtube_dl/repos/home_repo/home_repo.dart';
import 'package:youtube_dl/services/src/firebase_service.dart';
import 'package:youtube_dl/services/src/melon_service.dart';

class HomeImpl extends HomeRepo {
  final FirebaseService _firebaseService = FirebaseService();
  late MelonService _service;

  @override
  Future initRepo() async {
    await _initService();
  }

  Future _initService() async {
    final _fireResult = await _firebaseService.init();
    if (_fireResult == null) return;

    _service = MelonService(
      _fireResult.tunnels
          .firstWhere((element) => element.proto == "https")
          .publicUrl,
    );
  }

  @override
  Future loadMelonChart() async{
    final _res = await _service.loadMelonChart();
    if(!_res.result){
      return _service.loadMelonChart();
    }
  }
}
