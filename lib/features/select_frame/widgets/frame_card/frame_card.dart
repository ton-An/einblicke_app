library frame_card;

import 'dart:ui';

import 'package:dispatch_pi_app/core/ios_properties.dart';
import 'package:dispatch_pi_app/core/theme/ios_theme.dart';
import 'package:flutter/material.dart';

part '_background_image.dart';
part '_online_indicator.dart';
part '_overlay.dart';
part '_title.dart';
part '_wrapper.dart';

/// __FrameCard__
/// A card that displays a single picture frame.
///
/// Main contents:
/// - [_BackgroundImage]
/// - [_Overlay]
///   - [_Title]
///   - [_OnlineIndicator]
class FrameCard extends StatelessWidget {
  const FrameCard({
    super.key,
    required this.title,
    required this.imgPath,
    required this.onPressed,
  });

  final String title;
  final String imgPath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return _Wrapper(
      onPressed: onPressed,
      child: Stack(
        children: [
          // -- Background Image --
          Positioned.fill(
            child: _BackgroundImage(imgPath: imgPath),
          ),

          // -- Overlay --
          Align(
            alignment: Alignment.bottomCenter,
            child: _Overlay(title: title),
          ),
        ],
      ),
    );
  }
}
