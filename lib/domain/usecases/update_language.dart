import 'package:dartz/dartz.dart';
import 'package:movieapp/domain/entities/app_error.dart';
import 'package:movieapp/domain/repositories/app_repository.dart';
import 'package:movieapp/domain/usecases/usecase.dart';

class UpdateLanguage extends UseCase<void, String> {
  final AppRepository repository;

  UpdateLanguage(this.repository);
  @override
  Future<Either<AppError, void>> call(String languageCode) async {
    return await repository.updateLanguage(languageCode);
  }
}
