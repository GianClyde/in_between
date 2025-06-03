import 'package:fpdart/src/either.dart';
import 'package:in_between/core/error/failure.dart';
import 'package:in_between/features/home/data/models/room_model.dart';
import 'package:in_between/features/room/data/datasource/room_remote_datasource.dart';
import 'package:in_between/features/room/domain/repository/room_repository.dart';

class RoomRepositoryImpl implements RoomRepository {
  final RoomRemoteDatasource roomRemoteDatasource;

  RoomRepositoryImpl({required this.roomRemoteDatasource});

  @override
  Future<Either<Failure, RoomModel?>> getRoomById({
    required String roomId,
  }) async {
    try {
      final room = await roomRemoteDatasource.getRoomById(roomId: roomId);

      if (room == null) {
        return left(Failure(message: "Room not found"));
      }

      return right(room);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Stream<RoomModel> getRoomUpdates() {
    return roomRemoteDatasource.roomUpdates;
  }
}
