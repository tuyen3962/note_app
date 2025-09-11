import 'package:injectable/injectable.dart';
import 'package:note_app/config/service/provider/dio_provider.dart';
import 'package:note_app/data/remote/authentication_api.dart';

@module
abstract class NetworkService {
  @lazySingleton
  AuthenticationAPI authenticationApiProvider(DioProvider provider) =>
      AuthenticationAPI(provider.dio);
}
