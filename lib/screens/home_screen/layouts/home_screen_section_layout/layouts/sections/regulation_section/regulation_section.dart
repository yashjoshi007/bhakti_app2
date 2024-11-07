import 'package:bhakti_app/config.dart';

class RegulationSection extends StatelessWidget {
  const RegulationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (context, homeScreenPvr, child) {
      return Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(language(context, appFonts.regulations),
              style: appCss.philosopherBold18
                  .textColor(appColor(context).appTheme.rulesClr)),
          Container(
                  padding: const EdgeInsets.all(Sizes.s6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.r8),
                      boxShadow: [
                        BoxShadow(
                            color: appColor(context).appTheme.shadowClr,
                            blurRadius: AppRadius.r16,
                            offset: const Offset(0, 4),
                            spreadRadius: 0)
                      ],
                      color: appColor(context).appTheme.primary),
                  width: Sizes.s26,
                  height: Sizes.s27,
                  child: SvgPicture.asset(eSvgAssets.questionMark))
              .inkWell(onTap: () async {
            FocusManager.instance.primaryFocus?.unfocus();
            homeScreenPvr.notifyListeners();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegulationsWebView()));
          })
        ]),
        const VSpace(Insets.i10),
        const RegulationLayout()
      ]);
    });
  }
}
