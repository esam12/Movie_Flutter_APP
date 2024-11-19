import 'package:hive/hive.dart';

abstract class AuthenticationLocalDataSource {
  Future<void> saveSessionId(String sessionId);
  Future<String> getSessionId();
  Future<void> deleteSessionId();
}

class AuthenticationLocalDataSourceImp extends AuthenticationLocalDataSource {
  @override
  Future<void> saveSessionId(String sessionId) async {
    final sessionIdBox = await Hive.openBox('authenticationBox');
    return await sessionIdBox.put('sessionId', sessionId);
  }

  @override
  Future<void> deleteSessionId() async {
    print('Delete Session Id - Local');
    final authenticationBox = await Hive.openBox('authenticationBox');
    authenticationBox.delete('sessionId');
  }

  @override
  Future<String> getSessionId() async {
    final authenticationBox = await Hive.openBox('authenticationBox');
    return await authenticationBox.get('sessionId');
  }
}
