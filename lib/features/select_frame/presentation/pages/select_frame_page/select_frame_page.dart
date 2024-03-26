library select_frame_page;

import 'package:einblicke_app/core/dependency_injector.dart';
import 'package:einblicke_app/features/in_app_notification/presentation/cubit/in_app_notification_cubit.dart';
import 'package:einblicke_app/features/select_frame/presentation/cubits/frame_image_loader_cubit/frame_image_loader_cubit.dart';
import 'package:einblicke_app/features/select_frame/presentation/cubits/select_frame_cubit/select_frame_cubit.dart';
import 'package:einblicke_app/features/select_frame/presentation/cubits/select_frame_cubit/select_frame_states.dart';
import 'package:einblicke_app/features/select_frame/presentation/widgets/frame_card/frame_card.dart';
import 'package:einblicke_app/features/select_image/presentation/pages/select_image_modal/select_image_modal.dart';
import 'package:einblicke_shared/einblicke_shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:go_router/go_router.dart';

part '_carousel.dart';

/* 
  To-Dos:
  - [ ] Maybe make the carousel scrollable via touchpad
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
    context.read<SelectFrameCubit>().loadFrames();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: BlocConsumer<SelectFrameCubit, SelectFrameState>(
        listener: (context, state) {
          if (state is SelectFrameFailure) {
            context
                .read<InAppNotificationCubit>()
                .sendFailureNotification(state.failure);
          }
        },
        builder: (context, state) {
          if (state is SelectFrameInitialState) {
            return const Center(child: CupertinoActivityIndicator());
          }

          if (state is SelectFrameLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Carousel(frames: state.framesInfo),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}
