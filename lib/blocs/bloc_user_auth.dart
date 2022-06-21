import 'package:cryptobook/model/user_auth.dart';
import 'package:cryptobook/utils/storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class UserAuthBlocEvent {
  const UserAuthBlocEvent();
}

class LoadUserAuthEvent extends UserAuthBlocEvent {
  const LoadUserAuthEvent();
}

class UserAuthBlocState {
  final UserAuth? userAuth;
  final bool isLoading;
  UserAuthBlocState(this.userAuth, this.isLoading);

  //init state => No user
  const UserAuthBlocState.initial()
      : userAuth = null,
        isLoading = true;
}

class UserAuthBloc extends Bloc<UserAuthBlocEvent, UserAuthBlocState> {
  UserAuthBloc() : super(const UserAuthBlocState.initial()) {
    on<LoadUserAuthEvent>(loadUserAuth);
    add(const LoadUserAuthEvent());
  }

  void loadUserAuth(LoadUserAuthEvent event, Emitter<UserAuthBlocState> emit) async {
    UserAuth? user = await Storage().getUser();
    //await Future.delayed(const Duration(seconds: 1));
    emit(UserAuthBlocState(user, false));
  }
}
