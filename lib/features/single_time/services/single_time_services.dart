import 'package:dio/dio.dart';
import 'package:world_times/features/single_time/model/single_time_model.dart';

abstract class ISingleTimeServices {
  Future<SingleTimeModel> fetchData(String country, String continent);
}

class SingleTimeServices extends ISingleTimeServices {
  @override
  Future<SingleTimeModel> fetchData(String country, String continent) async {
    final response = await Dio().getUri(Uri.parse(
        "http://worldtimeapi.org/api/timezone/${continent.toLowerCase()}/${country.toLowerCase()}"));

    return SingleTimeModel.fromJson(response.data);
  }
}
