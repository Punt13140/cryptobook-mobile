import 'package:cryptobook/model/cryptocurrency/api_response_cryptocurrency.dart';
import 'package:cryptobook/model/cryptocurrency/cryptocurrency.dart';
import 'package:cryptobook/model/deposit/api_response_deposit.dart';
import 'package:cryptobook/model/deposit/deposit.dart';
import 'package:cryptobook/model/farming/lp/api_response_farming_lp.dart';
import 'package:cryptobook/model/farming/lp/farming_lp.dart';
import 'package:cryptobook/model/farming/simple/api_response_farming_simple.dart';
import 'package:cryptobook/model/farming/simple/farming_simple.dart';
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
  static const String liveBaseURL = "https://cryptobook.smbpunt.fr";
  static const String localBaseURL = "http://127.0.0.1:8000";

  static const String baseURL = "$liveBaseURL/api";
  static const String login = "/login_check";
  static const String refresh = "/token/refresh";
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

  @POST("/token/refresh")
  Future<UserAuth?> getRefreshUserAuth(@Body() Map<String, dynamic> map);

  @GET("/positions")
  Future<PositionList> getPositions();

  @GET("/loans")
  Future<LoanList> getLoans();

  @GET("/deposits")
  Future<DepositList> getDeposits();

  @GET("/strategy_farmings")
  Future<FarmingSimpleList> getSimpleFarmings();

  @GET("/strategy_lps")
  Future<FarmingLpList> getLpFarmings();

  @GET("/cryptocurrencies")
  Future<CryptocurrencyList> getCryptocurrencies();

  @GET("/cryptocurrencies/{id}")
  Future<Cryptocurrency> getCryptocurrency(@Path("id") int id);
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
      if (user != null && options.path != AppUrl.login && options.path != AppUrl.refresh) {
        //debugPrint("intercept api > ${options.path} > token: ${user.token}");
        if (!options.path.contains('http')) {
          options.path = AppUrl.baseURL + options.path;
        }
        options.headers['Authorization'] = 'Bearer ${user.token}';
      }
      return handler.next(options);
    }, onError: (DioError error, handler) async {
      debugPrint('error ${error.response?.toString()}');

      if ((error.response?.data['code'] == 401 && error.response?.data['message'] == "Expired JWT Token")) {
        UserAuth? user = await Storage().getUser();
        if (user == null) {
          return;
        }
        String? localRefreshToken = user.refreshToken;
        if (await refreshToken(localRefreshToken)) {
          return handler.resolve(await _retry(error.requestOptions));
        }
      }
      return handler.next(error);
    }));

    api = RestClient(dio);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data, queryParameters: requestOptions.queryParameters, options: options);
  }

  Future<bool> refreshToken(String refreshToken) async {
    UserAuth? user = await api.getRefreshUserAuth({
      'refresh_token': refreshToken,
    }).onError((error, stackTrace) {
      debugPrint('Error refresh : ${error.toString()} ///');
      return null;
    }).then((value) {
      return value;
    });

    if (user != null) {
      Storage().saveUserAuth(user);
      return true;
    }

    return false;
  }

  Future<UserAuth?> getUserAuth(String email, String password) async {
    UserAuth? user = await api.getUserAuth({
      'username': email,
      'password': password,
    }).onError((error, stackTrace) {
      debugPrint('Auth failed.');
      debugPrint('Error : ${error.toString()} ///');
      return null;
    }).then((value) {
      return value;
    });

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

  Future<List<FarmingSimple>> getSimpleFarmings() async {
    FarmingSimpleList response = await api.getSimpleFarmings();
    return response.lstObjects;
  }

  Future<List<FarmingLp>> getLpFarmings() async {
    FarmingLpList response = await api.getLpFarmings();
    return response.lstObjects;
  }

  Future<List<Cryptocurrency>> getCryptocurrencies() async {
    CryptocurrencyList response = await api.getCryptocurrencies();
    return response.lstObjects;
  }

  Future<Cryptocurrency> getCryptocurrency(int id) async {
    return await api.getCryptocurrency(id);
  }
}
