import 'package:bhakti_app/config.dart';

class SettingListLayouts extends StatelessWidget {
  final String? svgImage;
  final String? image;
  final String? text;
  final int? index;
  final List? list;
  final GestureTapCallback? onTap;
  final bool? isShare;
  final Widget? widget, child;

  const SettingListLayouts(
      {super.key,
      this.text,
      this.svgImage,
      this.index,
      this.list,
      this.onTap,
      this.image,
      this.widget,
      this.child,
      this.isShare = false});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(children: [
      const HSpace(Insets.i10),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
            child: Row(children: [
          isShare == false
              ? SvgPicture.asset(svgImage!)
              : Container(
                  height: Sizes.s35,
                  width: Sizes.s35,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: NetworkImage(image!)))),
          const HSpace(Insets.i10),
          Expanded(
              child: Text(text!,
                  overflow: TextOverflow.ellipsis,
                  style: appCss.dmDenseMedium16
                      .textColor(appColor(context).appTheme.rulesClr)))
        ])),
        widget!
      ]).inkWell(onTap: onTap),
      if (index != list!.length - 1)
        SvgPicture.asset(eSvgAssets.lineRuler).paddingSymmetric(
            vertical: isShare == true ? Insets.i10 : Insets.i15)
    ]);
  }
}
