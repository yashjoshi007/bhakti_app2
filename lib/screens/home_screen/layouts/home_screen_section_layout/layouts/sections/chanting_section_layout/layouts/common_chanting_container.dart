import 'package:bhakti_app/config.dart';

class CommonChantingContainer extends StatelessWidget {
  final String? chantingText, text;
  final GestureTapCallback? onTap;
  final TextStyle? style;

  const CommonChantingContainer(
      {super.key, this.chantingText, this.text, this.onTap, this.style});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 10),
        margin: const EdgeInsets.fromLTRB(0, 0, 10, 10),
        decoration: BoxDecoration(
            color: appColor(context).appTheme.whiteColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: appColor(context).appTheme.shadowClr,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                  spreadRadius: 1)
            ]),
        width: Sizes.s106,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset(eSvgAssets.chanting),
                    Text(chantingText!, style: style!)
                  ]),
              Text(text!,
                      style: appCss.dmDenseMedium11
                          .textColor(appColor(context).appTheme.lightText))
                  .paddingOnly(left: 10)
            ])).inkWell(onTap: onTap);
  }
}
