library select_image_page;

import 'dart:io';

import 'package:dispatch_pi_app/core/dependency_injector.dart';
import 'package:dispatch_pi_app/core/l10n/app_localizations.dart';
import 'package:dispatch_pi_app/core/theme/ios_theme.dart';
import 'package:dispatch_pi_app/core/widgets/dispatch_button.dart';
import 'package:dispatch_pi_app/core/widgets/dispatch_text_button.dart';
import 'package:dispatch_pi_app/core/widgets/disptach_modal.dart';
import 'package:dispatch_pi_app/core/widgets/gaps/small_gap.dart';
import 'package:dispatch_pi_app/core/widgets/gaps/x_medium_gap.dart';
import 'package:dispatch_pi_app/features/select_image/cubits/select_image_cubit.dart';
import 'package:dispatch_pi_app/features/select_image/cubits/select_image_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

part '_image_picker.dart';
part '_send_image.dart';

class SelectImage extends StatelessWidget {
  const SelectImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SelectImageCubit, SelectImageState>(
      listener: (context, state) {
        if (state is SelectImageAuthFailure) {
          context.go("/sign_in");
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
