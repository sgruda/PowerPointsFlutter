class MarkerData {
  final double markerLatitude;
  final double markerLongitude;
  final String markerTitle;
  final String markerDescription;
  final String markerTitleAfterCheck;
  final String markerDescriptionAfterCheck;
  final int points;
  bool active;


  MarkerData(this.markerLatitude, this.markerLongitude, this.markerTitle,
      this.markerDescription, this.markerTitleAfterCheck,
      this.markerDescriptionAfterCheck, this.points, this.active);
}
class Markers {
  static Map<int, MarkerData> markers = {
    0:  new MarkerData(
        51.747179, 19.453392,
        "O winda!", "",
        "Brawo", "Udało Ci się znaleźć windę. Zdobyłeś 10 punktów! Czy wiedziałeś, że często się psują?",
        10, true),
    1:  new MarkerData(
        51.747208, 19.453742,
        "Lodex", "",
        "Niemożliwe", "Udało Ci się zobaczyć Lodex => budenek trzech wydziałów! Zdobyłeś 20 punktów!",
        10, true),
    2:  new MarkerData(
        51.747208, 19.453742,
        "Kącik.", "",
        "Kącik sali.", "Stoisz w kącie! Zdobyłeś 10 punktów!",
        10, true),
    3:  new MarkerData(
        51.589825, 19.158179,
        "blok.", "",
        "dgsg", "Stoisz w kącie! Zdobyłeś 10 punktów!",
        10, true)
  };

}