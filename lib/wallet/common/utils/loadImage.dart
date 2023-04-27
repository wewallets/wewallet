import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mars/wallet/common/component_index.dart';

// 图片加载（支持本地与网络图片）
class LoadImage extends StatelessWidget {
  const LoadImage(this.image, {Key key, this.width, this.height, this.fit: BoxFit.cover, this.format: "png", this.holderImg = 'login_icon', this.holderImgWidth = 50, this.placeholderLoading = true, this.alignment}) : super(key: key);

  final String image;
  final double width;
  final double height;
  final BoxFit fit;
  final String format;
  final String holderImg; //默认图片
  final bool placeholderLoading;
  final double holderImgWidth;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    if (image == null || image == "" || image == "null") {
      return Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        color: Colours().themeColor,
        // child: LoadAssetImage('finance_xmr', width: adaptation(holderImgWidth), fit: BoxFit.contain),
      );
    } else {
      if (image.startsWith("http")) {
        return Container(
            width: width,
            alignment: Alignment.center,
            height: height,
            child: CachedNetworkImage(
              imageUrl: image,
              placeholder: (context, url) => placeholderLoading
                  ? Container(
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colours().themeColor)),
                    )
                  : Container(
                      height: height,
                      width: width,
                      color: Colours().themeColor,
                      alignment: Alignment.center,
                      // child: LoadAssetImage('finance_xmr', width: adaptation(holderImgWidth), fit: BoxFit.contain),
                    ),
              errorWidget: (context, url, error) => Container(
                height: height,
                width: width,
                alignment: Alignment.center,
                color: Colours().themeColor,
                // child: LoadAssetImage('finance_xmr', width: adaptation(holderImgWidth), fit: BoxFit.contain),
              ),
              width: width,
              height: height,
              fit: fit,
            ));
      } else {
        return LoadAssetImage(image, height: height, width: width, fit: fit, format: format, alignment: alignment);
      }
    }
  }
}

/// 加载本地资源图片
class LoadAssetImage extends StatelessWidget {
  const LoadAssetImage(this.image, {Key key, this.width, this.height, this.fit, this.format: 'png', this.color, this.alignment}) : super(key: key);

  final String image;
  final double width;
  final double height;
  final BoxFit fit;
  final String format;
  final Color color;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      getImgPath(image, format: format),
      height: height,
      alignment: alignment ?? Alignment.center,
      width: width,
      fit: fit,
      color: color,
    );
  }
}

//获取资源地址
String getImgPath(String name, {String format: 'png'}) {
  return 'assets/wallet/$name.$format';
}
