import 'package:fpdart/src/either.dart';
import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/core/error/failure.dart';
import 'package:in_between/features/home/data/datasource/home_remote_datasource.dart';
import 'package:in_between/features/home/domain/repository/player_repository.dart';

class PlayerRepositoryImpl implements PlayerRepository {
  final HomeRemoteDatasource homeRemoteDatasource;

  PlayerRepositoryImpl({required this.homeRemoteDatasource});
  @override
  Future<Either<Failure, String?>> insertPlayerToRoom({
    required UserEntity user,
    required String roomId,
  }) async {
    try {
      final roomIdVal = await homeRemoteDatasource.insertPlayerToRoom(
        user: user.toModel(),
        roomId: roomId,
      );

      if (roomIdVal == null) {
        return left(Failure(message: "No Room Returned"));
      }
      return right(roomIdVal);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
