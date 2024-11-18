import 'package:hive/hive.dart';

abstract class AuthenticationLocalDataSource {
  Future<void> saveSessionId(String sessionId);
}

class AuthenticationLocalDataSourceImp extends AuthenticationLocalDataSource {
  @override
  Future<void> saveSessionId(String sessionId) async {
    final sessionIdBox = await Hive.openBox('sessionIdBox');
    return await sessionIdBox.put('sessionId', sessionId);
  }
}
