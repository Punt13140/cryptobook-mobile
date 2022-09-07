// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<UserAuth?> getUserAuth(map) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(map);
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<UserAuth>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/login_check',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        _result.data == null ? null : UserAuth.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserAuth?> getRefreshUserAuth(map) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(map);
    final _result = await _dio.fetch<Map<String, dynamic>?>(
        _setStreamType<UserAuth>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/token/refresh',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        _result.data == null ? null : UserAuth.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PositionList> getPositions() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PositionList>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/positions',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PositionList.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LoanList> getLoans() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoanList>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/loans',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoanList.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DepositList> getDeposits() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DepositList>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/deposits',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DepositList.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FarmingSimpleList> getSimpleFarmings() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FarmingSimpleList>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/strategy_farmings',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FarmingSimpleList.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FarmingLpList> getLpFarmings() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FarmingLpList>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/strategy_lps',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FarmingLpList.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CryptocurrencyList> getCryptocurrencies() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CryptocurrencyList>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/cryptocurrencies',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CryptocurrencyList.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Cryptocurrency> getCryptocurrency(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Cryptocurrency>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/cryptocurrencies/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Cryptocurrency.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
