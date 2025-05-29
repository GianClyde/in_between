import 'package:fpdart/fpdart.dart';
import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/core/error/failure.dart';
import 'package:in_between/features/home/domain/repository/player_repository.dart';

class InsertPlayerToRoomUsecase {
  final PlayerRepository playerRepository;

  InsertPlayerToRoomUsecase({required this.playerRepository});

  Future<Either<Failure, String?>> execute({
    required UserEntity user,
    required String roomId,
  }) async {
    return await playerRepository.insertPlayerToRoom(
      user: user,
      roomId: roomId,
    );
  }
}
