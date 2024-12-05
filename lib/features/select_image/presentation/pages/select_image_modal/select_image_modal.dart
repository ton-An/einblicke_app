library select_image_modal;

import 'dart:io';

import 'package:einblicke_app/core/dependency_injector.dart';
import 'package:einblicke_app/core/l10n/app_localizations.dart';
import 'package:einblicke_app/core/widgets/custom_cupertino_button.dart';
import 'package:einblicke_app/core/widgets/custom_cupertino_modal/custom_cupertino_modal.dart';
import 'package:einblicke_app/core/widgets/custom_cupertino_modal/custom_cupertino_top_bar.dart';
import 'package:einblicke_app/core/widgets/custom_cupertino_small_text_button.dart';
import 'package:einblicke_app/core/widgets/custom_cupertino_text_button.dart';
import 'package:einblicke_app/features/select_frame/presentation/cubits/select_frame_cubit/select_frame_cubit.dart';
import 'package:einblicke_app/features/select_frame/presentation/pages/select_frame_page/select_frame_page.dart';
import 'package:einblicke_app/features/select_image/presentation/cubits/select_image_cubit.dart';
import 'package:einblicke_app/features/select_image/presentation/cubits/select_image_states.dart';
import 'package:einblicke_shared_clients/einblicke_shared_clients.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

part '_image_picker.dart';
part '_send_image_button.dart';

/* To-Do:
  - [ ] Probably convert this to a normal Page instead of a Modal
  - [ ] Add a success sound
  - [ ] Better ui error handling. Currently the user needs to close the modal to retry (and the error notifiaction obscures the cancel button)
  - [ ] Avoid using context across async gaps
*/

/// __Select Image Modal__
/// The modal that allows the user to select an image from their device
/// and send it to the selected picture frame.
///
/// Main contents:
/// - [_ImagePicker]
/// - [_SendImageButton]
class SelectImageModal extends StatelessWidget {
  const SelectImageModal({super.key, required this.frameId});

  static const String pageName = "select_image";
  static const String route = "${SelectFramePage.route}/$pageName";

  final String frameId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SelectImageCubit, SelectImageState>(
      listener: (context, state) {
        if (state is SelectImageFailure) {
          context
              .read<InAppNotificationCubit>()
              .sendFailureNotification(state.failure);
        }

        if (state is SelectImageSuccess) {
          context.read<SelectFrameCubit>().reloadFrames();
          Future.delayed(const Duration(milliseconds: 1500)).then(
            (value) => context.pop(),
          );
        }
      },
      child: CustomCupertinoModal(
        topBar: CustomCupertinoModalTopBar(
          leadingTextButton: CustomCupertinoSmallTextButton(
            text: AppLocalizations.of(context)!.cancel,
            onPressed: () => context.pop(),
          ),
          title: AppLocalizations.of(context)!.imageSelection,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // -- Image Picker --
            const Expanded(child: _ImagePicker()),
            const XMediumGap(),

            // -- Send Image Button --
            _SendImageButton(frameId: frameId),
          ],
        ),
      ),
    );
  }
}
