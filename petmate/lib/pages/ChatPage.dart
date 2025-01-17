import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:petmate/Widgets/MyBackButtonTemplate.dart';
import 'package:petmate/Widgets/MyTextFormFieldTemplate.dart';
import 'package:petmate/main.dart';
import 'package:petmate/providers/FirebaseProvider.dart';
import 'package:petmate/providers/chat_provider.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  String sender_id;
  String reciver_id;

  ChatPage({
    super.key,
    required this.reciver_id,
    required this.sender_id,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        centerTitle: true,
        leading: MyBackButtonTemplate(),
        toolbarHeight: mainh * 6.5 / 100,
        title: AutoSizeText(
          "chat",
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: mainh * 0.065 * .50,
              ),
        ),
        backgroundColor: color2,
      ),
      body: DisplayMessage(),
      bottomSheet: TextFormFieldForSendMessage(),
    );
  }

  Widget DisplayMessage() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return SizedBox(
      width: mainw,
      height: mainh,
      child: Consumer<ChatProvider>(
        builder: (context, value, child) => StreamBuilder(
          stream: value.getMessage(ids: [widget.sender_id, widget.reciver_id]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return UnconstrainedBox(
                child: Center(
                  child: Container(
                    width: mainw,
                    height: mainh * .10,
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: AutoSizeText(
                      "loading you chats  ....",
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: color1,
                                fontWeight: FontWeight.bold,
                                fontSize: mainh * .10 * .25,
                              ),
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return UnconstrainedBox(
                child: Center(
                  child: Container(
                    width: mainw,
                    height: mainh * .10,
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: AutoSizeText(
                      "there is an error happend !",
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: color1,
                                fontWeight: FontWeight.bold,
                                fontSize: mainh * .10 * .25,
                              ),
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => MessageTempalate(
                      message: snapshot.data![index].message,
                      sender_id: snapshot.data![index].sender_id));
            } else if (snapshot.data == null) {
              return UnconstrainedBox(
                child: Center(
                  child: Container(
                    width: mainw,
                    height: mainh * .10,
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: AutoSizeText(
                      "there is no messages ,say hi ",
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: color1,
                                fontWeight: FontWeight.bold,
                                fontSize: mainh * .10 * .25,
                              ),
                    ),
                  ),
                ),
              );
            } else {
              return Text("statuts : ${snapshot.connectionState}");
            }
          },
        ),
      ),
    );
  }

  Widget TextFormFieldForSendMessage() {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom * .0045,
      ),
      child: Consumer<ChatProvider>(
        builder: (context, chat, child) => Container(
          width: mainw,
          height: mainh * .08,
          color: color3,
          child: LayoutBuilder(
            builder: (context, constraints) => Row(
              children: [
                // space.
                SizedBox(
                  width: constraints.maxWidth * 0.05,
                ),

                // text field for new  message .
                MyTextFormFieldTemplate(
                  height: constraints.maxHeight * .65,
                  text: 'send message',
                  width: constraints.maxWidth * .70,
                  controller: chat.message,
                ),

                // space.
                SizedBox(
                  width: constraints.maxWidth * 0.05,
                ),

                //  button for send message .
                Consumer<FirebaseProvider>(
                  builder: (context, firebase, child) => Container(
                      width: constraints.maxWidth * .15,
                      height: constraints.maxHeight * .65,
                      decoration: BoxDecoration(
                        color: color3,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.10),
                            offset: const Offset(1.5, 1.5),
                            blurRadius: 20,
                          ),
                          BoxShadow(
                            color: Colors.white.withOpacity(0.10),
                            offset: const Offset(-1.5, -1.5),
                            blurRadius: 20,
                          )
                        ],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Transform.scale(
                        scaleX: constraints.maxWidth * .15 * 0.015,
                        scaleY: constraints.maxHeight * .65 * 0.02,
                        child: IconButton(
                            onPressed: () {
                              if (chat.message.text.isNotEmpty) {
                                print("sender from page  :${widget.sender_id}");
                                print(
                                    "sende from firebase :${firebase.currnet_user!.user_id}");

                                print(
                                    "reciver from page :${widget.reciver_id}");

                                context
                                    .read<ChatProvider>()
                                    .sendMessage(
                                      sender_id: firebase.currnet_user!.user_id,
                                      ids: [
                                        widget.reciver_id,
                                        widget.sender_id
                                      ],
                                      message: chat.message.text.trim(),
                                    )
                                    .whenComplete(
                                  () {
                                    chat.message.clear();
                                  },
                                );
                              } else {
                                print("there is no text to send !");
                              }
                            },
                            icon: Icon(
                              Icons.send,
                              color: color1,
                            )),
                      )),
                ),

                // space .
                SizedBox(
                  width: constraints.maxWidth * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MessageTempalate({
    required String message,
    required String sender_id,
  }) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Consumer<FirebaseProvider>(
      builder: (context, firebase, child) => Container(
        alignment: firebase.currnet_user!.user_id == sender_id
            ? Alignment.centerRight
            : Alignment.centerLeft,
        margin: EdgeInsets.only(top: mainh * 0.015),
        width: mainw * .55,
        decoration: const BoxDecoration(),
        child: Column(
          children: [
            // message .
            Padding(
              padding: EdgeInsets.only(
                left: mainw * .45 * 0.03,
                right: mainw * .45 * 0.03,
              ),
              child: Container(
                width: mainw * .55,
                decoration: BoxDecoration(
                  color: firebase.currnet_user!.user_id == sender_id
                      ? color4
                      : color3,
                  borderRadius: BorderRadius.circular(2.5),
                ),
                padding: EdgeInsets.only(left: mainw * .55 * .035),
                child: AutoSizeText(
                  message,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: mainh * 0.02,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
