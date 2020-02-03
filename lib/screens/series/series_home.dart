import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/series/series_saved_page.dart';
import 'package:flutter_firebase/screens/series/series_search_page.dart';
import 'package:flutter_firebase/services/series/series_controller.dart';

class SeriesHomePage extends StatefulWidget {
  SeriesHomePage({Key key}) : super(key: key);
  @override
  _SeriesHomePageState createState() => _SeriesHomePageState();
}

class _SeriesHomePageState extends State<SeriesHomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [new SeriesSearchPage(), new SeriesSavedPage()];

  @override
  Widget build(BuildContext context) {
    SeriesController().loadCache();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('TV SHOWS'),
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        )
      ),
      body: _children[_currentIndex], 
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.search),
            title: new Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.list),
            title: new Text('TO-DO'),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
