import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({super.key,required this.message,required this.isUser});
  final String message;
  final bool isUser;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.80),
            decoration: BoxDecoration(
              color: isUser 
                ?Colors.deepPurple : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16)
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 12
            ),
            margin: const EdgeInsets.only(bottom: 8),
            child: MarkdownBody(
              data: message,
            ),
          ),
        )
      ],
    );
  }
}
