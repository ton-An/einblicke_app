import 'package:dispatch_pi_app/features/select_frame/widgets/frame_card/frame_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:go_router/go_router.dart';

class SelectFramePage extends StatelessWidget {
  const SelectFramePage({super.key});

  static const String pageName = "select_frame";
  static const String route = "/$pageName";

  static const List<_PictureFrameModel> _frames = [
    _PictureFrameModel(
        title: "Home", imgPath: "assets/images/unlicensed/dummy_image2.jpeg"),
    _PictureFrameModel(
        title: "Oskar", imgPath: "assets/images/unlicensed/dummy_image1.jpeg"),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlutterCarousel.builder(
            itemCount: _frames.length,
            options: CarouselOptions(
              enlargeCenterPage: true,
              viewportFraction: .6,
              scrollDirection: Axis.horizontal,
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
              enableInfiniteScroll: true,
              showIndicator: false,
            ),
            itemBuilder: (context, i, _) {
              return Center(
                child: FrameCard(
                  imgPath: _frames[i].imgPath,
                  title: _frames[i].title,
                  onPressed: () {
                    context.push("/select_frame/select_image");
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PictureFrameModel {
  const _PictureFrameModel({
    required this.title,
    required this.imgPath,
  });

  final String title;
  final String imgPath;
}
