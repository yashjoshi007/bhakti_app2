import 'package:bhakti_app/config.dart';

class SettingParameters extends StatelessWidget {
  const SettingParameters({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(builder: (context, settingPvr, child) {
      return Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          body: CommonBgWidget().commonBgImage(SingleChildScrollView(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            CommonAppBar(
                text: language(context,appFonts.parameters),
                hSpace: Insets.i90,
                onTap: () => Navigator.pop(context)),
            const VSpace(Insets.i10),
            const ParameterTextField(),
            CommonSelectionButton(
                textTwo: language(context,appFonts.save),
                onTapOne: () => Navigator.pop(context),
                onTapTwo: () {
                  settingPvr.updateData(context);
                }).marginSymmetric(vertical: Insets.i10)
          ]).paddingSymmetric(horizontal: Sizes.s20))));
    });
  }
}
