import 'package:bhakti_app/config.dart';
import 'package:bhakti_app/utils/tool_tip_shape.dart';

class PopUpMenuButtonLayout extends StatelessWidget {
  final PopupMenuItemSelected? onSelected;
  const PopUpMenuButtonLayout({super.key, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        padding: EdgeInsets.zero,
        offset: const Offset(0, 50),
        onSelected: onSelected,
        elevation: 2,
        shape: TooltipShape(),
        child: SvgPicture.asset(eSvgAssets.option),
        itemBuilder: (context) => [
          PopupMenuItem(
              padding: const EdgeInsets.fromLTRB(
                  Sizes.s20, Sizes.s0, Sizes.s0, Sizes.s0),
              value: 1,
              child: Text(language(context,appFonts.checkSadhana),
                  style: appCss.dmDenseRegular14
                      .textColor(appColor(context)
                      .appTheme
                      .rulesClr))),
          PopupMenuItem(
              height: Sizes.s0,
              padding: EdgeInsets.zero,
              child: SvgPicture.asset(
                  eSvgAssets.lineRuler)),
          PopupMenuItem(
              padding: const EdgeInsets.fromLTRB(
                  Sizes.s20, Sizes.s0, Sizes.s0, Sizes.s0),
              value: 2,
              child: Text(language(context,appFonts.deleteUser),
                  style: appCss.dmDenseRegular14
                      .textColor(appColor(context)
                      .appTheme
                      .rulesClr)))
        ]);
  }
}
