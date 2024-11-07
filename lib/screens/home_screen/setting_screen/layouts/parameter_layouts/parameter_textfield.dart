import 'package:bhakti_app/config.dart';

class ParameterTextField extends StatelessWidget {
  const ParameterTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(builder: (context, settingPvr, child) {
      return Column(children: [
        CustomTextFieldWidget(
            hintText: language(context,appFonts.zeroZero),
            title: language(context,appFonts.numberOfRoundsChanting),
            controller: settingPvr.numberOfRound,
            icon: eSvgAssets.calculator,
            keyboardType: TextInputType.number),
        CustomTextFieldWidget(
            maxLength: 5,
            onChanged: (value) {
              if (value.length == 2 && !value.contains(':')) {
                settingPvr.averageTime.text = '$value:';
                settingPvr.averageTime.selection = TextSelection.fromPosition(
                    TextPosition(offset: settingPvr.averageTime.text.length));
              }
            },
            hintText: language(context,appFonts.hhMm),
            title: language(context,appFonts.averageTimeForEachRound),
            controller: settingPvr.averageTime,
            icon: eSvgAssets.clock,
            keyboardType: TextInputType.datetime)
      ]);
    });
  }
}
