import 'package:bhakti_app/config.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (context, homeScreenPvr, child) {
      return AppBar(
          automaticallyImplyLeading: false,
          leading: SvgPicture.asset(eSvgAssets.menu).inkWell(
              onTap: () =>
                  homeScreenPvr.homeScreenKey.currentState!.openDrawer()),
          leadingWidth: Sizes.s30,
          centerTitle: false,
          elevation: 0,
          backgroundColor: appColor(context).appTheme.trans,
          titleSpacing: 15,
          title: Image.asset(eImageAssets.bhaktiLogo, height: Sizes.s50)
              .marginOnly(top: Sizes.s8)
              .inkWell(onTap: () => {homeScreenPvr.getLinkOfDrawer(context)}),
          actions: [
            const HSpace(Insets.i10),
            SvgPicture.asset(eSvgAssets.calendar, height: Sizes.s32)
                .inkWell(onTap: () => homeScreenPvr.onCalendarChange(context)),
            const HSpace(Insets.i10),
            homeScreenPvr.userModel != null &&
                    homeScreenPvr.userModel!.profilePictureUrl != null
                ? CachedNetworkImage(
                    imageUrl: homeScreenPvr.userModel!.profilePictureUrl!,
                    errorWidget: (context, url, error) => AppbarWidget()
                        .getProfileImageFallback(context, homeScreenPvr),
                    placeholder: (BuildContext context, String url) => Padding(
                        padding: const EdgeInsets.all(Sizes.s8),
                        child: SizedBox(
                            height: Sizes.s20,
                            width: Sizes.s20,
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    appColor(context).appTheme.primary),
                                strokeWidth: Sizes.s3))),
                    imageBuilder: (context, imageProvider) => Container(
                          height: Sizes.s32,
                          width: Sizes.s32,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                  image: imageProvider),
                              borderRadius: BorderRadius.circular(AppRadius.r4),
                              color: appColor(context).appTheme.whiteColor),
                        )).inkWell(
                    onTap: () => homeScreenPvr.cacheNetworkImage(context))
                : Padding(
                        padding: const EdgeInsets.all(Sizes.s8),
                        child: SizedBox(
                            height: Sizes.s20,
                            width: Sizes.s20,
                            child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(appColor(context).appTheme.primary),
                                strokeWidth: Sizes.s3)))
                    .inkWell(onTap: () => homeScreenPvr.defaultProfileImage(context))
          ]);
    });
  }
}
