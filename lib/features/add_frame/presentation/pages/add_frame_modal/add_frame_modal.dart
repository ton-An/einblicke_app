library add_frame_modal;

import 'package:einblicke_app/core/l10n/app_localizations.dart';
import 'package:einblicke_app/core/widgets/custom_cupertino_modal/custom_cupertino_modal.dart';
import 'package:einblicke_app/core/widgets/custom_cupertino_modal/custom_cupertino_top_bar.dart';
import 'package:einblicke_app/core/widgets/custom_cupertino_small_text_button.dart';
import 'package:einblicke_app/core/widgets/custom_cupertino_text_button.dart';
import 'package:einblicke_app/core/widgets/custom_cupertino_text_field.dart';
import 'package:einblicke_app/features/add_frame/presentation/cubit/add_frame_cubit/add_frame_cubit.dart';
import 'package:einblicke_app/features/add_frame/presentation/cubit/add_frame_cubit/add_frame_states.dart';
import 'package:einblicke_app/features/select_frame/presentation/cubits/select_frame_cubit/select_frame_cubit.dart';
import 'package:einblicke_app/features/select_frame/presentation/pages/select_frame_page/select_frame_page.dart';
import 'package:einblicke_shared_clients/einblicke_shared_clients.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

part 'naming_page/_add_frame_button.dart';
part 'naming_page/_name_text_field.dart';
part 'naming_page/_naming_page.dart';
part 'naming_page/_title.dart';
part 'scanner_page/_camera_view.dart';
part 'scanner_page/_description.dart';
part 'scanner_page/_scanner_page.dart';
part 'scanner_page/_title.dart';

class AddFrameModal extends StatelessWidget {
  const AddFrameModal({super.key});

  static const String pageName = "add_frame_modal";
  static const String route = "${SelectFramePage.route}/$pageName";

  @override
  Widget build(BuildContext context) {
    return CustomCupertinoModal(
      topBar: CustomCupertinoModalTopBar(
        leadingTextButton: CustomCupertinoSmallTextButton(
          text: AppLocalizations.of(context)!.cancel,
          onPressed: () => context.pop(),
        ),
      ),
      child: BlocConsumer(
          bloc: context.read<AddFrameCubit>(),
          listener: (context, state) {
            if (state is AddFrameSuccessful) {
              context.read<SelectFrameCubit>().reloadFrames();
              context.pop();
            }

            if (state is AddFrameFailure) {
              context
                  .read<InAppNotificationCubit>()
                  .sendFailureNotification(state.failure);
            }
          },
          builder: (context, state) {
            if (state is AddFrameRecognized) return const _NamingPage();

            if (state is AddFrameLoading) return Center(child: const Loader());

            return _ScannerPage();
          }),
    );
  }
}
