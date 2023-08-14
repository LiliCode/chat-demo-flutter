import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/message/models/message.dart';
import 'package:flutter_chat_demo/tools/icons/app_icons.dart';

class MessageWidget extends StatelessWidget {
  final Message message;

  const MessageWidget({super.key, required this.message});

  Widget _buildAvatar(String url) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: url,
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 30,
        maxWidth: (width - 40 - 56),
        minHeight: 40,
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: MessageDiration.send == message.diration
              ? Colors.blue
              : Colors.black12,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Text(
          message.content?.msg ?? '',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildMessage(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: message.diration == MessageDiration.send
              ? [
                  Expanded(child: Container()),
                  _buildText(context),
                  const SizedBox(
                    width: 6,
                    height: 40,
                    child: Stack(
                      children: [
                        Positioned(
                          left: -10,
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Icon(
                            AppIcons.caretRight,
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                  _buildAvatar(message.from?.avatar ?? '')
                ]
              : [
                  _buildAvatar(message.to?.avatar ?? ''),
                  const SizedBox(
                    width: 6,
                    height: 40,
                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          left: -9,
                          top: 0,
                          bottom: 0,
                          child: Icon(
                            AppIcons.caretLeft,
                            color: Colors.black12,
                          ),
                        )
                      ],
                    ),
                  ),
                  _buildText(context),
                  Expanded(child: Container())
                ],
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildMessage(context);
  }
}
