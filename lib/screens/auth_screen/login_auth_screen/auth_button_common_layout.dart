import 'package:bhakti_app/config.dart';

class AuthButtonLayout extends StatelessWidget {
  final String label;
  final Color color;
  final String iconPath;
  final Function() onTap;

  const AuthButtonLayout(
      {super.key,
      required this.label,
      required this.color,
      required this.iconPath,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    double containerWidth = calculateContainerWidth(context);

    return Container(
        width: containerWidth,
        height: Sizes.s50,
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
              color: Color(0x1E000000),
              blurRadius: AppRadius.r4,
              offset: Offset(0, 2),
              spreadRadius: 0)
        ], color: color, borderRadius: BorderRadius.circular(Insets.i50)),
        child: Row(children: [
          const HSpace(Insets.i20),
          SvgPicture.asset(iconPath),
          const HSpace(Insets.i12),
          Flexible(
              fit: FlexFit.loose,
              child: Text(language(context, label),
                  overflow: TextOverflow.ellipsis,
                  style: language(context, label) ==
                          language(context, appFonts.loginViaGoogle)
                      ? appCss.dmDenseBold16
                          .textColor(appColor(context).appTheme.googleTxtClr)
                      : appCss.dmDenseBold16
                          .textColor(appColor(context).appTheme.whiteColor)))
        ])).inkWell(onTap: onTap);
  }

  // Function to calculate the width of the container
  double calculateContainerWidth(BuildContext context) {
    // Estimate the text length using a TextPainter
    TextPainter painter = TextPainter(
        text: TextSpan(
            text: language(context, label), style: appCss.dmDenseBold16),
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: double.infinity);
    // Add extra space for icon, padding, and shadow
    double totalWidth = painter.width +
        Insets.i20 +
        Insets.i12 +
        Sizes.s50 +
        Insets.i20 +
        AppRadius.r4 * 2;

    // Limit maximum width to avoid excessively wide buttons
    double maxWidth = MediaQuery.of(context).size.width * 0.6;
    return totalWidth > maxWidth ? maxWidth : totalWidth;
  }
}
