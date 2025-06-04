class WaitingRoomDatasource {
  List<String> users = ['jenny', 'lisa', 'jisoo', 'rose', 'bangpd', 'users'];

  Future<List<String>> getUsers() async {
    return users;
  }
}
