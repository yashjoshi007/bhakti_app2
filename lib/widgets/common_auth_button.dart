import 'package:bhakti_app/config.dart';

class CommonButton extends StatelessWidget {
  final String? text;
  final GestureTapCallback? onTap;
  final bool? isColor;
  final double? width;
  final double? radius;
  final Color? borderColor;
  final Color? bColor;
  final TextStyle? style;

  const CommonButton(
      {super.key,
      this.text,
      this.onTap,
      this.width,
      this.isColor = false,
      this.radius,
      this.borderColor, this.bColor, this.style});

  @override
  Widget build(BuildContext context) {
    return Container(
            alignment: Alignment.center,
            height: Sizes.s44,
            width: width ?? MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: bColor ?? appColor(context).appTheme.primary,
                borderRadius: BorderRadius.circular(radius ?? AppRadius.r10),
                border: Border.all(
                    color: borderColor ?? appColor(context).appTheme.trans)),
            child: Text(text!,
                style: style ?? appCss.dmDenseMedium16
                        .textColor(appColor(context).appTheme.whiteColor)))
        .inkWell(onTap: onTap);
  }
}
