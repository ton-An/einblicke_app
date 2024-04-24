library frame_card;

import 'dart:ui';

import 'package:einblicke_app/core/custom_cupertino_properties.dart';
import 'package:einblicke_app/core/theme/custom_cupertino_theme.dart';
import 'package:einblicke_app/features/select_frame/presentation/cubits/single_image_loader_cubit/single_image_loader_cubit.dart';
import 'package:einblicke_app/features/select_frame/presentation/cubits/single_image_loader_cubit/single_image_loader_states.dart';
import 'package:einblicke_app/features/select_image/presentation/pages/select_image_modal/select_image_modal.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
    required this.frameInfo,
  });

  final PairedFrameInfo frameInfo;

  @override
  Widget build(BuildContext context) {
    return _Wrapper(
      frameId: frameInfo.id,
      child: Stack(
        children: [
          // -- Background Image --
          const Positioned.fill(
            child: _BackgroundImage(),
          ),

          // -- Overlay --
          Align(
            alignment: Alignment.bottomCenter,
            child: _Overlay(title: frameInfo.name),
          ),
        ],
      ),
    );
  }
}
