class WaitingRoomDatasource {
  List<String> users = ['jenny', 'lisa', 'jisoo', 'rose', 'bangpd', 'users'];

  //func to bato

  Future<List<String>> getUsers() async {
    return users;
  }
}
