import 'package:bhakti_app/config.dart';

class MonitoringGroupUpperLayout extends StatelessWidget {
  const MonitoringGroupUpperLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<MonitoringProvider, SettingProvider>(
        builder: (context, monitoringPvr, settingPvr, child) {
      return Column(children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
                  width: Sizes.s40,
                  height: Sizes.s40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: monitoringPvr.isAllSelected == true
                          ? appColor(context).appTheme.primary
                          : appColor(context).appTheme.whiteColor),
                  alignment: Alignment.center,
                  child: Text(language(context, appFonts.all),
                      style: appCss.dmDenseMedium12.textColor(
                          monitoringPvr.isAllSelected == true
                              ? appColor(context).appTheme.whiteColor
                              : appColor(context).appTheme.primary)))
              .marginOnly(
                  right: Sizes.s5,
                  left: Sizes.s5,
                  top: monitoringPvr.isAllSelected ? Sizes.s10 : Sizes.s15)
              .inkWell(onTap: () {
            monitoringPvr.isAllSelected = true;
            monitoringPvr.getGroupData(context);
            monitoringPvr.notifyListeners();
          }).marginOnly(left: Insets.i10),
          Expanded(
              child: MonitoringUserListView(
                  shareWithMeList: settingPvr.shareWithMeList))
        ]),
        const VSpace(Insets.i10),
        monitoringPvr.isAllSelected == true
            ? const MonitoringGroupUserLayout()
            : const MonitoringSingleUserLayout()
      ]);
    });
  }
}
