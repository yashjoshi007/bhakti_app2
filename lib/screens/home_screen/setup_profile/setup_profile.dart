import 'package:bhakti_app/config.dart';

class SetUpProfile extends StatefulWidget {
  const SetUpProfile({super.key});

  @override
  State<SetUpProfile> createState() => _SetUpProfileState();
}

class _SetUpProfileState extends State<SetUpProfile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SetUpProfileProvider>(
        builder: (context1, setUpProfilePvr, child) {
      return LoadingComponent(
          child: StatefulWrapper(
              onInit: () => Future.delayed(
                  DurationsClass.ms150, () => setUpProfilePvr.onReady(context)),
              child: Scaffold(
                  key: setUpProfilePvr.setupScaffoldKey,
                  extendBodyBehindAppBar: true,
                  body: CommonBgWidget().commonBgImage(SingleChildScrollView(
                          child: Form(
                              key: setUpProfilePvr.setupFormKey,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const VSpace(Sizes.s15),
                                    Text(language(context,appFonts.setUp),
                                        style: appCss.philosopherBold28,overflow: TextOverflow.ellipsis),
                                    const VSpace(Sizes.s10),
                                    Text(language(context,appFonts.enterYourDetails),
                                        style: appCss.dmDenseRegular14
                                            .textColor(appColor(context)
                                                .appTheme
                                                .lightText)),
                                    const VSpace(Insets.i20),
                                    const ProfilePicture().center(),
                                    const PersonalInfoExpansionTile(),
                                    const ContactInfoExpansionTile(),
                                    const VSpace(Insets.i18),
                                    Center(
                                        child: CommonButton(
                                            width: Sizes.s141,
                                            onTap: () => setUpProfilePvr
                                                .saveData(context) ,
                                            text: language(context,appFonts.save)))
                                  ]).marginSymmetric(
                                  horizontal: Sizes.s20, vertical: Sizes.s60)))))));
    });
  }
}
