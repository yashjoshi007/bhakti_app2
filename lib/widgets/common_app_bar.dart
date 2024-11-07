import 'package:bhakti_app/config.dart';

class CommonAppBar extends StatelessWidget {
  final String? text;
  final double? hSpace;
  final GestureTapCallback? onTap;
  final bool? isWidth;

  const CommonAppBar(
      {super.key, this.text, this.hSpace, this.onTap, this.isWidth = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: Container(),
        backgroundColor: appColor(context).appTheme.trans,
        titleSpacing: 0,
        leadingWidth: Sizes.s0,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SvgPicture.asset(eSvgAssets.arrowLeft).inkWell(onTap: onTap),
          Container(
              alignment: Alignment.center,
              width: 260,
              child: Text(text!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: appCss.philosopherBold28
                      .textColor(appColor(context).appTheme.oneText))),
          HSpace(MediaQuery.of(context).size.width * 0.07)
        ]));
  }

  Widget sizedBox(screenWidth, context) {
    return Center(
        child: SizedBox(
            width: screenWidth,
            child: Text(text!,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: appCss.philosopherBold28
                    .textColor(appColor(context).appTheme.oneText))));
  }
}
