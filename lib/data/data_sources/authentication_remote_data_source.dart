import 'package:movieapp/data/core/api_client.dart';
import 'package:movieapp/data/models/request_token_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<RequestTokenModel> getRequestToken();
  Future<RequestTokenModel> validateWithLogin(Map<String, dynamic> requestBody);
  Future<String> createSession(Map<String, dynamic> requestBody);
  Future<bool> deleteSession(String sessionId);
}

class AuthenticationRemoteDataSourceImpl
    extends AuthenticationRemoteDataSource {
  final ApiClient _apiClient;

  AuthenticationRemoteDataSourceImpl(this._apiClient);

  @override
  Future<String> createSession(Map<String, dynamic> requestBody) async {
    final response = await _apiClient.post('authentication/session/new',
        params: requestBody);
    return response['success'] ? response['session_id'] : null;
  }

  @override
  Future<RequestTokenModel> getRequestToken() async {
    final response = await _apiClient.get('authentication/token/new');
    final requestTokenModel = RequestTokenModel.fromJson(response);
    return requestTokenModel;
  }

  @override
  Future<RequestTokenModel> validateWithLogin(
      Map<String, dynamic> requestBody) async {
    final response = await _apiClient.post(
      'authentication/token/validate_with_login',
      params: requestBody,
    );
    return RequestTokenModel.fromJson(response);
  }

  @override
  Future<bool> deleteSession(String sessionId) async {
    final response = await _apiClient.deleteWithBody(
      'authentication/session',
      params: {'session_id': sessionId},
    );
    return response['success'] ?? false;
  }
}
