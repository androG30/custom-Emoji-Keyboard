import 'package:emoji_keyboard_app/helper/constant.dart';
import 'package:emoji_keyboard_app/helper/sizes_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'components/input_widget.dart';
import 'components/message_widget.dart';
import 'emojicomponents/tabs_demo.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final messages = <String>[];
  final controller = TextEditingController();
  bool isEmojiVisible = false;
  bool isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();

    // KeyboardVisibility.onChange.listen((bool isKeyboardVisible) {
    //   setState(() {
    //     this.isKeyboardVisible = isKeyboardVisible;
    //   });
    //
    //   if (isKeyboardVisible && isEmojiVisible) {
    //     setState(() {
    //       isEmojiVisible = false;
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/whatsapp_Back.png",
          height: displayHeight(context),
          width: displayWidth(context),
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: transColor,
          appBar: customAppbar(),
          body: WillPopScope(
            onWillPop: onBackPress,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    reverse: true,
                    physics: BouncingScrollPhysics(),
                    children: messages
                        .map((message) => MessageWidget(message: message))
                        .toList(),
                  ),
                ),
                InputWidget(
                  onBlurred: toggleEmojiKeyboard,
                  controller: controller,
                  isEmojiVisible: isEmojiVisible,
                  isKeyboardVisible: isKeyboardVisible,
                  onSentMessage: (message) =>
                      setState(() => messages.insert(0, message)),
                ),
                Offstage(
                  child: TabsDemo(callback: (val) => setState(() => onEmojiSelected(val))),
                  offstage: !isEmojiVisible,
                ),
              ],
            ),
          ),
        ),
    ],
    );
  }

  Widget customAppbar()
  {
    return PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: AppBar(
        leadingWidth: 70,
        titleSpacing: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back,
                size: 24,
              ),
              CircleAvatar(
                child: SvgPicture.asset(
                  "assets/person.svg",
                  color: Colors.white,
                  height: 36,
                  width: 36,
                ),
                radius: 20,
                backgroundColor: Colors.blueGrey,
              ),
            ],
          ),
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 18.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void onEmojiSelected(String emoji) => setState(() {
    controller.text = controller.text + emoji;
  });

  Future toggleEmojiKeyboard() async {
    if (isKeyboardVisible) {
      FocusScope.of(context).unfocus();
    }

    setState(() {
      isEmojiVisible = !isEmojiVisible;
    });
  }

  Future<bool> onBackPress() {
    if (isEmojiVisible) {
      toggleEmojiKeyboard();
    } else {
      Navigator.pop(context);
    }

    return Future.value(false);
  }


}
