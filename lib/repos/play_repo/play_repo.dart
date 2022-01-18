abstract class PlayRepo {

  Future init(String path);

  Future play();

  Future pause();

  Future stop();
}
