library select_image_modal;

import 'dart:io';

import 'package:dispatch_pi_app/core/dependency_injector.dart';
import 'package:dispatch_pi_app/core/l10n/app_localizations.dart';
import 'package:dispatch_pi_app/core/theme/ios_theme.dart';
import 'package:dispatch_pi_app/core/widgets/dispatch_button.dart';
import 'package:dispatch_pi_app/core/widgets/dispatch_text_button.dart';
import 'package:dispatch_pi_app/core/widgets/disptach_modal.dart';
import 'package:dispatch_pi_app/core/widgets/gaps/small_gap.dart';
import 'package:dispatch_pi_app/core/widgets/gaps/x_medium_gap.dart';
import 'package:dispatch_pi_app/features/authentication/presentation/pages/sign_in_page/sign_in_page.dart';
import 'package:dispatch_pi_app/features/select_image/cubits/select_image_cubit.dart';
import 'package:dispatch_pi_app/features/select_image/cubits/select_image_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

part '_image_picker.dart';
part '_send_image_button.dart';

/// __Select Image Modal__
/// The modal that allows the user to select an image from their device
/// and send it to the selected picture frame.
///
/// Main contents:
/// - [_ImagePicker]
/// - [_SendImageButton]
class SelectImageModal extends StatelessWidget {
  const SelectImageModal({super.key});

  static const String pageName = "select_image";
  static const String route = "/select_frame/$pageName";

  @override
  Widget build(BuildContext context) {
    return BlocListener<SelectImageCubit, SelectImageState>(
      listener: (context, state) {
        if (state is SelectImageAuthFailure) {
          context.go(SignInPage.route);
        }
      },
      child: const DispatchModal(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: Center(child: _ImagePicker())),
            XMediumGap(),
            _SendImageButton(),
          ],
        ),
      ),
    );
  }
}
