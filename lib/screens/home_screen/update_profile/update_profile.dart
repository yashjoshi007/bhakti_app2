import 'package:bhakti_app/config.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateProfileProvider>(
        builder: (context1, profilePvr, child) {
      return StatefulWrapper(
          onInit: () => Future.delayed(
              DurationsClass.ms150, () => profilePvr.onReady(context)),
          child: Scaffold(
              backgroundColor: appColor(context).appTheme.whiteColor,
              body: CommonBgWidget().commonBgImage(Stack(children: [
                SingleChildScrollView(
                    child: Column(children: [
                  Form(
                      key: profilePvr.formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const VSpace(Insets.i20),
                            CommonAppBar(
                                text: language(context,appFonts.profileEdit),
                                hSpace:
                                    MediaQuery.of(context).size.width * 0.24,
                                onTap: () => Navigator.pop(context)),
                            const ProfileEditUpperLayout(),
                            const ProfileEditBottomLayout(),
                            const VSpace(Insets.i20),
                            CommonButton(
                                width: Sizes.s141,
                                onTap: () => profilePvr.saveData(context),
                                text: language(context,appFonts.save)),
                            const VSpace(Insets.i30)
                          ]).paddingSymmetric(horizontal: Sizes.s20))
                ])),
                if (profilePvr.isLoading)
                  Container(
                      color: appColor(context).appTheme.black26.withOpacity(.4),
                      child: Center(
                          child: Material(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppRadius.r60)),
                              child: Padding(
                                  padding: const EdgeInsets.all(Sizes.s8),
                                  child: SizedBox(
                                      height: Sizes.s20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  appColor(context)
                                                      .appTheme
                                                      .primary),
                                          strokeWidth: 3))))))
              ]))));
    });
  }
}
