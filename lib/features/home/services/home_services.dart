import 'package:dio/dio.dart';
import 'package:world_times/features/home/model/home_model.dart';

abstract class IHomeServices {
  Future<List<HomeModel>?> fetchData();
}

class HomeServices extends IHomeServices {
  String? error;

  @override
  Future<List<HomeModel>?> fetchData() async {
    try {
      List<HomeModel> dataList = [];
      final response =
          await Dio().getUri(Uri.parse("http://worldtimeapi.org/api/timezone"));

      final allCountries = response.data as List;
      allCountries.forEach((element) {
        dataList.add(HomeModel.fromString(element));
      });

      return dataList;
    } catch (e) {
      error = e.toString();
    }
  }
}
