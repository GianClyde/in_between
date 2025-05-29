import 'package:fpdart/fpdart.dart';
import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/core/error/failure.dart';
import 'package:in_between/core/success/success.dart';
import 'package:in_between/features/home/domain/repository/player_repository.dart';

class RemovePlayerFromRoomUsecase {
  final PlayerRepository playerRepository;
  RemovePlayerFromRoomUsecase({required this.playerRepository});

  Future<Either<Failure, Success>> execute({
    required UserEntity user,
    required String roomId,
  }) async {
    return await playerRepository.removePlayerFromRoom(
      user: user,
      roomId: roomId,
    );
  }
}
