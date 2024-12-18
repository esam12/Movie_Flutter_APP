import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/entities/no_params.dart';
import 'package:movieapp/domain/repositories/app_repository.dart';
import 'package:movieapp/domain/usecases/usecase.dart';

class GetPreferredLanguage extends UseCase<void, NoParams> {
  final AppRepository repository;

  GetPreferredLanguage(this.repository);
  @override
  Future<Either<AppError, String>> call(NoParams params) async {
    return await repository.getPreferredLanguage();
  }
}
