import 'package:bhakti_app/config.dart';

class MangalaContainer extends StatelessWidget {
  final HomeScreenProvider homeScreenPvr;

  const MangalaContainer(this.homeScreenPvr, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(children: [
      CommonContainer(
          onTap: () => homeScreenPvr.onManglaArtiSelect(context),
          text: language(context,appFonts.mangalaArti),
          timeText: language(context,homeScreenPvr.mangalaArtiTime),
          svgImage: eSvgAssets.mangalaAarti),
      const Positioned(
          right: Sizes.s58,
          top: Sizes.s11,
          child: CommonCircleDesign(height: Sizes.s6, width: Sizes.s6)),
      const Positioned(
          right: Sizes.s21,
          top: Sizes.s4,
          child: CommonCircleDesign(height: Sizes.s10, width: Sizes.s10)),
      const Positioned(
          left: Sizes.s70,
          bottom: Sizes.s36,
          child: CommonCircleDesign(height: Sizes.s10, width: Sizes.s10))
    ]));
  }
}
