class WaitingRoomDatasource {
  List<String> users = ['jenny', 'lisa', 'jisoo', 'rose', 'bangpd'];

  //func to bato

  Future<List<String>> getUsers() async {
    return users;
  }
}
