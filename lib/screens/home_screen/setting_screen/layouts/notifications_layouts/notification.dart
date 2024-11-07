import 'dart:developer';

import 'package:bhakti_app/config.dart';

class NotificationLayouts extends StatelessWidget {
  const NotificationLayouts({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(builder: (context, settingPvr, child) {
      return Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: AppBar(
              leading: Container(),
              backgroundColor: appColor(context).appTheme.trans,
              titleSpacing: 0,
              leadingWidth: 0,
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const HSpace(Insets.i20),
                    SvgPicture.asset(eSvgAssets.arrowLeft)
                        .inkWell(onTap: () => Navigator.pop(context)),
                    const HSpace(Insets.i90),
                    Text(language(context,appFonts.notification),
                        style: appCss.philosopherBold28
                            .textColor(appColor(context).appTheme.oneText))
                  ])),
          body: CommonBgWidget().commonBgImage( SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                const VSpace(Insets.i120),
                Row(children: [
                  Text(language(context,appFonts.notificationSetting),
                      style: appCss.dmDenseExtraBold18
                          .textColor(appColor(context).appTheme.rulesClr))
                ]),
                const VSpace(Insets.i15),
                Container(
                    padding: const EdgeInsets.all(Sizes.s15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppRadius.r8),
                        color: appColor(context).appTheme.whiteColor,
                        boxShadow: [
                          BoxShadow(
                              color: appColor(context).appTheme.shadowClr,
                              blurRadius: AppRadius.r8,
                              offset: const Offset(0, 4))
                        ]),
                    child: Column(
                        children: appArray.notificationSettingList
                            .asMap()
                            .entries
                            .map((e) {
                      return Column(children: [
                        CommonToggleLayout(
                            list: appArray.notificationSettingList,
                            index: e.key,
                            status: e.value['isOn'],
                            text: language(context,e.value['name']),
                            onToggle: (val) =>
                                settingPvr.onNotificationToggle(
                                    val, e.value, context))
                      ]);
                    }).toList()))
              ]).paddingSymmetric(horizontal: Sizes.s20))));
    });
  }
}
