import 'package:fpdart/fpdart.dart';
import 'package:in_between/core/error/failure.dart';
import 'package:in_between/features/home/domain/entity/room.dart';
import 'package:in_between/features/room/domain/repository/room_repository.dart';

class GetRoomUsecase {
  final RoomRepository roomRepository;

  GetRoomUsecase({required this.roomRepository});

  Future<Either<Failure, Room?>> execute({required String roomId}) async {
    return await roomRepository.getRoomById(roomId: roomId);
  }
}
