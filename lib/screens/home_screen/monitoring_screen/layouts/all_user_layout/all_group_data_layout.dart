import 'package:bhakti_app/config.dart';

class AllGroupDataLayouts extends StatelessWidget {
  const AllGroupDataLayouts({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<MonitoringProvider, SettingProvider>(
        builder: (context, monitoringPvr, settingPvr, child) {
      return Stack(children: [
        SingleChildScrollView(
            controller: monitoringPvr.scrollController,
            scrollDirection: Axis.horizontal,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.r4),
                child: DataTable(
                    columnSpacing: MediaQuery.of(context).size.width * 0.1,
                    dataRowMinHeight: Sizes.s0,
                    dataRowMaxHeight: Sizes.s51,
                    headingTextStyle: appCss.dmDenseSemiBold16
                        .textColor(appColor(context).appTheme.primary),
                    dataTextStyle: appCss.dmDenseMedium14
                        .textColor(appColor(context).appTheme.lightText),
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => appColor(context).appTheme.containColor),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppRadius.r10)),
                    columns: monitoringPvr.allDataColumn(context),
                    rows: List<DataRow>.generate(
                        monitoringPvr
                            .allDataRow(context, settingPvr.shareWithMeList)
                            .length, (rowIndex) {
                      Color rowColor = rowIndex % 2 == 0
                          ? appColor(context).appTheme.whiteColor
                          : appColor(context).appTheme.containerClr1;
                      var rowData = monitoringPvr.allDataRow(
                          context, settingPvr.shareWithMeList)[rowIndex];
                      return DataRow(
                          color: MaterialStateColor.resolveWith(
                              (states) => rowColor),
                          cells: rowData.cells);
                    })))),
        ...monitoringPvr.allDataList.asMap().entries.map((e) {
          dynamic settingPvr =
              Provider.of<SettingProvider>(context, listen: false);
          int isSameUID = settingPvr.shareWithMeList.indexWhere((element) {
            return element['uid'] == e.value['uid'];
          });
          if (isSameUID != -1) {
            return Positioned(
                top: 62 + e.key * 50,
                child: Container(
                    padding: const EdgeInsets.only(right: 30, left: 10),
                    color: e.key % 2 == 0
                        ? appColor(context).appTheme.whiteColor
                        : appColor(context).appTheme.containerClr1,
                    child: Column(children: [
                      Container(
                              width: Sizes.s40,
                              height: Sizes.s40,
                              decoration: BoxDecoration(
                                  color: appColor(context).appTheme.whiteColor,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: CachedNetworkImageProvider(settingPvr.shareWithMeList[isSameUID]
                                                      ['display_picture'] !=
                                                  "" &&
                                              settingPvr.shareWithMeList[isSameUID]
                                                      ['display_picture'] !=
                                                  null &&
                                              settingPvr.shareWithMeList[isSameUID]
                                                      ['display_picture'] !=
                                                  "https://firebase_file_upload_url"
                                          ? settingPvr.shareWithMeList.toList()[isSameUID]
                                              ['display_picture']
                                          : monitoringPvr
                                                  .profilePictureUrl!.isNotEmpty
                                              ? monitoringPvr.profilePictureUrl!
                                                  .replaceAll(
                                                      '\$name',
                                                      settingPvr.shareWithMeList.toList()[isSameUID]
                                                          ['display_name'])
                                              : ""))))
                          .inkWell(onTap: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return CommonMonitoringDialog(
                                  data: settingPvr.shareWithMeList
                                      .toList()[isSameUID]);
                            });
                      })
                    ])));
          } else {
            return Container();
          }
        })
      ]);
    });
  }
}
