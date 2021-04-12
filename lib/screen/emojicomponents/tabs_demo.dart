import 'package:emoji_keyboard_app/helper/constant.dart';
import 'package:emoji_keyboard_app/helper/sizes_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data/Emoji.dart';
import 'reccent.dart';

typedef void StringCallback(String val);

class TabsDemo extends StatefulWidget {


  TabsDemo({this.callback, Key key,}) : super(key: key);

  final StringCallback callback;

  @override
  _TabsDemoState createState() => _TabsDemoState();
}

class _TabsDemoState extends State<TabsDemo> {
  TabController _controller;

  //Icons categories for emojies
  List<IconData> categories = [
    Icons.access_time_outlined,
    Icons.sentiment_satisfied,
    Icons.people,
    Icons.pets,
    Icons.fastfood,
    Icons.location_city,
    Icons.directions_run,
    Icons.lightbulb_outline,
    Icons.euro_symbol,
    Icons.flag
  ];

  List<Emoji> emojies = [];
  List<Emoji> recent = [];

  @override
  void initState() {
    super.initState();
    //gettinh emojies at start
    readJson();
  }

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/emoji.json');
    setState(() {
      emojies = emojiFromJson(response);
    });
  }

  @override
  Widget build(BuildContext ctxt) {
    return DefaultTabController(
        length: categories.length,
        child:  Container(
          height: displayHeight(context) * 0.35,
          child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(displayHeight(context) * 0.09),
                child: AppBar(
                  backgroundColor: blackColor,
                  bottom: TabBar(
                    indicatorColor: greenColor,
                    isScrollable: true,
                    tabs: List<Widget>.generate(categories.length, (int index) {
                      return Tab(
                        icon: Icon(categories[index]),
                      );
                    }),
                  ),
                ),
              ),
              body: Container(
                color: blackColor,
                child: TabBarView(
                  children: List<Widget>.generate(categories.length, (int index) {
                    return view(index);
                  }),
                ),
              )),
        ));
  }

  Widget view(int position) {

    //Filtering emojies on the basis of selected category
    List<Emoji> test = [];
    if (position == 1) {
      test =
          emojies.where((i) => i.category == Category.SMILEYS_EMOTION).toList();
    } else if (position == 2) {
      test = emojies.where((i) => i.category == Category.PEOPLE_BODY).toList();
    } else if (position == 3) {
      test =
          emojies.where((i) => i.category == Category.ANIMALS_NATURE).toList();
    } else if (position == 4) {
      test = emojies.where((i) => i.category == Category.FOOD_DRINK).toList();
    } else if (position == 5) {
      test =
          emojies.where((i) => i.category == Category.TRAVEL_PLACES).toList();
    } else if (position == 6) {
      test = emojies.where((i) => i.category == Category.ACTIVITIES).toList();
    } else if (position == 7) {
      test = emojies.where((i) => i.category == Category.OBJECTS).toList();
    } else if (position == 8) {
      test = emojies.where((i) => i.category == Category.SYMBOLS).toList();
    } else if (position == 9) {
      test = emojies.where((i) => i.category == Category.FLAGS).toList();
    }

    if (position == 0) {
      //Recently used emojies
      return Recent(recent: recent, callback: (val) => setState(() => widget.callback(val)),all: emojies,);
    } else {
      //selected categories emojies
      return test.length > 0
          ? Column(
              children: [
                Expanded(
                  child: GridView.count(
                    // Create a grid with 2 columns. If you change the scrollDirection to
                    // horizontal, this produces 2 rows.
                    crossAxisCount: 7,
                    // Generate 100 widgets that display their index in the List.
                    children: List.generate(test.length, (index) {
                      return Center(
                        child: InkWell(
                          onTap: () {
                            widget.callback(test[index].emoji);
                            clickPerform(test[index]);
                          },
                          child: Text(test[index].emoji),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            )
          : Container();
    }
  }

  clickPerform(Emoji emoji) {
    //Adding emojies to recent list with restriction of 45 and first in last out
    setState(() {
      if (recent.length >= 45) {
        recent.removeLast();
        recent.add(emoji);
      } else {
        recent.add(emoji);
      }
      recent = recent.reversed.toList();
    });
  }
}
