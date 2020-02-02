import 'package:flutter/material.dart';
import 'package:flutter_firebase/model/serie.dart';
import 'package:flutter_firebase/services/series/series_controller.dart';

import 'components/serie_saved_card.dart';


class SeriesSavedPage extends StatefulWidget {
  SeriesSavedPage({Key key, this.savedSeries}) : super(key: key);

  final Map<int, Serie> savedSeries;
  _SeriesSavedPageState createState() => _SeriesSavedPageState();
}

class _SeriesSavedPageState extends State<SeriesSavedPage> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 0,
            childAspectRatio: 0.7,
            mainAxisSpacing: 5,
            crossAxisCount: 2),
        itemCount: SeriesController().getNumberSeriesSaved(),
        itemBuilder: (context, index) {
          Serie serie = SeriesController().getSerieByIndex(index);
          return new SavedSerieCard(
              serie: serie,
              onToDoChanged: (Serie serie) {
                setState(() {
                  SeriesController().addRemoveSerie(serie);
                });
              });
        });
  }
}
