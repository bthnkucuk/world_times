part of 'single_time_cubit.dart';

abstract class SingleTimeState extends Equatable {
  const SingleTimeState();

  @override
  List<Object> get props => [];
}

class SingleTimeInitial extends SingleTimeState {}

class SingleTimeLoading extends SingleTimeState {}

class SingleTimeLoaded extends SingleTimeState {
  SingleTimeModel? singleTime;
  SingleTimeLoaded(this.singleTime);
}

class SingleTimeError extends SingleTimeState {
  String error;
  SingleTimeError(this.error);
}
