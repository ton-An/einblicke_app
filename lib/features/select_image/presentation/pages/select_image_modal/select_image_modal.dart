library select_image_modal;

import 'dart:io';

import 'package:einblicke_app/core/dependency_injector.dart';
import 'package:einblicke_app/core/ios_properties.dart';
import 'package:einblicke_app/core/l10n/app_localizations.dart';
import 'package:einblicke_app/core/theme/ios_theme.dart';
import 'package:einblicke_app/core/widgets/gaps/small_gap.dart';
import 'package:einblicke_app/core/widgets/gaps/x_medium_gap.dart';
import 'package:einblicke_app/core/widgets/ios_button.dart';
import 'package:einblicke_app/core/widgets/ios_text_button.dart';
import 'package:einblicke_app/features/authentication/presentation/pages/sign_in_page/sign_in_page.dart';
import 'package:einblicke_app/features/select_frame/presentation/pages/select_frame_page/select_frame_page.dart';
import 'package:einblicke_app/features/select_image/presentation/cubits/select_image_cubit.dart';
import 'package:einblicke_app/features/select_image/presentation/cubits/select_image_states.dart';
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
  // static const String route = "/select_frame/$pageName";
  static const String route = "${SelectFramePage.route}/$pageName";

  @override
  Widget build(BuildContext context) {
    return BlocListener<SelectImageCubit, SelectImageState>(
      listener: (context, state) {
        if (state is SelectImageAuthFailure) {
          context.go(SignInPage.route);
        }
      },
      child: const _TempScaffold(
        // const IOSModal(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // -- Image Picker --
            Expanded(child: Center(child: _ImagePicker())),
            XMediumGap(),

            // -- Send Image Button --
            _SendImageButton(),
          ],
        ),
      ),
    );
  }
}

class _TempScaffold extends StatelessWidget {
  const _TempScaffold({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            left: IOSTheme.of(context).spacing.xMedium,
            right: IOSTheme.of(context).spacing.xMedium,
            bottom: IOSTheme.of(context).spacing.xLarge,
          ),
          child: child,
        ),
      ),
    );
  }
}
