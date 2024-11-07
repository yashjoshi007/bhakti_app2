import 'package:bhakti_app/config.dart';

class UpdateProfilePicture extends StatelessWidget {
  const UpdateProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateProfileProvider>(
        builder: (context, updateProfilePvr, child) {
      return Stack(children: [
        if (updateProfilePvr.imagePath.isNotEmpty)
          CircleAvatar(
              maxRadius: Sizes.s55,
              backgroundImage: FileImage(File(updateProfilePvr.imagePath)))
        else if (updateProfilePvr.downloadUrl.isNotEmpty)
          CircleAvatar(
              maxRadius: Sizes.s55,
              backgroundImage: NetworkImage(updateProfilePvr.downloadUrl))
        else if (updateProfilePvr.userProfilePictureUrl != null &&
            Uri.tryParse(updateProfilePvr.userProfilePictureUrl!) != null)
          CircleAvatar(
              maxRadius: Sizes.s55,
              backgroundImage: NetworkImage(updateProfilePvr
                  .userProfilePictureUrl!
                  .replaceAll('\$name', updateProfilePvr.name.text)))
        else
          const CircleAvatar(
              maxRadius: Sizes.s55,
              backgroundImage: AssetImage('assets/images/anonymous.png')),
        if ((updateProfilePvr.imagePath.isEmpty &&
            updateProfilePvr.downloadUrl.isEmpty &&
            (updateProfilePvr.userProfilePictureUrl == null ||
                Uri.tryParse(updateProfilePvr.userProfilePictureUrl!) == null)))
          CircleAvatar(
              maxRadius: Sizes.s55,
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      appColor(context).appTheme.primary),
                  strokeWidth: Sizes.s3)),
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
                    onTap: () => updateProfilePvr.profilePicUpdate(context),
                    child: SvgPicture.asset(eSvgAssets.camera,
                        height: Sizes.s30))))
      ]).paddingSymmetric(vertical: Sizes.s30);
    });
  }
}
