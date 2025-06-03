import 'package:fpdart/fpdart.dart';
import 'package:in_between/core/error/failure.dart';
import 'package:in_between/features/home/data/models/room_model.dart';

abstract interface class RoomRepository {
  Future<Either<Failure, RoomModel?>> getRoomById({required String roomId});

  Stream<RoomModel> getRoomUpdates();
}
