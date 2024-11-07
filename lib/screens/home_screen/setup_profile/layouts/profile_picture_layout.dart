import 'package:bhakti_app/config.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SetUpProfileProvider>(
        builder: (context, profilePvr, child) {
      return Stack(children: [
        profilePvr.imagePath != ""
            ? CircleAvatar(
                backgroundImage: FileImage(File(profilePvr.imagePath)),
                maxRadius: Sizes.s55)
            : profilePvr.downloadUrl != ""
                ? CircleAvatar(
                    backgroundImage: NetworkImage(profilePvr.downloadUrl),
                    maxRadius: Sizes.s55)
                : CircleAvatar(
                    maxRadius: Sizes.s55,
                    child: Image.asset(eImageAssets.avatarImg1)),
        Positioned(
            right: Sizes.s6,
            top: Sizes.s80,
            child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: appColor(context).appTheme.whiteColor,
                        width: Insets.i1),
                    borderRadius: BorderRadius.circular(AppRadius.r20),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          appColor(context).appTheme.profileClr,
                          appColor(context).appTheme.profileClr1
                        ])),
                child: InkWell(
                    onTap: () => profilePvr.profilePicture(context),
                    child: SvgPicture.asset(eSvgAssets.camera,
                        height: Sizes.s30))))
      ]).paddingSymmetric(vertical: Sizes.s30);
    });
  }
}
