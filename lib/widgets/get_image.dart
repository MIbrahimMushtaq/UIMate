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

enum LoadingType { progress, linear, shimmer }
enum ImageType { asset, network, file, memory, auto }

class GetImage extends StatelessWidget {
  final dynamic imagePath;

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

  final LoadingType loadingType;

  /// LOCAL error image overrides GLOBAL
  final String? errorImagePath;

  /// 🔥 GLOBAL ERROR IMAGE (Optional)
  static String? globalErrorImage;

  /// Optional manual override for type, otherwise auto detect
  final ImageType imageType;

  /// ✨ Shimmer colors
  final Color shimmerBaseColor;
  final Color shimmerHighlightColor;

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
    this.imageType = ImageType.auto,
    this.shimmerBaseColor = const Color(0xFFE0E0E0),
    this.shimmerHighlightColor = const Color(0xFFF5F5F5),
  });

  // ---- HELPERS ----
  bool _isNetwork(String path) =>
      path.startsWith("http://") || path.startsWith("https://");

  bool _isAsset(String path) =>
      !path.startsWith("http") &&
          !path.startsWith("/") &&
          !path.contains("://");

  // ---- ERROR IMAGE HANDLER ----
  Widget _buildError() {
    String? errorSource = errorImagePath ?? globalErrorImage;

    if (errorSource == null) {
      return Image.asset("assets/default.png", fit: fit);
    }

    // detect based on string
    if (_isNetwork(errorSource)) {
      return CachedNetworkImage(imageUrl: errorSource, fit: fit);
    } else if (_isAsset(errorSource)) {
      return Image.asset(errorSource, fit: fit);
    } else if (File(errorSource).existsSync()) {
      return Image.file(File(errorSource), fit: fit);
    }

    return Image.asset("assets/default.png", fit: fit);
  }

  // ---- AUTO TYPE DETECTION ----
  ImageType _detectType(dynamic img) {
    if (imageType != ImageType.auto) return imageType;

    if (img is Uint8List) return ImageType.memory;
    if (img is File) return ImageType.file;
    if (img.runtimeType.toString() == 'XFile') return ImageType.file;

    if (img is String) {
      if (_isNetwork(img)) return ImageType.network;
      if (_isAsset(img)) return ImageType.asset;
      if (File(img).existsSync()) return ImageType.file;
    }

    return ImageType.asset; // fallback
  }

  @override
  Widget build(BuildContext context) {
    if (imagePath == null || imagePath.toString().trim().isEmpty) {
      return _buildError();
    }

    dynamic img = imagePath;
    ImageType type = _detectType(img);

    if (img.runtimeType.toString() == 'XFile') {
      img = File(img.path);
    }
    if (type == ImageType.file && img is String) {
      img = File(img);
    }

    return GestureDetector(
      onTap: onTap ??
          (Static.defaultImageClick
              ? () {
            pSetRout(
              page: () => FullPhotoView(
                images: [imagePath],
                isAsset: type == ImageType.asset,
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
        borderRadius:
        borderRadius ?? BorderRadius.circular(radius ?? Siz.defaultRadius),
        child: _buildByType(type, img),
      ),
    );
  }

  Widget _buildByType(ImageType type, dynamic img) {
    switch (type) {
      case ImageType.memory:
        return Image.memory(
          img,
          width: width,
          height: height,
          color: imageColor,
          fit: fit,
          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) => _buildError(),
        );

      case ImageType.file:
        return Image.file(
          img,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) => _buildError(),
        );

      case ImageType.asset:
        return Image.asset(
          img,
          width: width,
          height: height,
          color: imageColor,
          fit: fit,
          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) => _buildError(),
        );

      case ImageType.network:
        return buildFutureBuilderImage(img);

      default:
        return _buildError();
    }
  }

  // ---- NETWORK HANDLER ----
  Widget buildFutureBuilderImage(String url) {
    return FutureBuilder(
      future: Future.delayed(imageLoadingDelay),
      builder: (context, snapshot) {
        return CachedNetworkImage(
          imageUrl: url,
          fit: fit,
          imageBuilder: (context, provider) {
            return Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                image: DecorationImage(image: provider, fit: fit),
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
                  baseColor: shimmerBaseColor,
                  highlightColor: shimmerHighlightColor,
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
