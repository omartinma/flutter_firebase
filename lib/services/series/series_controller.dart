import 'package:flutter_firebase/model/serie.dart';
import 'package:flutter_firebase/services/series/series_api_controller.dart';

class SeriesController {
  Map<int, Serie> _savedSeries = new Map<int, Serie>();

  static final SeriesController _singleton =
      new SeriesController._constructor();

  factory SeriesController() {
    return _singleton;
  }

  SeriesController._constructor();

  Future addRemoveSerie(Serie serie) async {
    if (serie.isInToDo) {
      // we add it
      _savedSeries[serie.id] = serie;
      await SeriesAPIController().saveSerie(serie);
    } else {      
      _savedSeries.remove(serie.id);
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
