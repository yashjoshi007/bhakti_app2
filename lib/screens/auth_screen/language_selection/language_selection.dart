import 'package:bhakti_app/config.dart';

class LanguageSelection extends StatelessWidget {
  const LanguageSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppLanguageProvider>(
        builder: (context, appLanguagePvr, child) {
      return CommonContainerTile(
          child: DropdownButton<String>(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              isExpanded: true,
              isDense: true,
              style: appCss.dmDenseMedium16
                  .textColor(appColor(context).appTheme.rulesClr),
              value: appLanguagePvr.selectedLanguage,
              items: appLanguagePvr.languages
                  .map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(
                    enabled: true,
                    value: value,
                    child: Text(language(context, value),
                        style: appCss.dmDenseMedium16
                            .textColor(appColor(context).appTheme.rulesClr),
                        overflow: TextOverflow.fade));
              }).toList(),
              icon: SvgPicture.asset(eSvgAssets.arrowDown1),
              underline: Container(),
              hint: Text(language(context, appFonts.selectLanguage),
                  style: appCss.dmDenseMedium16
                      .textColor(appColor(context).appTheme.rulesClr),
                  overflow: TextOverflow.fade),
              onChanged: (value) => appLanguagePvr.onChanged(value!)));
    });
  }
}
