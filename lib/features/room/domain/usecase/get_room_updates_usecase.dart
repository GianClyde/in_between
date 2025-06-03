import 'package:in_between/features/home/data/models/room_model.dart';
import 'package:in_between/features/home/domain/entity/room.dart';
import 'package:in_between/features/room/domain/repository/room_repository.dart';

class GetRoomUpdatesUsecase {
  final RoomRepository roomRepository;

  GetRoomUpdatesUsecase({required this.roomRepository});

  Stream<Room> execute() {
    return roomRepository.getRoomUpdates();
  }
}
