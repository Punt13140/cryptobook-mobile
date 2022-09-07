import 'package:cryptobook/model/cryptocurrency/cryptocurrency.dart';
import 'package:cryptobook/utils/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CryptocurrenciesBlocEvent {
  const CryptocurrenciesBlocEvent();
}

class LoadCryptocurrenciesEvent extends CryptocurrenciesBlocEvent {
  const LoadCryptocurrenciesEvent();
}

class CryptocurrenciesBlocState {
  final List<Cryptocurrency> cryptocurrencies;

  CryptocurrenciesBlocState({
    required this.cryptocurrencies,
  });

  const CryptocurrenciesBlocState.initial() : cryptocurrencies = const [];
}

class CryptocurrenciesBloc extends Bloc<CryptocurrenciesBlocEvent, CryptocurrenciesBlocState> {
  CryptocurrenciesBloc() : super(const CryptocurrenciesBlocState.initial()) {
    on<LoadCryptocurrenciesEvent>(loadCryptocurrencies);

    add(const LoadCryptocurrenciesEvent());
  }

  void loadCryptocurrencies(LoadCryptocurrenciesEvent event, Emitter<CryptocurrenciesBlocState> emit) async {
    List<Cryptocurrency> cryptocurrencies = await NetworkManager().getCryptocurrencies();

    // await Future.delayed(const Duration(seconds: 5));

    emit(CryptocurrenciesBlocState(
      cryptocurrencies: cryptocurrencies,
    ));
  }
}
