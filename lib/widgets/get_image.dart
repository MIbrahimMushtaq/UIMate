// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:ui_mate/widgets/txt.dart';
// import '../helpers/box_decoration.dart';
// import '../helpers/navigation.dart';
// import '../utils/utils.dart';
// import 'full_photo.dart';
// import 'loader.dart';
//
// class GetImage extends StatelessWidget {
//   final String? imagePath;
//   final double width;
//   final double height;
//   final BoxFit fit;
//   final double? radius;
//   final bool isAssets;
//   final Color? imageColor, loadingColor;
//   final BorderRadius? borderRadius;
//   final GestureTapCallback? onTap;
//   final BoxDecoration? backgroundDecoration;
//   final PageController? pageController;
//   final Function(int)? onPageChanged;
//   final PreferredSizeWidget? appBar;
//   final Duration imageLoadingDelay;
//   final Color loadingBgColor;
//   final Widget? errorWidget;
//
//   const GetImage({super.key,
//     this.imagePath,
//     this.width = Siz.profileImageSize,
//     this.height = Siz.profileImageSize,
//     this.fit = BoxFit.cover,
//     this.radius,
//     this.isAssets = false,
//     this.imageColor,
//     this.borderRadius,
//     this.loadingColor,
//     this.onTap,
//     this.backgroundDecoration,
//     this.pageController,
//     this.onPageChanged,
//     this.appBar,
//     this.imageLoadingDelay = const Duration(milliseconds: 100),
//     this.loadingBgColor = Colors.transparent,
//     this.errorWidget
//   });
//
//   static String defaultImage = 'assets/default.png';
//   static bool defImageIsAsset = true;
//
//   @override
//   Widget build(BuildContext context) {
//     bool isAsset = isAssets;
//     if (imagePath == null) {
//       isAsset = true;
//     }
//     return GestureDetector(
//       onTap: onTap ??
//           (Static.defaultImageClick
//               ? () {
//             pSetRout(
//               page: () => FullPhotoView(
//                 images: [imagePath ?? defaultImage],
//                 isAsset: isAsset,
//                 isSingleImage: true,
//                 backgroundDecoration: backgroundDecoration,
//                 onPageChanged: onPageChanged,
//                 pageController: pageController,
//                 appBar: appBar,
//               ), context: context,
//             );
//           }
//               : null),
//       child: ClipRRect(
//         borderRadius:
//         borderRadius ?? BorderRadius.circular(radius ?? Siz.defaultRadius),
//         child: isAsset
//             ? SizedBox(
//           height: height,
//           width: width,
//           child: Image.asset(
//             imagePath ?? defaultImage,
//             color: imageColor,
//             width: width,
//             height: height,
//             fit: fit,
//           ),
//         )
//             : buildFutureBuilderImage(),
//       ),
//     );
//   }
//
//   FutureBuilder<dynamic> buildFutureBuilder() {
//     return FutureBuilder(
//         future: Future.delayed(imageLoadingDelay),
//         builder: (context, asyncSnapshot) {
//           if(asyncSnapshot.connectionState != ConnectionState.done){
//             return Container(
//               height: height,
//               width: width,
//               decoration: pBoxDecoration(
//                 borderRadius: borderRadius ??
//                     BorderRadius.circular(radius ?? Siz.defaultRadius),
//               ),
//               child: LoadingPro(
//                 valueColor: loadingColor ?? Clr.colorPrimary,
//               ),
//             );
//           }
//           return CachedNetworkImage(
//             imageUrl: imagePath ?? defaultImage,
//             imageBuilder: (context, imageProvider) => Container(
//               height: height,
//               width: width,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: imageProvider,
//                   fit: fit,
//                 ),
//               ),
//             ),
//             placeholder: (context, url) => Container(
//               height: height,
//               width: width,
//               decoration: pBoxDecoration(
//                 borderRadius: borderRadius ??
//                     BorderRadius.circular(radius ?? Siz.defaultRadius),
//               ),
//               child: LoadingPro(
//                 valueColor: loadingColor ?? Clr.colorPrimary,
//               ),
//             ),
//             errorWidget: (context, url, error) => Container(
//               height: height,
//               width: width,
//               decoration: pBoxDecoration(
//                 borderRadius: borderRadius ??
//                     BorderRadius.circular(radius ?? Siz.defaultRadius),
//               ),
//               child: Image.asset(defaultImage, width: width, height: height,fit: fit,),
//             ),
//           );
//         }
//     );
//   }
//
//   Widget buildFutureBuilderImage() {
//     return FutureBuilder(
//         future: Future.delayed(imageLoadingDelay),
//         builder: (context, asyncSnapshot) {
//           return CachedNetworkImage(
//             imageUrl: imagePath ?? defaultImage,
//             imageBuilder: (context, provider) {
//               return Container(
//                 height: height,
//                 width: width,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: provider,
//                     fit: fit,
//                   ),
//                 ),
//               );
//             },
//             progressIndicatorBuilder: (context, url, downloadProgress) {
//               double progress = downloadProgress.progress != null && downloadProgress.progress! > 0.0 && downloadProgress.progress! < 1.0? downloadProgress.progress! : 0.0;
//               return Center(
//                 child: CircleAvatar(
//                   backgroundColor: loadingBgColor,
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       SizedBox(
//                         height: height,
//                         width: width,
//                         child: CircularProgressIndicator(
//                           value: progress,
//                           strokeWidth: 4,
//                           color: loadingColor,
//                         ),
//                       ),
//                       Txt('${(progress * 100).toStringAsFixed(0)}%', fontSize: 12, textColor: Clr.colorPrimary),
//                     ],
//                   ),
//                 ),
//               );
//             },
//             errorWidget: (context, url, error) => errorWidget??Container(
//               height: height,
//               width: width,
//               decoration: pBoxDecoration(
//                 borderRadius: borderRadius ??
//                     BorderRadius.circular(radius ?? Siz.defaultRadius),
//               ),
//               child: Image.asset(defaultImage, width: width, height: height,fit: fit,),
//             ),
//           );
//         }
//     );
//   }
// }

import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ui_mate/widgets/txt.dart';

import '../helpers/box_decoration.dart';
import '../helpers/navigation.dart';
import '../utils/utils.dart';
import 'full_photo.dart';
import 'loader.dart';

enum LoadingType { progress, linear, shimmer }

class GetImage extends StatelessWidget {
  final dynamic imagePath; // NEW: now supports String, File, XFile, Uint8List

  final double width;
  final double height;
  final BoxFit fit;
  final double? radius;
  final Color? imageColor, loadingColor;
  final BorderRadius? borderRadius;
  final GestureTapCallback? onTap;
  final BoxDecoration? backgroundDecoration;
  final PageController? pageController;
  final Function(int)? onPageChanged;
  final PreferredSizeWidget? appBar;
  final Duration imageLoadingDelay;
  final Color loadingBgColor;
  final Widget? errorWidget;

  // NEW:
  final LoadingType loadingType;
  final String? errorImagePath;

  const GetImage({
    super.key,
    this.imagePath,
    this.width = Siz.profileImageSize,
    this.height = Siz.profileImageSize,
    this.fit = BoxFit.cover,
    this.radius,
    this.imageColor,
    this.borderRadius,
    this.loadingColor,
    this.onTap,
    this.backgroundDecoration,
    this.pageController,
    this.onPageChanged,
    this.appBar,
    this.imageLoadingDelay = const Duration(milliseconds: 100),
    this.loadingBgColor = Colors.transparent,
    this.errorWidget,
    this.loadingType = LoadingType.progress,
    this.errorImagePath,
  });

  static String defaultImage = 'assets/default.png';
  static bool defImageIsAsset = true;

  bool _isNetwork(String path) =>
      path.startsWith("http://") || path.startsWith("https://");

  bool _isAsset(String path) =>
      !path.startsWith("http") &&
          !path.startsWith("/") &&
          !path.contains("://");

  Widget _buildError() {
    if (errorImagePath != null) {
      if (_isNetwork(errorImagePath!)) {
        return CachedNetworkImage(imageUrl: errorImagePath!, fit: fit);
      } else if (_isAsset(errorImagePath!)) {
        return Image.asset(errorImagePath!, fit: fit);
      } else if (File(errorImagePath!).existsSync()) {
        return Image.file(File(errorImagePath!), fit: fit);
      }
    }

    return Image.asset(
      defaultImage,
      width: width,
      height: height,
      fit: fit,
    );
  }

  @override
  Widget build(BuildContext context) {
    dynamic img = imagePath;

    bool isAssetImage = false;
    bool isNetworkImage = false;
    bool isFileImage = false;
    bool isMemoryImage = false;

    if (img == null || img.toString().trim().isEmpty) {
      return _buildError();
    }

    /// ---- TYPE CHECKING ----
    if (img is Uint8List) {
      isMemoryImage = true;
    } else if (img is File) {
      isFileImage = true;
    } else if (img.runtimeType.toString() == 'XFile') {
      isFileImage = true;
      img = File(img.path);
    } else if (img is String) {
      if (_isNetwork(img)) {
        isNetworkImage = true;
      } else if (_isAsset(img)) {
        isAssetImage = true;
      } else if (File(img).existsSync()) {
        isFileImage = true;
        img = File(img);
      } else {
        isAssetImage = true;
      }
    }

    return GestureDetector(
      onTap: onTap ??
          (Static.defaultImageClick
              ? () {
            pSetRout(
              page: () => FullPhotoView(
                images: [imagePath ?? defaultImage],
                isAsset: isAssetImage,
                isSingleImage: true,
                backgroundDecoration: backgroundDecoration,
                onPageChanged: onPageChanged,
                pageController: pageController,
                appBar: appBar,
              ),
              context: context,
            );
          }
              : null),
      child: ClipRRect(
        borderRadius: borderRadius ??
            BorderRadius.circular(radius ?? Siz.defaultRadius),
        child: isMemoryImage
            ? Image.memory(
          img,
          width: width,
          height: height,
          color: imageColor,
          fit: fit,
          errorBuilder: (_, __, ___) => _buildError(),
        )
            : isFileImage
            ? Image.file(
          img,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (_, __, ___) => _buildError(),
        )
            : isAssetImage
            ? Image.asset(
          img,
          width: width,
          height: height,
          color: imageColor,
          fit: fit,
          errorBuilder: (_, __, ___) => _buildError(),
        )
            : buildFutureBuilderImage(img),
      ),
    );
  }

  // NETWORK IMAGE HANDLING
  Widget buildFutureBuilderImage(String url) {
    return FutureBuilder(
      future: Future.delayed(imageLoadingDelay),
      builder: (context, asyncSnapshot) {
        return CachedNetworkImage(
          imageUrl: url,
          imageBuilder: (context, provider) {
            return Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: provider,
                  fit: fit,
                ),
              ),
            );
          },
          progressIndicatorBuilder: (context, url, downloadProgress) {
            final progress = downloadProgress.progress ?? 0.0;

            switch (loadingType) {
              case LoadingType.progress:
                return Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: height,
                        width: width,
                        child: CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 4,
                          color: loadingColor,
                        ),
                      ),
                      Txt(
                        '${(progress * 100).toStringAsFixed(0)}%',
                        fontSize: 12,
                        textColor: Clr.colorPrimary,
                      ),
                    ],
                  ),
                );

              case LoadingType.linear:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LinearProgressIndicator(
                      value: progress,
                      color: loadingColor,
                    ),
                    const SizedBox(height: 6),
                    Txt(
                      '${(progress * 100).toStringAsFixed(0)}%',
                      fontSize: 12,
                      textColor: Clr.colorPrimary,
                    ),
                  ],
                );

              case LoadingType.shimmer:
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: width,
                    height: height,
                    color: Colors.white,
                  ),
                );
            }
          },
          errorWidget: (context, url, error) =>
          errorWidget ??
              Container(
                height: height,
                width: width,
                decoration: pBoxDecoration(
                  borderRadius: borderRadius ??
                      BorderRadius.circular(radius ?? Siz.defaultRadius),
                ),
                child: _buildError(),
              ),
        );
      },
    );
  }
}
