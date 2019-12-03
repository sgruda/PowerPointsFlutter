class Markers {
  Map<String, MarkerData> markers = {
    '1':new MarkerData(51.747179, 19.453392, "O winda!", "", "Brawo", "Udało Ci się znaleźć windę. Zdobyłeś 10 punktów! Czy wiedziałeś, że często się psują?")
  };
}
class MarkerData {
  final double markerLatitude;
  final double markerLongitude;
  final String markerTitle;
  final String markerDescription;
  final String markerTitleAfterCheck;
  final String markerDescriptionAfterCheck;


  MarkerData(this.markerLatitude, this.markerLongitude, this.markerTitle,
      this.markerDescription, this.markerTitleAfterCheck,
      this.markerDescriptionAfterCheck);
}