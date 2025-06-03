import 'dart:async';
import 'package:in_between/core/error/server_exception.dart';
import 'package:in_between/core/web_socket/web_socket.dart';
import 'package:in_between/features/home/data/models/room_model.dart';
import 'package:in_between/features/home/domain/entity/room.dart';

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
        if (message['type'] == 'room_updated') {
          final roomData = message['room'];
          print(
            "Room update received: $roomData, userlist: ${roomData?['userlist']}",
          );
          if (roomData != null) {
            final roomModel = RoomModel.fromMap(roomData);
            print("Deserialized userList: ${roomModel.userList}");
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
            print(
              "ROOM: request contains $room, userlist: ${room?['userlist']}",
            );

            if (room != null) {
              final roomModel = RoomModel.fromMap(room);
              print("Deserialized userList: ${roomModel.userList}");
              completer.complete(roomModel);
            } else {
              completer.complete(null);
            }

            subscription.cancel();
          } else {
            print("ROOM: other type");
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
