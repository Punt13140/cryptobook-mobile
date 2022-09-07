import 'package:cryptobook/model/cryptocurrency/cryptocurrency.dart';
import 'package:cryptobook/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PositionFormBlocState {
  final List<Cryptocurrency> cryptocurrencies;

  final double? nbCoins;
  final bool? isOpened;
  final bool? isDca;
  final double? entryCost;
  final String? description;

  final Cryptocurrency? coin;
  final DateTime? openedAt;

  const PositionFormBlocState._({
    this.cryptocurrencies = const <Cryptocurrency>[],
    this.nbCoins,
    this.isOpened,
    this.isDca,
    this.entryCost,
    this.description,
    this.openedAt,
    this.coin,
  });

  PositionFormBlocState copyWith({
    List<Cryptocurrency>? cryptocurrencies,
    double? nbCoins,
    bool? isOpened,
    bool? isDca,
    double? entryCost,
    String? description,
    DateTime? openedAt,
    Cryptocurrency? coin,
  }) {
    return PositionFormBlocState._(
      cryptocurrencies: cryptocurrencies ?? this.cryptocurrencies,
      nbCoins: nbCoins ?? this.nbCoins,
      isOpened: isOpened ?? this.isOpened,
      isDca: isDca ?? this.isDca,
      description: description ?? this.description,
      openedAt: openedAt ?? this.openedAt,
      coin: coin ?? this.coin,
      entryCost: entryCost ?? this.entryCost,
    );
  }

  const PositionFormBlocState.initial() : this._();

  const PositionFormBlocState.cryptocurrenciesLoadInProgress() : this._();

  const PositionFormBlocState.cryptocurrenciesLoadSuccess({
    required List<Cryptocurrency> cryptocurrencies,
  }) : this._(cryptocurrencies: cryptocurrencies);

  bool get isComplete =>
      nbCoins != null && isOpened != null && isDca != null && entryCost != null && description != null && coin != null;
}

class PositionFormBloc extends Bloc<PositionFormBlocEvent, PositionFormBlocState> {
  PositionFormBloc() : super(const PositionFormBlocState.initial()) {
    on<CryptocurrenciesLoadedEvent>(loadCryptocurrencies);
    on<SubmitFormEvent>(submitForm);
    on<NbcoinsChangedEvent>(nbcoinsChanged);
    on<OpenedatChangedEvent>(openedatChanged);
    on<EntrycostChangedEvent>(entrycostChanged);
    on<IsDcaChangedEvent>(isdcaChanged);
    on<IsOpenedChangedEvent>(isopenedChanged);
    on<DescriptionChangedEvent>(descChanged);

    add(const CryptocurrenciesLoadedEvent());
  }

  void loadCryptocurrencies(CryptocurrenciesLoadedEvent event, Emitter<PositionFormBlocState> emit) async {
    emit(const PositionFormBlocState.cryptocurrenciesLoadInProgress());
    final List<Cryptocurrency> cryptocurrencies = await NetworkManager().getCryptocurrencies();
    // await Future.delayed(const Duration(seconds: 5));
    emit(PositionFormBlocState.cryptocurrenciesLoadSuccess(cryptocurrencies: cryptocurrencies));

    // emit(PositionFormBlocState(
    //   cryptocurrencies: cryptocurrencies,
    //   nbCoins:
    // ));
  }

  void submitForm(SubmitFormEvent event, Emitter<PositionFormBlocState> emit) async {
    debugPrint("clique submit");
    debugPrint("date > ${state.openedAt?.toLocal().toString()}");
    debugPrint("nb > ${state.nbCoins.toString()}");
    debugPrint("cout > ${state.entryCost.toString()}");
    debugPrint("isopen > ${state.isOpened.toString()}");
    debugPrint("dca > ${state.isDca.toString()}");
    debugPrint("description > ${state.description}");
  }

  void openedatChanged(OpenedatChangedEvent event, Emitter<PositionFormBlocState> emit) async {
    emit(state.copyWith(openedAt: event.date));
  }

  void nbcoinsChanged(NbcoinsChangedEvent event, Emitter<PositionFormBlocState> emit) async {
    emit(state.copyWith(nbCoins: event.nbCoins));
    debugPrint('nbcoins changed');
  }

  void entrycostChanged(EntrycostChangedEvent event, Emitter<PositionFormBlocState> emit) async {
    emit(state.copyWith(entryCost: event.entryCost));
  }

  void isopenedChanged(IsOpenedChangedEvent event, Emitter<PositionFormBlocState> emit) async {
    emit(state.copyWith(isOpened: event.isOpened));
  }

  void isdcaChanged(IsDcaChangedEvent event, Emitter<PositionFormBlocState> emit) async {
    emit(state.copyWith(isDca: event.isDca));
  }

  void descChanged(DescriptionChangedEvent event, Emitter<PositionFormBlocState> emit) async {
    emit(state.copyWith(description: event.description));
  }
}

abstract class PositionFormBlocEvent {
  const PositionFormBlocEvent();
}

class CryptocurrenciesLoadedEvent extends PositionFormBlocEvent {
  const CryptocurrenciesLoadedEvent();
}

class SubmitFormEvent extends PositionFormBlocEvent {
  const SubmitFormEvent();
}

class NbcoinsChangedEvent extends PositionFormBlocEvent {
  const NbcoinsChangedEvent(this.nbCoins);
  final double? nbCoins;
}

class OpenedatChangedEvent extends PositionFormBlocEvent {
  const OpenedatChangedEvent(this.date);
  final DateTime? date;
}

class IsOpenedChangedEvent extends PositionFormBlocEvent {
  const IsOpenedChangedEvent(this.isOpened);
  final bool? isOpened;
}

class IsDcaChangedEvent extends PositionFormBlocEvent {
  const IsDcaChangedEvent(this.isDca);
  final bool? isDca;
}

class EntrycostChangedEvent extends PositionFormBlocEvent {
  const EntrycostChangedEvent(this.entryCost);
  final double? entryCost;
}

class DescriptionChangedEvent extends PositionFormBlocEvent {
  const DescriptionChangedEvent(this.description);
  final String? description;
}
