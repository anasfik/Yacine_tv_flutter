part of 'connectivity_cubit.dart';

abstract class ConnectivityState extends Equatable {
  final bool isChecking;

  @override
  List<Object?> get props => [isChecking];

  const ConnectivityState({
    required this.isChecking,
  });
}

class ConnectivityChecking extends ConnectivityState {
  const ConnectivityChecking({
    super.isChecking = true,
  });
}

class ConnectivityNotChecking extends ConnectivityState {
  const ConnectivityNotChecking({
    super.isChecking = false,
  });
}
