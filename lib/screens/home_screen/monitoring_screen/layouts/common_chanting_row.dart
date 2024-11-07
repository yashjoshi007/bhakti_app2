import 'package:bhakti_app/config.dart';

class CommonChantingRow extends StatelessWidget {
  final String? textOne, countOne;

  const CommonChantingRow({super.key, this.textOne, this.countOne});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
      SvgPicture.asset(eSvgAssets.chanting),
      const HSpace(Insets.i8),
      Column(children: [
        Text(countOne!,
            style: appCss.dmDenseBold24
                .textColor(appColor(context).appTheme.primary)),
        Text(textOne!,
            style: appCss.dmDenseMedium11
                .textColor(appColor(context).appTheme.lightText))
      ])
    ]);
  }
}
