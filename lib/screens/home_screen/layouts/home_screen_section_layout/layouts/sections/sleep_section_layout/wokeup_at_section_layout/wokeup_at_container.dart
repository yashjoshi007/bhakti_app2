import 'package:bhakti_app/config.dart';

class WokeUpAtContainer extends StatelessWidget {
  final HomeScreenProvider homeScreenPvr;

  const WokeUpAtContainer(this.homeScreenPvr, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(children: [
      // wokeup time select
      CommonContainer(
          onTap: () => homeScreenPvr.onWokeUpTimeSelect(context),
          text: language(context,appFonts.wokeUpAt),
          timeText: language(context,homeScreenPvr.wakeupTime),
          svgImage: eSvgAssets.wokeTime),
      const Positioned(
          right: Sizes.s58,
          top: Sizes.s11,
          child: CommonCircleDesign(height: Sizes.s6, width: Sizes.s6)),
      const Positioned(
          right: Sizes.s57,
          bottom: Sizes.s26,
          child: CommonCircleDesign(height: Sizes.s6, width: Sizes.s6)),
      const Positioned(
          right: Sizes.s74,
          bottom: Sizes.s9,
          child: CommonCircleDesign(height: Sizes.s6, width: Sizes.s6)),
      const Positioned(
          right: Sizes.s18,
          top: Sizes.s13,
          child: CommonCircleDesign(height: Sizes.s10, width: Sizes.s10)),
      const Positioned(
          right: Sizes.s4,
          top: Sizes.s30,
          child: CommonCircleDesign(height: Sizes.s10, width: Sizes.s10)),
      const Positioned(
          left: Sizes.s70,
          bottom: Sizes.s36,
          child: CommonCircleDesign(height: Sizes.s10, width: Sizes.s10))
    ]));
  }
}
