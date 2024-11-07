import 'package:bhakti_app/config.dart';

class CommonContainer extends StatelessWidget {
  final String? text, timeText, svgImage;
  final bool isSwitch = false;

  final GestureTapCallback? onTap;

  const CommonContainer({
    super.key,
    this.text,
    this.timeText,
    this.svgImage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      color: appColor(context).appTheme.shadowClr,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                      spreadRadius: 0)
                ],
                color: appColor(context).appTheme.whiteColor),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(svgImage!),
                        Text(
                            timeText == ""
                                ? language(context, appFonts.tapToEnter)
                                : timeText!,
                            style: appCss.dmDenseMedium16.textColor(
                                timeText == ""
                                    ? appColor(context).appTheme.emptyTxtClr
                                    : appColor(context).appTheme.primary),
                            overflow: TextOverflow.fade)
                      ]),
                  const VSpace(Insets.i4),
                  Text(text!,
                      style: appCss.dmDenseMedium14
                          .textColor(appColor(context).appTheme.lightText))
                ]).paddingAll(Insets.i10))
        .inkWell(onTap: onTap);
  }
}
