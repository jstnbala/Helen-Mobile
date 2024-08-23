// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, avoid_print
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:helen_app/src/services/consts.dart';

class ChatAI extends StatefulWidget {
  const ChatAI({super.key});

  @override
  _ChatAIState createState() => _ChatAIState();
}

class _ChatAIState extends State<ChatAI> {

    final _openAI = OpenAI.instance.build(
      token: OPENAI_API_KEY, 
      baseOption: HttpSetup(
        receiveTimeout: const Duration(
        seconds: 5,
      ),
    ),
    enableLog: true,
  );

  final ChatUser _user = 
    ChatUser(
      id: '1', 
      firstName: 'Farmer', 
      lastName: 'Helen'
      );

  final ChatUser _gptChatUser = 
    ChatUser(
      id: '2', 
      firstName: 'AgriKaChat', 
      lastName: 'Bot'
      );


  final List<ChatMessage> _messages = <ChatMessage>[];
  final List<ChatUser> _typingUsers = <ChatUser>[];

  @override
  void initState() {
    super.initState();
    /*_messages.add(
      ChatMessage(
        text: 'Hey!',
        user: _user,
        createdAt: DateTime.now(),
      ),
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCA771A), // Background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0), // Border radius for lower left corner
            bottomRight: Radius.circular(20.0), // Border radius for lower right corner
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Back button
          onPressed: () {
            Navigator.pop(context); // Go back when the button is pressed
          },
        ),
        title: Text(
          'AgriKaChat',
          style: TextStyle(
            color: Colors.white, // Text color
            fontFamily: 'Poppins', // Font family
            fontWeight: FontWeight.bold, // Font weight
          ),
        ),
        centerTitle: true, // Center the title horizontally
      ),
      body: DashChat(
        currentUser: _user, 
        messageOptions: const MessageOptions(
          currentUserContainerColor: Color(0xFFCA771A),
          containerColor: Color(0xFFD3D3D3),
        ),
        onSend: (ChatMessage m) {
          getChatResponse(m);
        }, 
        messages: _messages,
        typingUsers: _typingUsers,
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
  setState(() {
    _messages.insert(0, m);
    _typingUsers.add(_gptChatUser);
  });

  // Create a list of Messages objects from the existing messages
  List<Messages> messagesHistory = _messages.reversed.map((m) {
    if (m.user == _user) {
      return Messages(role: Role.user, content: m.text);
    } else {
      return Messages(role: Role.assistant, content: m.text);
    }
  }).toList();

  final request = ChatCompleteText(
    messages: messagesHistory,
    maxToken: 200,
    model: GptTurboChatModel(),
  );

  try {
    final response = await _openAI.onChatCompletion(request: request);
    
    for (var element in response!.choices) {
      if (element.message != null) {
        setState(() {
          _messages.insert(
            0, 
            ChatMessage(
              user: _gptChatUser, 
              createdAt: DateTime.now(), 
              text: element.message!.content
            )
          );
        });
      }
    }
  } catch (e) {
    // Handle the insufficient quota error
    if (e.toString().contains("insufficient_quota")) {
      setState(() {
        _messages.insert(
          0, 
          ChatMessage(
            user: _gptChatUser, 
            createdAt: DateTime.now(), 
            text: "Mukhang naabot na natin ang limitasyon ng paggamit para sa araw na ito. Paki-subukan ulit mamaya"
          )
        );
      });
    } else {
      print('Error: $e');
    }
  } finally {
    setState(() {
      _typingUsers.remove(_gptChatUser);  
    });
  }
}
}