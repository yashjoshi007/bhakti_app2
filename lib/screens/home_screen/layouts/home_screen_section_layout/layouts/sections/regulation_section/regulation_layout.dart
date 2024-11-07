import 'package:bhakti_app/config.dart';

class RegulationLayout extends StatelessWidget {
  const RegulationLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (context, homeScreenPvr, child) {
      return Container(
          padding: const EdgeInsets.all(Sizes.s15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.r8),
              color: appColor(context).appTheme.whiteColor,
              boxShadow: [
                BoxShadow(
                    color: appColor(context).appTheme.shadowClr,
                    blurRadius: AppRadius.r8,
                    offset: const Offset(0, 4),
                    spreadRadius: 0)
              ]),
          child: Column(
              children: appArray.rulesList.asMap().entries.map((e) {
            return Column(children: [
              CommonToggleLayout(
                  index: e.key,
                  list: appArray.rulesList,
                  isRegulation: true,
                  status: e.value['isOn'],
                  text: language(context,e.value['rule']),
                  onToggle: (val) => homeScreenPvr.regulationToggle(val, e, context))
            ]);
          }).toList()));
    });
  }
}
