import 'package:fpdart/fpdart.dart';
import 'package:in_between/core/error/failure.dart';
import 'package:in_between/features/home/data/models/room_model.dart';
import 'package:in_between/features/home/domain/entity/room.dart';

abstract interface class RoomRepository {
  Future<Either<Failure, Room?>> getRoomById({required String roomId});

  Stream<Room> getRoomUpdates();
}
