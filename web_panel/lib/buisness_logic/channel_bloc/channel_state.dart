// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'channel_bloc.dart';

class ChannelState extends Equatable {
  final bool isLoading;
  const ChannelState({
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [isLoading];

  ChannelState copyWith({
    bool? isLoading,
  }) {
    return ChannelState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
