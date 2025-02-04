import 'package:bhakti_app/config.dart';

class CommonBgWidget {
  Widget commonBgImage(widget) =>
      Stack(alignment: Alignment.topCenter, children: [
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(eImageAssets.splashBg)))),
        widget!
      ]);
}
