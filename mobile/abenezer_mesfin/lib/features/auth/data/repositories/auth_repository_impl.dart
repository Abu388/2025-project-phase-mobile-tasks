import 'package:dartz/dartz.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../../../../core/error/failures.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final user = await remoteDataSource.login(email, password);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, User>> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final user = await remoteDataSource.register(name, email, password);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
