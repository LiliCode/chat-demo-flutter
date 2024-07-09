import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 图片展示，基于 CachedNetworkImage 组件
/// 可以使用比例，圆角，(占位图，错误图片 -> 开发中...)
class CachedImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? radius; // 四个角都圆角
  final BorderRadius? borderRadius; // 圆角
  final double ratio; // 比例
  final Border? border; // border 用于描边
  final double? width;
  final double? height;
  final int? memCacheWidth; // 内存中 resize 之后的尺寸，防止有的网络图片过大导致内存爆增
  final int? memCacheHeight; // 内存中 resize 之后的尺寸，防止有的网络图片过大导致内存爆增
  final BoxFit? fit; // 填充方式，一般 cover fill ...
  final Widget? placeholderWidget;
  final Widget? errorWidget;
  final Duration? fadeInDuration; // 动画时长：淡入
  final Duration? fadeOutDuration; // 动画时长：淡出

  const CachedImageWidget({
    super.key,
    required this.imageUrl,
    this.radius,
    this.borderRadius,
    this.border,
    this.ratio = 1.0,
    this.width,
    this.height,
    this.memCacheWidth,
    this.memCacheHeight,
    this.fit,
    this.placeholderWidget,
    this.errorWidget,
    this.fadeInDuration,
    this.fadeOutDuration,
  });

  @override
  Widget build(BuildContext context) {
    double devicePixelRatio = MediaQuery.of(context).devicePixelRatio / 1.5;

    // 构建一个基于 `CachedNetworkImage` 图片展示组件
    Widget imageWidget = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      fadeInCurve: Curves.linear, // 线性动画
      fadeInDuration: fadeInDuration ?? const Duration(),
      fadeOutCurve: Curves.linear,
      fadeOutDuration: fadeOutDuration ?? const Duration(),
      placeholderFadeInDuration: const Duration(),
      memCacheWidth: memCacheWidth != null
          ? (devicePixelRatio * memCacheWidth!).toInt()
          : null,
      memCacheHeight: memCacheHeight != null
          ? (devicePixelRatio * memCacheHeight!).toInt()
          : null,
      maxWidthDiskCache: memCacheWidth != null
          ? (devicePixelRatio * memCacheWidth!).toInt()
          : null,
      maxHeightDiskCache: memCacheHeight != null
          ? (devicePixelRatio * memCacheHeight!).toInt()
          : null,
      placeholder: (context, url) {
        return placeholderWidget ??
            Container(
              width: width,
              height: height,
              color: Colors.grey,
              child: const CupertinoActivityIndicator(
                animating: true,
              ),
            );
      },
      errorWidget: (context, url, error) {
        return errorWidget ??
            Container(
              width: width,
              height: height,
              color: Colors.grey,
              child: const Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
            );
      },
    );

    // 圆角
    if (radius != null && borderRadius == null) {
      imageWidget = ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(radius!)),
        child: imageWidget,
      );
    }

    if (radius == null && borderRadius != null) {
      imageWidget = ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: imageWidget,
      );
    }

    // 有描边的情况
    if (border != null) {
      // 边框
      imageWidget = ColoredBox(
        color: border!.top.color,
        child: Padding(
          padding: EdgeInsets.all(border!.top.width),
          child: imageWidget,
        ),
      );

      // 边框有圆角
      if (radius != null && borderRadius == null) {
        imageWidget = ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(radius!)),
          child: imageWidget,
        );
      }

      if (radius == null && borderRadius != null) {
        imageWidget = ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.zero,
          child: imageWidget,
        );
      }
    }

    // 比例
    if (ratio != 1.0) {
      imageWidget = AspectRatio(aspectRatio: ratio, child: imageWidget);
    }

    return imageWidget;
  }
}
