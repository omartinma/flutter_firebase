import 'package:flutter_firebase/model/serie.dart';
import 'package:flutter_firebase/services/series/series_api_controller.dart';
import 'package:flutter_firebase/services/series/series_db_controller.dart';

class SeriesController {
  Map<int, Serie> _savedSeries = new Map<int, Serie>();

  static final SeriesController _singleton =
      new SeriesController._constructor();

  factory SeriesController() {
    return _singleton;
  }

  SeriesController._constructor() {
  }

  void loadCache() async {
    var list = await SeriesDBController.instance.getAllSeries();
    _savedSeries = Map.fromIterable(list, key: (v) => v.id, value: (v) => v);
  }

  Future addRemoveSerie(Serie serie) async {
    if (serie.isInToDo) {
      // we add it
      _savedSeries[serie.id] = serie;
      await SeriesDBController.instance.addSerie(serie);
      await SeriesAPIController().saveSerie(serie);
    } else {      
      _savedSeries.remove(serie.id);
      await SeriesDBController.instance.removeSerie(serie.id);
      await SeriesAPIController().removeSerie(serie.id.toString());
    }
  }

  bool isSerieAdded(int id) {
    return _savedSeries.containsKey(id);
  }

  int getNumberSeriesSaved() {
    return _savedSeries.length;
  }

  int getSavedKey(int index) {
    return _savedSeries.keys.elementAt(index);
  }

  Serie getSerie(int id) {
    return _savedSeries[id];
  }

  Serie getSerieByIndex(int index) {
    int key = getSavedKey(index);
    return getSerie(key);
  }
}
