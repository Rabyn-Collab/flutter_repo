import 'package:flutter_riverpod/flutter_riverpod.dart';



final loginProvider = StateNotifierProvider<LoginProvider, bool>((ref) => LoginProvider(true));


class LoginProvider extends StateNotifier<bool>{
  LoginProvider(super.state);

  void toggle(){
    state = !state;
  }


}


final loadingProvider = StateNotifierProvider.autoDispose<LoadingProvider, bool>((ref) => LoadingProvider(false));


class LoadingProvider extends StateNotifier<bool>{
  LoadingProvider(super.state);

  void toggle(){
    state = !state;
  }


}