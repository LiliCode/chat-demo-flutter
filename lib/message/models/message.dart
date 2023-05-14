import 'package:flutter_chat_demo/user/models/user_model.dart';

enum MessageDiration {
  receive,
  send,
}

class MessageType {
  static const text = 'text';
  static const image = 'image';
  static const video = 'video';
}

class MessageContent {
  String? type;
  String? msg;

  MessageContent({this.msg, this.type});

  MessageContent.fromJson(Map<String, dynamic> json) {
    type = json['type'] ?? MessageType.text;
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'msg': msg};
  }
}

class Message {
  User? to;
  User? from;
  MessageContent? content;
  MessageDiration diration = MessageDiration.send;

  Message({
    this.content,
    this.from,
    this.to,
    this.diration = MessageDiration.send,
  });

  Message toLeftMessage() {
    diration = MessageDiration.receive;
    return this;
  }

  Message.fromJson(Map<String, dynamic> json) {
    to = User.fromJson(json['to']);
    from = User.fromJson(json['from']);
    content = MessageContent.fromJson(json['content']);
  }

  Map<String, dynamic> toJson() {
    return {
      'to': to?.toJson(),
      'from': from?.toJson(),
      'content': content?.toJson(),
    };
  }
}
