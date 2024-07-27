import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:testt/util/colors.dart';
import 'package:testt/util/consts.dart';
import 'package:testt/util/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

class GeminiScreen extends StatefulWidget {
  const GeminiScreen({super.key});

  @override
  State<GeminiScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<GeminiScreen> {
  final TextEditingController _textController = TextEditingController();

  ChatUser currentUser = ChatUser(id: '0', firstName: 'User');

  ChatUser geminiUser = ChatUser(
    id: '1',
    firstName: 'Deadbot',
    profileImage:
        'https://seeklogo.com/images/D/deadpool-icon-logo-099A2EF8A8-seeklogo.com.png',
  );

  List<ChatMessage> messages = [];

  late Gemini gemini = Gemini.instance;

  @override
  Widget build(BuildContext context) {
    Gemini.init(apiKey: apiKey);
    bool isLight() {
      if (Theme.of(context).textTheme.bodyLarge!.color == Colors.black) {
        return true;
      } else
        return false;
    }


    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.primary,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Deadbot Chat',
          style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700),
        ),
      ),
      body: _BuildUi(),
    );
  }

  Widget _BuildUi() {
    bool isLight() {
      if (Theme.of(context).textTheme.bodyLarge!.color == Colors.black) {
        return true;
      } else
        return false;
    }

    bool Is = isLight();
    return DashChat(
      messageOptions: MessageOptions(
        containerColor:
            Is ? TColors.dark.withOpacity(0.1) : TColors.light.withOpacity(0.1),
        messageTextBuilder:
            (ChatMessage text, ChatMessage? message, ChatMessage? message2) {

          return SelectableLinkify(
            text: text.text,
            style: Is ? TtextTheme.lightTextTheme.labelLarge : TtextTheme.darkTextTheme.labelLarge,
            linkStyle: const TextStyle(
              color: Colors.blueAccent,
            ),
          );
        },
      ),
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
      inputOptions: InputOptions(
          inputDecoration: InputDecoration(
              hintText: 'write a message...',
              hintStyle: MyFonts.font15grey,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none),
              filled: true,
              fillColor: Is
                  ? TColors.dark.withOpacity(0.1)
                  : TColors.light.withOpacity(0.1)),
          textController: _textController,
          inputTextStyle: Is
              ? TtextTheme.lightTextTheme.titleMedium
              : TtextTheme.darkTextTheme.titleMedium),
    );
  }


  void _sendMessage(ChatMessage chatMessage) {
    messages = [chatMessage, ...messages];
    setState(() {});

    try {
      String question = chatMessage.text;
      gemini.streamGenerateContent(question).listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0);
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          lastMessage.text += response;
          setState(
            () {
              messages = [lastMessage!, ...messages];
            },
          );
        } else {
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          ChatMessage message = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: response,
          );
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
