import 'package:bhakti_app/config.dart';

class SandhyaContainer extends StatelessWidget {
  final HomeScreenProvider homeScreenPvr;

  const SandhyaContainer(this.homeScreenPvr, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(children: [
      CommonContainer(
          onTap: () => homeScreenPvr.onSandhyaArtiSelect(context),
          text: language(context,appFonts.sandhyaArti),
          timeText: language(context,homeScreenPvr.sandhyaArtiTime),
          svgImage: eSvgAssets.sandhyaArti),
      const Positioned(
          right: Sizes.s58,
          top: Sizes.s11,
          child: CommonCircleDesign(height: Sizes.s6, width: Sizes.s6)),
      const Positioned(
          right: Sizes.s27,
          top: Sizes.s5,
          child: CommonCircleDesign(height: Sizes.s10, width: Sizes.s10)),
      const Positioned(
          right: Sizes.s10,
          bottom: Sizes.s9,
          child: CommonCircleDesign(height: Sizes.s10, width: Sizes.s10)),
      const Positioned(
          left: Sizes.s70,
          bottom: Sizes.s36,
          child: CommonCircleDesign(height: Sizes.s10, width: Sizes.s10))
    ]));
  }
}
