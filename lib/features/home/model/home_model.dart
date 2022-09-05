class HomeModel {
  String? continent;
  String? country;

  HomeModel.fromString(String data) {
    if (data.contains("/")) {
      final splitted = data.split("/");

      continent = splitted[0];
      country = splitted[1];
    }
  }
}
