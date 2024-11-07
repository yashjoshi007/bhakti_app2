import 'package:bhakti_app/config.dart';

class SettingLayout extends StatelessWidget {
  final int? dataInt;
  final Map<String, dynamic>? data;

  const SettingLayout({super.key, this.dataInt, this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(builder: (context, settingPvr, child) {
      return Column(children: [
        SettingListLayouts(
            isShare: false,
            onTap: () => settingPvr.onTap(dataInt, context, data),
            index: dataInt,
            widget: SvgPicture.asset(eSvgAssets.arrowLeftToRight),
            list: appArray.settingList,
            svgImage: data!['image'],
            text: language(context,data!['rule']))
      ]);
    });
  }
}
