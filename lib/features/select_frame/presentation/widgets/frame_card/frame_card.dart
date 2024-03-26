library frame_card;

import 'dart:typed_data';
import 'dart:ui';

import 'package:einblicke_app/core/ios_properties.dart';
import 'package:einblicke_app/core/theme/ios_theme.dart';
import 'package:einblicke_app/features/in_app_notification/presentation/cubit/in_app_notification_cubit.dart';
import 'package:einblicke_app/features/select_frame/presentation/cubits/frame_image_loader_cubit/frame_image_loader_cubit.dart';
import 'package:einblicke_app/features/select_frame/presentation/cubits/frame_image_loader_cubit/frame_image_loader_states.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
class FrameCard extends StatefulWidget {
  const FrameCard({
    super.key,
    required this.frameInfo,
    required this.onPressed,
  });

  final PairedFrameInfo frameInfo;
  final VoidCallback onPressed;

  @override
  State<FrameCard> createState() => _FrameCardState();
}

class _FrameCardState extends State<FrameCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FrameImageLoaderCubit>().loadFrameImage(
          frameId: widget.frameInfo.id,
        );
  }

  @override
  Widget build(BuildContext context) {
    return _Wrapper(
      onPressed: widget.onPressed,
      child: BlocConsumer<FrameImageLoaderCubit, FrameImageLoaderState>(
        listener: (context, state) {
          if (state is FrameImageLoaderFailure) {
            context
                .read<InAppNotificationCubit>()
                .sendFailureNotification(state.failure);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              // -- Background Image --
              if (state is FrameImageLoaded)
                Positioned.fill(
                  child: _BackgroundImage(
                    imageBytes: state.imageBytes,
                  ),
                ),

              if (state is! FrameImageLoaded)
                Container(
                  color: Colors.white.withOpacity(.95),
                  child: const Center(child: CupertinoActivityIndicator()),
                ),

              // -- Overlay --
              Align(
                alignment: Alignment.bottomCenter,
                child: _Overlay(title: widget.frameInfo.name),
              ),
            ],
          );
        },
      ),
    );
  }
}
