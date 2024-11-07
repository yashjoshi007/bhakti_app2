import 'package:bhakti_app/config.dart';

class DashboardWidget {
  CalendarStyle calendarStyle(context) => CalendarStyle(
      isTodayHighlighted: true,
      todayDecoration: BoxDecoration(
          color: appColor(context).appTheme.primary.withOpacity(0.6),
          borderRadius: BorderRadius.circular(6)),
      rangeHighlightColor: appColor(context).appTheme.primary.withOpacity(0.10),
      rangeEndDecoration: BoxDecoration(
          color: appColor(context).appTheme.primary,
          borderRadius: BorderRadius.circular(6)),
      rangeStartDecoration: BoxDecoration(
          color: appColor(context).appTheme.primary,
          borderRadius: BorderRadius.circular(6)),
      selectedDecoration: BoxDecoration(
          color: appColor(context).appTheme.red,
          borderRadius: BorderRadius.circular(1)));

  Widget userSelectionLayout(isSelected, index) =>
      Consumer<DashboardProvider>(builder: (context, dashboardPvr, child) {
        return Column(children: [
          Opacity(
              opacity: isSelected! ? 1 : 0.8,
              child: Image.asset(eImageAssets.userSection,
                  height: isSelected! ? Sizes.s50 : Sizes.s43,
                  width: isSelected! ? Sizes.s50 : Sizes.s43))
        ]).marginOnly(right: Sizes.s15).inkWell(
            onTap: () =>
                dashboardPvr.onUserSelection(isSelected, index, context));
      });

  Widget chevronIconCommon(context, svgImage) => Container(
      padding: const EdgeInsets.all(Sizes.s6),
      height: Sizes.s26,
      width: Sizes.s26,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.r6),
          color: appColor(context).appTheme.primary.withOpacity(0.10)),
      child: SvgPicture.asset(svgImage));

// full screen common widget

  Widget buildDashboardBody(BuildContext context) {
    final dashboardPvr = Provider.of<DashboardProvider>(context, listen: false);
    return CommonBgWidget().commonBgImage(SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      CommonAppBar(
          text: language(context, appFonts.dashboard),
          hSpace: Insets.i90,
          onTap: () => dashboardPvr.tabControl(context)),
      const VSpace(Insets.i10),
      const TableCalendarLayout(),
      const VSpace(Insets.i10),
      CommonLeftSideText(text: language(context, appFonts.userSection)),
      const VSpace(Insets.i10),
      buildUserListView(context),
      const VSpace(Insets.i10),
      buildChartContainer(
          context,
          language(context, appFonts.sleepPatternChart),
          const SleepPatternChart()),
      const VSpace(Insets.i10),
      buildChartContainer(context, language(context, appFonts.chantingChart),
          const ChantingChart()),
      const VSpace(Insets.i10),
      buildChartContainer(context, language(context, appFonts.associationChart),
          const AssociationChart())
    ]).paddingSymmetric(horizontal: Insets.i20)));
  }

  Widget buildUserListView(BuildContext context) {
    final dashboardPvr = Provider.of<DashboardProvider>(context, listen: false);
    final settingPvr = Provider.of<SettingProvider>(context, listen: false);
    return SizedBox(
        height: dashboardPvr.isSingleUserSelected ? Sizes.s60 : Sizes.s80,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: settingPvr.shareWithMeList.length,
            itemBuilder: (context, index) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildUserAvatar(context, index),
                    if (!dashboardPvr.isSingleUserSelected &&
                        dashboardPvr.selectedIndex == index)
                      buildUserText(
                          settingPvr.shareWithMeList[index]['display_name'])
                  ]);
            }));
  }

  Widget buildUserAvatar(BuildContext context, int index) {
    final dashboardPvr = Provider.of<DashboardProvider>(context, listen: false);
    final settingPvr = Provider.of<SettingProvider>(context, listen: false);
    final displayName =
        settingPvr.shareWithMeList[index]['display_name'].split(' ')[0];
    dashboardPvr.displayUid = settingPvr.shareWithMeList[index]['uid'];
    final displayPicture = settingPvr.shareWithMeList[index]['display_picture'];
    final imageUrl = (displayPicture != "" &&
            displayPicture != "https://firebase_file_upload_url" &&
            displayPicture != null)
        ? displayPicture
        : (dashboardPvr.profilePictureUrl != null
            ? dashboardPvr.profilePictureUrl!.replaceAll(
                '\$name', settingPvr.shareWithMeList[index]['display_name'])
            : dashboardPvr.profilePictureUrl ?? "");

    return Container(
            width: dashboardPvr.isSingleUserSelected
                ? Sizes.s40
                : (dashboardPvr.selectedIndex == index ? Sizes.s50 : Sizes.s40),
            height: dashboardPvr.isSingleUserSelected
                ? Sizes.s40
                : (dashboardPvr.selectedIndex == index ? Sizes.s50 : Sizes.s40),
            decoration: BoxDecoration(
                color: appColor(context).appTheme.whiteColor,
                shape: BoxShape.circle),
            child: ClipOval(
                child: CachedNetworkImage(
                    placeholder: (context, url) =>
                        Image.network(imageUrl, fit: BoxFit.fill,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                    errorWidget: (context, url, error) =>
                        const CircularProgressIndicator(),
                    imageUrl: imageUrl,
                    fit: BoxFit.fill)))
        .marginOnly(
            left: Sizes.s5,
            right: Sizes.s5,
            top: dashboardPvr.isSingleUserSelected
                ? Sizes.s10
                : (dashboardPvr.selectedIndex == index ? Sizes.s10 : Sizes.s15))
        .inkWell(
            onTap: () => dashboardPvr.onUserSelection(false, index, context));
  }

  Widget buildUserText(displayName) {
    return Container(
        alignment: Alignment.center,
        width: Sizes.s60,
        height: Sizes.s16,
        child: Text(displayName, style: appCss.dmDenseBlack12));
  }

  Widget buildChartContainer(
      BuildContext context, String title, Widget chartWidget) {
    return CommonContainerDesign(text: title, child: chartWidget);
  }
}
