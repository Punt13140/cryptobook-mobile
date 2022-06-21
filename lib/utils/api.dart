import 'package:cryptobook/model/deposit/api_response_deposit.dart';
import 'package:cryptobook/model/deposit/deposit.dart';
import 'package:cryptobook/model/loan/api_response_loan.dart';
import 'package:cryptobook/model/loan/loan.dart';
import 'package:cryptobook/model/position/api_response_position.dart';
import 'package:cryptobook/model/position/position.dart';
import 'package:cryptobook/model/user_auth.dart';
import 'package:cryptobook/utils/storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/http.dart';

part 'api.g.dart';

class AppUrl {
  static const String liveBaseURL = "https://remote-ur/api/v1";
  static const String localBaseURL = "http://127.0.0.1:8000/api";

  static const String baseURL = localBaseURL;
  static const String login = "$baseURL/login_check";
  static const String refresh = "$baseURL/token/refresh";
  static const String register = "$baseURL/users";
  static const String positions = "$baseURL/positions";
}

@RestApi()
abstract class RestClient {
  factory RestClient(
    Dio dio, {
    String baseUrl,
  }) = _RestClient;

  @POST("/login_check")
  Future<UserAuth?> getUserAuth(@Body() Map<String, dynamic> map);

  @GET("/positions")
  Future<PositionList> getPositions();

  @GET("/loans")
  Future<LoanList> getLoans();

  @GET("/deposits")
  Future<DepositList> getDeposits();
}

class NetworkManager {
  late Dio dio;
  late RestClient api;

  NetworkManager() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppUrl.baseURL,
      ),
    );

    // Ajout des logs :
    // dio.interceptors.add(LogInterceptor(
    //     responseBody: true,
    //     logPrint: (Object data) {
    //       if (kDebugMode) {
    //         print(data);
    //       }
    //     }));

    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      UserAuth? user = await Storage().getUser();
      if (user != null) {
        // debugPrint("intercept api > ${options.path} > token: ${user.token}");
        if (!options.path.contains('http')) {
          options.path = AppUrl.baseURL + options.path;
        }
        options.headers['Authorization'] = 'Bearer ${user.token}';
        return handler.next(options);
      }
    }, onError: (DioError error, handler) async {
      if ((error.response?.data['code'] == 401 && error.response?.data['message'] == "Expired JWT Token")) {
        // String? localRefreshToken = await _storage.getRefreshToken();
        // if (localRefreshToken != null) {
        //   if (await refreshToken(localRefreshToken)) {
        //     return handler.resolve(await _retry(error.requestOptions));
        //   }
        // }
      }
      return handler.next(error);
    }));

    api = RestClient(dio);
  }

  Future<UserAuth?> getUserAuth(String email, String password) async {
    print('username: $email, password: $password');
    UserAuth? user = await api.getUserAuth({
      'username': email,
      'password': password,
    }).onError((error, stackTrace) {
      debugPrint('---> ${error.toString()} ///');
      return null;
    }).then((value) {
      debugPrint('---> ${value.toString()} ///');
      return value;
    });

    await Future.delayed(const Duration(seconds: 1));

    if (user != null) {
      Storage().saveUserAuth(user);
    }

    return user;
  }

  Future<List<Position>> getPositions() async {
    PositionList response = await api.getPositions();
    return response.lstObjects;
  }

  Future<List<Loan>> getLoans() async {
    LoanList response = await api.getLoans();
    return response.lstObjects;
  }

  Future<List<Deposit>> getDeposits() async {
    DepositList response = await api.getDeposits();
    return response.lstObjects;
  }
}
