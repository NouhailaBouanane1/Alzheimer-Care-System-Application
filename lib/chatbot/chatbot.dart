import 'package:flutter/material.dart';
import 'package:dialogflow_flutter/dialogflowFlutter.dart';
import 'package:dialogflow_flutter/googleAuth.dart';
import 'package:dialogflow_flutter/language.dart';
import 'package:graduation_project/chatbot/chatMessage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// TODO import Dialogflow

class chatBotScreen extends StatefulWidget {
  @override
  _chatBotScreenState createState() => _chatBotScreenState();
}

class _chatBotScreenState extends State<chatBotScreen> {
  List<ChatMessage> messages = [];
  TextEditingController _inputMessageController = new TextEditingController();
  late DialogFlow dialogflow;
  late AuthGoogle authGoogle;
  ScrollController _scrollController = new ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await initiateDialogFlow();
    });
  }

  @override
  Widget build(BuildContext context) {
    _scrollToBottom();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Color(0xff311B92),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Image.asset('images/chatbot.jpg'),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "ACS chatbot",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff311B92)),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Online",
                            style: TextStyle(
                                color: Color(0xffFFC400), fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          chatSpaceWidget(),
          Container(
            height: 1.0,
            width: double.infinity,
            color: Colors.blueGrey,
          ),
          bottomChatView()
        ],
      ),
    );
  }

  Widget chatSpaceWidget() {
    return Flexible(
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ListView.builder(
                itemCount: messages.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment: (messages[index].messageType == "receiver"
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          color: (messages[index].messageType == "receiver"
                              ? Color(0xffB39DDB)
                              : Color(0xffFFC400)),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          messages[index].messageContent,
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget bottomChatView() {
    return Container(
      padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
      height: 60,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: TextField(
              controller: _inputMessageController,
              onSubmitted: (String str) {
                fetchFromDialogFlow(str);
              },
              decoration: InputDecoration(
                  hintText: "Write message...",
                  hintStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          FloatingActionButton(
            onPressed: () {
              fetchFromDialogFlow(_inputMessageController.text);
            },
            child: Icon(
              Icons.send,
              color: Colors.white,
              size: 18,
            ),
            backgroundColor: Color(0xff311B92),
            elevation: 0,
          ),
        ],
      ),
    );
  }

  _scrollToBottom() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  initiateDialogFlow() async {
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/credentials.json").build();
    dialogflow = DialogFlow(authGoogle: authGoogle, language: Language.english);
  }

  fetchFromDialogFlow(String input) async {
    _inputMessageController.clear();
    setState(() {
      messages.add(ChatMessage(messageContent: input, messageType: "sender"));
    });

    AIResponse response = await dialogflow.detectIntent(input);
    print(response.getMessage());
    messages.add(ChatMessage(
        messageContent: response.getMessage()!, messageType: "receiver"));
    setState(() {});
  }
}
