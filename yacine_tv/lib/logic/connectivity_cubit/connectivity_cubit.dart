import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit() : super(const ConnectivityNotChecking());

  Future<void> checkConnectivity({
    required void Function(String) onError,
  }) async {
    try {
      emit(const ConnectivityChecking());
      await Future.delayed(const Duration(seconds: 1));
      final result = await Connectivity().checkConnectivity();
      emit(const ConnectivityNotChecking());
      if (result == ConnectivityResult.none) {
        onError('No internet connection');
      } else {
        onError('connected');
      }
    } catch (e) {
      onError(e.toString());
    }
  }
}
