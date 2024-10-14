// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, avoid_print
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatAI extends StatefulWidget {
  const ChatAI({super.key});

  @override
  _ChatAIState createState() => _ChatAIState();
}

class _ChatAIState extends State<ChatAI> {
  late final OpenAI _openAI; // Change to late variable

  final ChatUser _user = ChatUser(
    id: '1',
    firstName: 'Farmer',
    lastName: 'Helen',
  );

  final ChatUser _gptChatUser = ChatUser(
    id: '2',
    firstName: 'AgriKaChat',
    lastName: 'Bot',
    profileImage: 'https://i.ibb.co/vwLqmXb/Agri-Ka-Chat-Bot.png', // Set user icon for the bot
  );

  

  final List<ChatMessage> _messages = <ChatMessage>[];
  final List<ChatUser> _typingUsers = <ChatUser>[];

  @override
  void initState() {
    super.initState();

    // Load the OpenAI API key from the .env file
    final String? openAIKey = dotenv.env['OPEN_AI_API_KEY'];

    // Check if the API key is loaded
    if (openAIKey != null) {
      _openAI = OpenAI.instance.build(
        token: openAIKey,
        baseOption: HttpSetup(
          receiveTimeout: const Duration(seconds: 5),
        ),
        enableLog: true,
      );
      
      // Add starting message from the bot
      _messages.insert(0, ChatMessage(
        user: _gptChatUser,
        createdAt: DateTime.now(),
        text: 'Hi! Ako si AgriKaChat Bot. Maari kang magtanong saakin ng mga bagay patunkol sa pagtatanim at pagiging magsasaka! Ano ang iyong tanong?',
      ));
    } else {
      throw Exception('OpenAI API key is not set in the .env file');
    }
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
      return Messages(
        role: m.user == _user ? Role.user : Role.assistant,
        content: m.text,
      );
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
                text: element.message!.content,
              ),
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
              text: "Mukhang naabot na natin ang limitasyon ng paggamit para sa araw na ito. Paki-subukan ulit mamaya",
            ),
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
