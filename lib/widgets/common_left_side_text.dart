import '../config.dart';

class CommonLeftSideText extends StatelessWidget {
  final String? text, rightText;
  final bool? isRightText;
  final GestureTapCallback? onTap;

  const CommonLeftSideText(
      {super.key,
      this.text,
      this.isRightText = false,
      this.onTap,
      this.rightText});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(text!,
          style: appCss.philosopherBold18
              .textColor(appColor(context).appTheme.rulesClr)),
      if (isRightText == true)
        Row(children: [
          SvgPicture.asset(eSvgAssets.add),
          Text(rightText!,
              style: appCss.dmDenseMedium14
                  .textColor(appColor(context).appTheme.primary))
        ]).inkWell(onTap: onTap)
    ]);
  }
}
