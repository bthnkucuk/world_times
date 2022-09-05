import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:world_times/features/home/model/home_model.dart';
import 'package:world_times/features/home/services/home_services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    loadHome();
  }

  final _services = HomeServices();
  List<HomeModel>? response;

  void loadHome() async {
    try {
      emit(HomeLoading());

      response = await _services.fetchData();

      emit(HomeLoaded(response));
    } catch (e) {
      emit(HomeError(error: e.toString()));
    }
  }

  void onSearched(String searchedKey) {
    List<HomeModel>? searchedResponse = [];
    emit(HomeLoading());
    response!.forEach((element) {
      final comp = element.country ?? element.continent ?? "";

      if (comp.toLowerCase().contains(searchedKey.toLowerCase())) {
        searchedResponse.add(element);
      }
    });

    emit(HomeLoaded(searchedResponse));
  }
}
