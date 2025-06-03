import 'dart:async';

import 'package:in_between/core/error/server_exception.dart';
import 'package:in_between/core/web_socket/web_socket.dart';
import 'package:in_between/features/home/data/models/room_model.dart';

abstract interface class RoomRemoteDatasource {
  Future<RoomModel?> getRoomById({required String roomId});
}

class RoomRemoteDatasourceImpl implements RoomRemoteDatasource {
  final WebSocketService _webSocket;

  RoomRemoteDatasourceImpl({required WebSocketService webSocket})
    : _webSocket = webSocket;

  @override
  Future<RoomModel?> getRoomById({required String roomId}) async {
    final completer = Completer<RoomModel?>();
    late final StreamSubscription subscription;
    try {
      subscription = _webSocket.stream.listen((message) {
        print("USER: request received ");
        try {
          final data = message;

          if (data['type'] == 'get_room_result') {
            final room = data['room'];
            print("USER: request contains ${room} ");

            if (room != null) {
              final roomModel = RoomModel(
                roomId: room['roomId'],
                userList: room['userList'],
              );

              completer.complete(roomModel);
              //Todo utilize fromJson sa model
            } else {
              completer.complete(null);
            }

            subscription.cancel();
          } else {
            print("USER: other type");
          }
        } catch (e) {
          if (!completer.isCompleted) {
            completer.completeError("Error decoding server response: $e");
            throw ServerException(message: e.toString());
          }

          subscription.cancel();
        }
      });

      _webSocket.send({'type': 'get_room', 'userId': roomId});

      return completer.future.timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          subscription.cancel();
          return null;
        },
      );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
