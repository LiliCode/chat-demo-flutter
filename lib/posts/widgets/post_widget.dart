import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_demo/posts/modes/post.dart';

class PostWidget extends StatelessWidget {
  final Post model;

  const PostWidget(this.model, {super.key});

  Widget _userWidget() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: model.user?.avatar ?? '',
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.user?.name ?? '无名氏',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              Text(
                '发布于 ${model.date ?? ''}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
        ],
      );

  int _crossAxisCount() => model.images!.length > 3 ? 3 : model.images!.length;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              _userWidget(),
              Padding(
                padding: const EdgeInsets.only(left: 58),
                child: (model.images != null && model.images!.isNotEmpty)
                    ? Column(
                        children: [
                          Text(
                            model.content ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 10),
                          GridView.count(
                            crossAxisCount: _crossAxisCount(),
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            children: model.images
                                    ?.map((e) => CachedNetworkImage(
                                          imageUrl: e,
                                          fit: BoxFit.cover,
                                        ))
                                    .toList() ??
                                [],
                          ),
                        ],
                      )
                    : Text(
                        model.content ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }
}
