import 'package:bhakti_app/config.dart';

class CommonMonitoringDialog extends StatelessWidget {
  final dynamic data;

  const CommonMonitoringDialog({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer<MonitoringProvider>(
        builder: (context, monitoringPvr, child) {
      return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.r35),
                  color: appColor(context).appTheme.whiteColor),
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Column(mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        width: Sizes.s150,
                        height: Sizes.s150,
                        decoration: data['display_picture'] != "" &&
                                data['display_picture'] != null &&
                                data['display_picture'] !=
                                    "https://firebase_file_upload_url"
                            ? BoxDecoration(
                                shape: BoxShape.circle,
                                color: appColor(context).appTheme.whiteColor,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image:
                                        NetworkImage(data['display_picture'])))
                            : BoxDecoration(
                                color: appColor(context).appTheme.whiteColor,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(monitoringPvr
                                        .profilePictureUrl!
                                        .replaceAll(
                                            '\$name', data['display_name']))))),
                    RichText(
                        text: TextSpan(
                            style: appCss.philosopherSemiBold18
                                .textColor(appColor(context).appTheme.oneText),
                            children: [
                          TextSpan(text:language(context, appFonts.nameShow)),
                          TextSpan(
                              text: data['display_name'],
                              style: appCss.philosopherSemiBold18.textColor(
                                  appColor(context).appTheme.primary))
                        ])).alignment(Alignment.topLeft),
                    RichText(
                        text: TextSpan(
                            style: appCss.philosopherSemiBold18
                                .textColor(appColor(context).appTheme.oneText),
                            children: [
                          TextSpan(text: language(context, appFonts.emailShow)),
                          TextSpan(
                              text: data['masked_identity'],
                              style: appCss.philosopherSemiBold18.textColor(
                                  appColor(context).appTheme.primary))
                        ])).alignment(Alignment.topLeft),
                    const VSpace(Insets.i15),
                    CommonButton(
                        borderColor: appColor(context).appTheme.primary,
                        style: appCss.dmDenseMedium16
                            .textColor(appColor(context).appTheme.whiteBg),
                        width: Sizes.s120,
                        text: appFonts.ok,
                        isColor: false,
                        bColor: appColor(context).appTheme.primary,
                        onTap: () {
                          Navigator.pop(context);
                        })
                  ])));
    });
  }
}

