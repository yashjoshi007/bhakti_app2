import 'package:bhakti_app/config.dart';

class SingleUserLayout extends StatelessWidget {
  final String? text, text1, svgImage, svgImage1;
  final bool? isTitle, isAllSvg;

  const SingleUserLayout(
      {super.key,
      this.text,
      this.text1,
      this.isTitle = false,
      this.svgImage,
      this.isAllSvg = false,
      this.svgImage1});

  @override
  Widget build(BuildContext context) {
    Color textColor = isTitle == true
        ? appColor(context).appTheme.rulesClr
        : (text1 == "0" || text1 == "00:00")
            ? appColor(context).appTheme.emptyClr
            : appColor(context).appTheme.primary;

    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          isTitle == true
              ? const SizedBox(width: 30)
              : const SizedBox(width: 0),
          SizedBox(
              child: Text(text!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: appCss.dmDenseMedium16
                      .textColor(appColor(context).appTheme.rulesClr)))
        ]),
        Row(children: [
          isTitle == true
              ? SvgPicture.asset(svgImage!)
              : isAllSvg == true
                  ? SvgPicture.asset(svgImage1!)
                  : Text(text1!,
                      style: appCss.dmDenseBold20.textColor(textColor)),
          const SizedBox(width: 10)
        ])
      ]).backgroundColor(appColor(context).appTheme.whiteColor)
    ]);
  }
}
