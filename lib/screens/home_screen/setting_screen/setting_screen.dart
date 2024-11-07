import 'package:bhakti_app/config.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<SettingProvider, AppLanguageProvider>(
        builder: (context, settingPvr, appLanguagePvr, child) {
      return StatefulWrapper(
          onInit: () => Future.delayed(const Duration(milliseconds: 50),
              () => settingPvr.onReady(context)),
          child: Scaffold(
              extendBodyBehindAppBar: true,
              extendBody: true,
              body: CommonBgWidget().commonBgImage(SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    CommonAppBar(
                        text: language(context,appFonts.setting),
                        onTap: () => settingPvr.tabControl(context),
                        hSpace: Insets.i110),
                    const VSpace(Insets.i10),
                    CommonContainerTile(
                        child: Column(
                                children: appArray.settingList
                                    .asMap()
                                    .entries
                                    .map((e) {
                      return SettingLayout(dataInt: e.key, data: e.value);
                    }).toList())
                            .paddingSymmetric(vertical: Insets.i10)),
                    const VSpace(Insets.i20),
                    const LanguageSelection()
                  ]).paddingSymmetric(horizontal: Sizes.s20)))));
    });
  }
}
