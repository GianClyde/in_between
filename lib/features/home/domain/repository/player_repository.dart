import 'package:fpdart/fpdart.dart';
import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/core/error/failure.dart';

abstract interface class PlayerRepository {
  Future<Either<Failure, String?>> insertPlayerToRoom({
    required UserEntity user,
    required String roomId,
  });
}
