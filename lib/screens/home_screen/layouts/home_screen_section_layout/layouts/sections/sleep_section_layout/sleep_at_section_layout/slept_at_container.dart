import 'package:bhakti_app/config.dart';

class SleptAtContainer extends StatelessWidget {
  final HomeScreenProvider homeScreenPvr;

  const SleptAtContainer(this.homeScreenPvr, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(children: [
          CommonContainer(
              onTap: () => homeScreenPvr.onSleepTimeSelect(context),
              text: language(context,appFonts.sleptAt),
              timeText: language(context,homeScreenPvr.sleepAt),
              svgImage: eSvgAssets.sleptTimeIcon),
          const Positioned(
              left: Sizes.s64,
              top: Sizes.s7,
              child: CommonCircleDesign(height: Sizes.s6, width: Sizes.s6)),
          const Positioned(
              left: Sizes.s133,
              top: Sizes.s54,
              child: CommonCircleDesign(height: Sizes.s6, width: Sizes.s6)),
          const Positioned(
              left: Sizes.s110,
              bottom: Sizes.s9,
              child: CommonCircleDesign(height: Sizes.s6, width: Sizes.s6)),
          const Positioned(
              left: Sizes.s132,
              top: Sizes.s3,
              child: CommonCircleDesign(height: Sizes.s10, width: Sizes.s10)),
          const Positioned(
              left: Sizes.s142,
              top: Sizes.s29,
              child: CommonCircleDesign(height: Sizes.s10, width: Sizes.s10)),
          const Positioned(
              left: Sizes.s100,
              top: Sizes.s52,
              child: CommonCircleDesign(height: Sizes.s10, width: Sizes.s10))
        ]));
  }
}
