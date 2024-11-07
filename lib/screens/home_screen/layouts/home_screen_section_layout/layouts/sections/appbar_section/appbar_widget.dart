import '../../../../../../../config.dart';

class AppbarWidget {
  Widget getProfileImageFallback(
      BuildContext context, HomeScreenProvider homeScreenPvr) {
    String imageUrl;
    if (homeScreenPvr.userAppBarProfilePictureUrl != null &&
        Uri.tryParse(homeScreenPvr.userAppBarProfilePictureUrl!) != null &&
        homeScreenPvr.bhaktiUserName != null) {
      imageUrl = homeScreenPvr.userAppBarProfilePictureUrl!
          .replaceAll('\$name', homeScreenPvr.bhaktiUserName!);
    } else {
      imageUrl = eImageAssets.avatarImg;
    }

    return Container(
        height: Sizes.s32,
        width: Sizes.s32,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                alignment: Alignment.center,
                image: imageUrl.startsWith('assets')
                    ? AssetImage(imageUrl)
                    : NetworkImage(imageUrl) as ImageProvider),
            borderRadius: BorderRadius.circular(AppRadius.r4),
            color: appColor(context).appTheme.whiteColor));
  }
}
