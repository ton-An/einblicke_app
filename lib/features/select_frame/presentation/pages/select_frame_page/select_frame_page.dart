library select_frame_page;

import 'dart:async';

import 'package:einblicke_app/core/dependency_injector.dart';
import 'package:einblicke_app/core/l10n/app_localizations.dart';
import 'package:einblicke_app/core/theme/ios_theme.dart';
import 'package:einblicke_app/core/widgets/gaps/x_medium_gap.dart';
import 'package:einblicke_app/core/widgets/loader.dart';
import 'package:einblicke_app/features/in_app_notification/presentation/cubit/in_app_notification_cubit.dart';
import 'package:einblicke_app/features/select_frame/presentation/cubits/select_frame_cubit/select_frame_cubit.dart';
import 'package:einblicke_app/features/select_frame/presentation/cubits/select_frame_cubit/select_frame_states.dart';
import 'package:einblicke_app/features/select_frame/presentation/cubits/single_image_loader_cubit/single_image_loader_cubit.dart';
import 'package:einblicke_app/features/select_frame/presentation/cubits/single_image_loader_cubit/single_image_loader_states.dart';
import 'package:einblicke_app/features/select_frame/presentation/widgets/frame_card/frame_card.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:sprung/sprung.dart';

part '_fade_switcher.dart';
part '_frame_carousel.dart';
part '_loaded_frames.dart';
part '_pull_to_refresh.dart';

/* 
  To-Dos:
  - [ ] Maybe make the carousel scrollable via touchpad
  - [ ] Atm it can happen that only a Container is shown (e.g. on error), maybe show a message or something similar
*/

/// __Select Frame Page__
///
/// This page is a view of the available picture frames that the user can select
/// from. The user can scroll through the frames and select one to continue on
///
/// Main contents:
/// - [FrameCard]s
class SelectFramePage extends StatefulWidget {
  const SelectFramePage({super.key});

  static const String pageName = "select_frame";
  static const String route = "/$pageName";

  @override
  State<SelectFramePage> createState() => _SelectFramePageState();
}

class _SelectFramePageState extends State<SelectFramePage> {
  @override
  void initState() {
    super.initState();

    /// Loads the frames after a delay to ease the transition between the
    /// loader and the frames
    Future.delayed(
      const Duration(milliseconds: 500),
    ).then((value) => context.read<SelectFrameCubit>().loadFrames());
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: _PullToRefresh(
        child: SafeArea(
          left: false,
          right: false,
          child: BlocConsumer<SelectFrameCubit, SelectFrameState>(
            listener: (context, state) {
              if (state is SelectFrameFailure) {
                context
                    .read<InAppNotificationCubit>()
                    .sendFailureNotification(state.failure);
              }
            },
            builder: (context, state) {
              if (state is SelectFrameLoaded ||
                  state is SelectFrameInitialState) {
                return _FadeSwitcher(
                  child: state is SelectFrameLoaded
                      ? _LoadedFrames(
                          frames: state.frames,
                        )
                      : const Align(
                          alignment: Alignment.center,
                          child: Loader(),
                        ),
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}
