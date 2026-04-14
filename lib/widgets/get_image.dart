import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
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

  /// Error image type
  final ImageType? errorImageType;

  /// 🔥 GLOBAL ERROR IMAGE (Optional)
  static String? globalErrorImage;
  static ImageType globalErrorImageType = ImageType.asset;

  /// Optional manual override for type, otherwise auto detect
  final ImageType imageType;

  /// ✨ Shimmer colors
  final Color shimmerBaseColor;
  final Color shimmerHighlightColor;

  const GetImage({
    super.key,
    this.imagePath,
    this.width = 80,
    this.height = 80,
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
    this.errorImageType,
    this.imageType = ImageType.auto,
    this.shimmerBaseColor = const Color(0xFFE0E0E0),
    this.shimmerHighlightColor = const Color(0xFFF5F5F5),
  });

  // -------------------
  // HELPERS
  // -------------------
  bool _isNetwork(String path) =>
      path.startsWith("http://") || path.startsWith("https://");

  bool _isAsset(String path) =>
      !path.startsWith("http") && !path.startsWith("/") && !path.contains("://");

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

  // -------------------
  // ERROR IMAGE HANDLER
  // -------------------
  Widget _buildError() {
    final String? errPath = errorImagePath ?? globalErrorImage;
    final ImageType errType = errorImageType ?? globalErrorImageType;

    if (errPath == null || errPath.trim().isEmpty) {
      return Image.asset(
        "assets/default.png",
        width: width,
        height: height,
        fit: fit,
      );
    }

    switch (errType) {
      case ImageType.asset:
        return Image.asset(
          errPath,
          width: width,
          height: height,
          fit: fit,
          color: imageColor,
        );
      case ImageType.network:
        return CachedNetworkImage(
          imageUrl: errPath,
          width: width,
          height: height,
          fit: fit,
        );
      case ImageType.file:
        return Image.file(
          File(errPath),
          width: width,
          height: height,
          fit: fit,
          color: imageColor,
        );
      case ImageType.memory:
        return Image.memory(
          Uint8List(0),
          width: width,
          height: height,
          fit: fit,
          color: imageColor,
        );
      default:
        return Image.asset(
          "assets/default.png",
          width: width,
          height: height,
          fit: fit,
        );
    }
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
          (true
              ? () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FullPhotoView(
                  images: [imagePath],
                  isAsset: type == ImageType.asset,
                  isSingleImage: true,
                  backgroundDecoration: backgroundDecoration,
                  onPageChanged: onPageChanged,
                  pageController: pageController,
                  appBar: appBar,
                ),
              ),
            );
          }
              : null),
      child: ClipRRect(
        borderRadius:
        borderRadius ?? BorderRadius.circular(radius ?? 8),
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
          fit: fit,
          color: imageColor,
          errorBuilder: (_, __, ___) => _buildError(),
        );
      case ImageType.file:
        return Image.file(
          img,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (_, __, ___) => _buildError(),
        );
      case ImageType.asset:
        return Image.asset(
          img,
          width: width,
          height: height,
          fit: fit,
          color: imageColor,
          errorBuilder: (_, __, ___) => _buildError(),
        );
      case ImageType.network:
        return _buildNetwork(img);
      default:
        return _buildError();
    }
  }

  Widget _buildNetwork(String url) {
    return FutureBuilder(
      future: Future.delayed(imageLoadingDelay),
      builder: (_, snapshot) {
        return CachedNetworkImage(
          imageUrl: url,
          width: width,
          height: height,
          fit: fit,
          imageBuilder: (context, provider) {
            return Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                image: DecorationImage(image: provider, fit: fit),
              ),
            );
          },
          progressIndicatorBuilder: (context, url, downloadProgress) {
            double progress = downloadProgress.progress ?? 0.0;
            switch (loadingType) {
              case LoadingType.progress:
                return Center(
                  child: CircularProgressIndicator(
                    value: progress,
                    color: loadingColor,
                  ),
                );
              case LoadingType.linear:
                return LinearProgressIndicator(
                  value: progress,
                  color: loadingColor,
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
          errorWidget: (_, __, ___) => errorWidget ?? _buildError(),
        );
      },
    );
  }
}
