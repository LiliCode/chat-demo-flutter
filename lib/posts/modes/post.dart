import 'package:flutter_chat_demo/user/models/user_model.dart';

class Post {
  User? user;
  String? date;
  String? content;
  List<String>? images;

  Post.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['user']);
    date = json['date'];
    content = json['content'];
    images = json['images'] ?? [];
  }

  Post.buildTest() {
    user = User(
      id: 0,
      name: '马大哈姐姐',
      avatar:
          'https://pics4.baidu.com/feed/b219ebc4b74543a90c3309628f72938ab80114e5.jpeg?token=eca46b203b000814d1cb796a1ee53705&s=A8B27593CDB267BDB0AC88D8030080A3',
      account: 'mdh666',
    );
    date = '2023-5-15';
    content = '放假的在家里有小猫咪陪伴真的很辛福，愿我的小可爱永远在我身边，开开心心';
    images = [
      'https://img0.baidu.com/it/u=2373785398,1181389904&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
      'https://img0.baidu.com/it/u=3451435041,1646658380&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
      'https://up.enterdesk.com/edpic_360_360/98/45/d0/9845d0e542c4d72dd72912b084ad9533.jpg',
      'https://img2.baidu.com/it/u=1585771630,1077013752&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
      'https://inews.gtimg.com/newsapp_bt/0/13799375405/1000',
    ];
  }
}
