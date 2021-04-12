import 'package:emoji_keyboard_app/helper/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data/Emoji.dart';

typedef void StringCallback(String val);

// ignore: must_be_immutable
class Recent extends StatefulWidget {
  Recent({this.recent, this.callback,this.all});

  List<Emoji> recent = [];
  List<Emoji> all = [];
  final StringCallback callback;

  @override
  _RecentState createState() => _RecentState();
}

class _RecentState extends State<Recent> {
  TextEditingController _textController;
  List<Emoji> filters=[];

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        searchView(),
        filters.length > 0 ? Expanded(child: searchUse()):Expanded(child: frequentUseEmojies()),
      ],
    );
  }

  //Search View for emojies searching
  Widget searchView() {
    return Container(
      margin: EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          CupertinoSearchTextField(
            controller: _textController,
            placeholder: 'Search',
            style: TextStyle(fontSize: 19,color: Colors.white),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blueAccent,
                ),
                borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            onChanged: (value) {
              print("The text has changed to: " + value);
            },
            onSubmitted: (value) {
              print("Submitted text: " + value);
              setState(() {
                //filtering emojies on bases of search tags
                filters=widget.all.where((i) => i.tags.contains(value)).toList();
              });
            },
          ),
        ],
      ),
    );
  }

  //Frequently used emoji list ui

  Widget frequentUseEmojies() {
    return Container(
      child: widget.recent.length > 0
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(12, 12, 0, 0),
            child: Text(
              'Frequently used',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 7,
              // Generate 100 widgets that display their index in the List.
              children: List.generate(widget.recent.length, (index) {
                return Center(
                  child: InkWell(
                    onTap: () {
                      widget.callback(widget.recent[index].emoji);
                    },
                    child: Text(widget.recent[index].emoji),
                  ),
                );
              }),
            ),
          ),
        ],
      )
          : Container(),
    );
  }

  Widget searchUse() {
    return Container(
      child: filters.length > 0
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(defaultPadding, defaultPadding, 0, 0),
            child: Text(
              'Searched',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 7,
              // Generate 100 widgets that display their index in the List.
              children: List.generate(filters.length, (index) {
                return Center(
                  child: InkWell(
                    onTap: () {
                      widget.callback(filters[index].emoji);
                    },
                    child: Text(filters[index].emoji),
                  ),
                );
              }),
            ),
          ),
        ],
      )
          : Container(),
    );
  }
}
