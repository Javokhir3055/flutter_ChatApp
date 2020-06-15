import 'package:chat_app/components/text_buble.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;



class ChatScreen extends StatefulWidget {
  static const String route = "ChatScreen";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String textMessage;

  @override
  void initState() {
    super.initState();
    currentUser();
  }

  void currentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatGo'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          MessageStream(firestore: _firestore),
          Center(
            child: Padding(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (textMessage) {
                        this.textMessage = textMessage;
                      },
                      decoration: inputRegistrationScreen.copyWith(
                        hintText: 'Type your message here...',
                      ),
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      minWidth: 40,
                      height: 20,
                      onPressed: () async {
                        messageTextController.clear();
                        if (textMessage != null) {
                          await _firestore.collection('messages').add({
                            'text': textMessage.trim(),
                            'sender': loggedInUser.email,
                            'date': DateTime.now()
                          });
                        }
                      },
                      child: Text('Send'),
                    ),
                  ),
                ],
              ),
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text('Loading'),
              accountName: Text('Password name'),
            ),
            ListTile(
              title: Text('Text1'),
            ),
            ListTile(
              title: Text('Text1'),
            ),
            ListTile(
              title: MaterialButton(
                child: Text('Log out'),
                onPressed: () {
                  Navigator.popUntil(
                      context, ModalRoute.withName(WelcomeScreen.route));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  MessageStream({
    Key key,
    @required Firestore firestore,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data.documents.reversed;
        
          List<TextBuble> messageBuble = [];
          for (var message in messages) {
            var text = message.data['text'];
            var sender = message.data['sender'];
            final currentUser = loggedInUser.email;

            if (text != null && text != '')
              messageBuble.add(TextBuble(
                text: text,
                sender: sender,
                isMe: currentUser == sender,
              ));
          }
          return Expanded(
            child: ListView(
              reverse: true,
              children: messageBuble,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            ),
          );
        }
        if (snapshot.hasError)
          return Center(
            child: Text('No Connection'),
          );
        return CircularProgressIndicator();
      },
    );
  }
}
