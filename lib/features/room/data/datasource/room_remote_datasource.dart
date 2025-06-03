import 'dart:async';

import 'package:in_between/core/error/server_exception.dart';
import 'package:in_between/core/web_socket/web_socket.dart';
import 'package:in_between/features/home/data/models/room_model.dart';

abstract interface class RoomRemoteDatasource {
  Future<RoomModel?> getRoomById({required String roomId});

  Stream<RoomModel> get roomUpdates;
}

class RoomRemoteDatasourceImpl implements RoomRemoteDatasource {
  final WebSocketService _webSocket;

  // Controller to emit room updates
  final StreamController<RoomModel> _roomUpdatesController =
      StreamController.broadcast();

  RoomRemoteDatasourceImpl({required WebSocketService webSocket})
    : _webSocket = webSocket {
    _webSocket.stream.listen((message) {
      try {
        if (message['type'] == 'room_update') {
          final roomData = message['room'];
          if (roomData != null) {
            final roomModel = RoomModel(
              roomId: roomData['roomId'],
              userList: roomData['userList'],
            );
            _roomUpdatesController.add(roomModel);
          }
        }
      } catch (e) {
        print("Error parsing room update: $e");
      }
    });
  }

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
            print("ROOM: request contains ${room} ");

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

      _webSocket.send({'type': 'get_room', 'roomId': roomId});

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

  @override
  Stream<RoomModel> get roomUpdates => _roomUpdatesController.stream;
}
