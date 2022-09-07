import 'package:cryptobook/model/user_auth.dart';
import 'package:cryptobook/utils/api.dart';
import 'package:cryptobook/utils/storage.dart';
import 'package:cryptobook/utils/view_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class UserAuthBlocEvent {
  const UserAuthBlocEvent();
}

class LoadUserAuthEvent extends UserAuthBlocEvent {
  const LoadUserAuthEvent();
}

class ConnectEvent extends UserAuthBlocEvent {
  const ConnectEvent();
}

class EmailChangedEvent extends UserAuthBlocEvent {
  const EmailChangedEvent(this.email);
  final String? email;
}

class PasswordChangedEvent extends UserAuthBlocEvent {
  const PasswordChangedEvent(this.password);
  final String? password;
}

class UserAuthBlocState {
  final UserAuth? userAuth;
  final String? error;
  final ViewStatus status;
  final String? email;
  final String? password;
  final bool isConnecting;

  const UserAuthBlocState._({
    this.userAuth,
    this.error,
    this.email,
    this.password,
    this.isConnecting = false,
    this.status = ViewStatus.initial,
  });

  const UserAuthBlocState.initial() : this._();

  UserAuthBlocState copyWith({
    UserAuth? userAuth,
    String? password,
    String? email,
    bool? isConnecting,
    String? error,
    ViewStatus? status,
  }) {
    return UserAuthBlocState._(
      userAuth: userAuth ?? this.userAuth,
      email: email ?? this.email,
      password: password ?? this.password,
      isConnecting: isConnecting ?? this.isConnecting,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }
}

class UserAuthBloc extends Bloc<UserAuthBlocEvent, UserAuthBlocState> {
  UserAuthBloc() : super(const UserAuthBlocState.initial()) {
    on<LoadUserAuthEvent>(loadLocalUser);
    on<EmailChangedEvent>(emailChanged);
    on<PasswordChangedEvent>(passwordChanged);
    on<ConnectEvent>(tryConnection);

    add(const LoadUserAuthEvent());
  }

  void loadLocalUser(LoadUserAuthEvent event, Emitter<UserAuthBlocState> emit) async {
    emit(state.copyWith(status: ViewStatus.loading));

    UserAuth? user = await Storage().getUser();
    //await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(userAuth: user, status: ViewStatus.success));
  }

  void emailChanged(EmailChangedEvent event, Emitter<UserAuthBlocState> emit) async {
    emit(state.copyWith(email: event.email));
  }

  void passwordChanged(PasswordChangedEvent event, Emitter<UserAuthBlocState> emit) async {
    emit(state.copyWith(password: event.password));
  }

  void tryConnection(ConnectEvent event, Emitter<UserAuthBlocState> emit) async {
    if (state.email == null && state.password == null) {
      return;
    }

    emit(state.copyWith(isConnecting: true));

    // await Future.delayed(const Duration(seconds: 2));

    UserAuth? user = await NetworkManager().getUserAuth(state.email!, state.password!);

    if (user == null) {
      emit(state.copyWith(error: "Erreur lors de la connexion", isConnecting: false));
      return;
    }

    Storage().saveUserAuth(user);

    emit(state.copyWith(userAuth: user));
  }
}
