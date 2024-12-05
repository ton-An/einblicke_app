part of add_frame_modal;

class _CameraView extends StatelessWidget {
  const _CameraView();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(
            CustomCupertinoProperties.borderRadius * 2,
          ),
          child: Container(
            width: 300,
            height: 300,
            color: CustomCupertinoTheme.of(context).colors.fieldColor,
            child: MobileScanner(
              onDetect: (BarcodeCapture capture) {
                for (Barcode barcode in capture.barcodes) {
                  print(barcode.rawValue);
                  if (barcode.rawValue?.startsWith("einblicke-") ?? false) {
                    context
                        .read<AddFrameCubit>()
                        .recognizeFrame(qrCode: barcode.rawValue!);
                  }
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
