import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:world_times/features/single_time/model/single_time_model.dart';
import 'package:world_times/features/single_time/services/single_time_services.dart';

part 'single_time_state.dart';

class SingleTimeCubit extends Cubit<SingleTimeState> {
  SingleTimeCubit({required this.continent, required this.country})
      : super(SingleTimeInitial()) {
    loadSingleTime();
  }
  String country;
  String continent;
  SingleTimeModel? _response;
  SingleTimeModel? get response => _response;

  final _singleTimeServices = SingleTimeServices();

  Future<void> loadSingleTime() async {
    try {
      emit(SingleTimeLoading());

      _response = await _singleTimeServices.fetchData(country, continent);

      emit(SingleTimeLoaded(response));
    } catch (e) {
      emit(SingleTimeError(e.toString()));
    }
  }
}
