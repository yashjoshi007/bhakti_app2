import 'package:bhakti_app/config.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeScreenProvider, UpdateProfileProvider>(
        builder: (context, homeScreenPvr, profileProvider, child) {
      return StatefulWrapper(
          onInit: () => Future.delayed(const Duration(seconds: 1),
              () => profileProvider.onReady(context)),
          child: Scaffold(
              extendBodyBehindAppBar: true,
              extendBody: true,
              body: CommonBgWidget().commonBgImage(SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    AppBar(
                        leading: Container(),
                        backgroundColor: appColor(context).appTheme.trans,
                        titleSpacing: 0,
                        leadingWidth: 0,
                        title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(eSvgAssets.arrowLeft)
                                  .inkWell(onTap: () => Navigator.pop(context)),
                              const HSpace(Insets.i90),
                              Text(language(context, appFonts.contactUs),
                                  style: appCss.philosopherBold28.textColor(
                                      appColor(context).appTheme.oneText))
                            ])),
                    const VSpace(Sizes.s10),
                    const UpdateEmailTextBox(),
                    const VSpace(Sizes.s20),
                    CustomTitleWidget(
                        height: Sizes.s400,
                        width: double.infinity,
                        title: language(context, appFonts.message),
                        color:
                            appColor(context).appTheme.primary.withOpacity(.20),
                        radius: AppRadius.r8,
                        child: TextFieldCommon(
                            keyboardType: TextInputType.multiline,
                            hintText:
                                language(context, appFonts.enterYourMessage),
                            maxLines: 14,
                            controller: profileProvider.message)),
                    const VSpace(Sizes.s20),
                    CommonButton(bColor: profileProvider.isButtonDisabled ? appColor(context).appTheme.primary.withOpacity(0.5) : appColor(context).appTheme.primary,
                        onTap: profileProvider.isButtonDisabled
                            ? null
                            : () {
                                profileProvider.onSubmit(context);
                              },
                        text: language(context, appFonts.submit))
                  ]).paddingAll(Sizes.s20)))));
    });
  }
}
