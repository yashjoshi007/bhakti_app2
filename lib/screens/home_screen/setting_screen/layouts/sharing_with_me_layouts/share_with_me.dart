import 'package:bhakti_app/config.dart';

class SharingWithMe extends StatelessWidget {
  const SharingWithMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(builder: (context, settingPvr, child) {
      return StatefulWrapper(
          onInit: () => Future.delayed(const Duration(milliseconds: 50),
              () => settingPvr.getShareWithMeData(context)),
          child: Scaffold(
              extendBodyBehindAppBar: true,
              extendBody: true,
              body: CommonBgWidget().commonBgImage(SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    CommonAppBar(
                        onTap: () => Navigator.pop(context),
                        hSpace: Insets.i70,
                        text: language(context, appFonts.sharingWithMe)),
                    CommonLeftSideText(
                        text: language(context, appFonts.userList)),
                    const VSpace(Insets.i10),
                    CommonTextField(
                        onChanged: (query) =>
                            settingPvr.filterShareWithMeList(query),
                        prefixIcon: Row(children: [
                          SvgPicture.asset(eSvgAssets.searchNormal)
                              .paddingOnly(right: Sizes.s10, left: Sizes.s10),
                          SvgPicture.asset(eSvgAssets.line)
                              .paddingOnly(right: Sizes.s10)
                        ]),
                        height: Sizes.s50,
                        controller: settingPvr.searchSharingWithMe,
                        hintText: language(context, appFonts.searchHere)),
                    const VSpace(Insets.i10),
                    Container(
                        padding: const EdgeInsets.all(Sizes.s15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: appColor(context).appTheme.whiteColor,
                            boxShadow: [
                              BoxShadow(
                                  color: appColor(context).appTheme.shadowClr,
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                  spreadRadius: 0)
                            ]),
                        child: settingPvr.shareWithMeList.isNotEmpty
                            ? RefreshIndicator(
                                onRefresh: () async {
                                  await settingPvr.getShareWithMeData(context);
                                },
                                child: SingleChildScrollView(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    child: settingPvr.isSearchShareWithMe
                                        ? (settingPvr.shareWithMeList.isNotEmpty
                                            ? Column(
                                                children: settingPvr
                                                    .shareWithMeList
                                                    .asMap()
                                                    .entries
                                                    .map((e) {
                                                return Column(children: [
                                                  SettingListLayouts(
                                                      image: e.value['display_picture'] !=
                                                                  "" &&
                                                              e.value['display_picture'] !=
                                                                  null &&
                                                              e.value['display_picture'] !=
                                                                  "https://firebase_file_upload_url"
                                                          ? e.value[
                                                              'display_picture']
                                                          : settingPvr
                                                              .profilePictureUrl!
                                                              .replaceAll(
                                                                  '\$name',
                                                                  e.value[
                                                                      'display_name']),
                                                      index: e.key,
                                                      isShare: true,
                                                      widget:
                                                          PopUpMenuButtonLayout(
                                                              onSelected:
                                                                  (value) {
                                                        if (value == 1) {
                                                          final bottomNavPvr =
                                                              Provider.of<
                                                                      BottomNavProvider>(
                                                                  context,
                                                                  listen:
                                                                      false);
                                                          final monitoringPvr =
                                                              Provider.of<
                                                                      MonitoringProvider>(
                                                                  context,
                                                                  listen:
                                                                      false);
                                                          Navigator.pop(
                                                              context);
                                                          bottomNavPvr
                                                              .onTapTab(2);
                                                          monitoringPvr
                                                                  .isAllSelected =
                                                              false;
                                                          monitoringPvr
                                                              .getSingleData(
                                                                  context);
                                                          monitoringPvr
                                                                  .selectedIndex =
                                                              e.key;

                                                          monitoringPvr
                                                              .notifyListeners();
                                                        } else if (value == 2) {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return BlockSharingWithMeDialog(
                                                                    dataInt:
                                                                        e.key,
                                                                    data: e
                                                                        .value);
                                                              });
                                                        }
                                                      }),
                                                      list: settingPvr
                                                          .shareWithMeList,
                                                      text: e.value[
                                                          'display_name'])
                                                ]);
                                              }).toList())
                                            : const Center(
                                                child: Text('No users found',
                                                    style: TextStyle(
                                                        fontSize: 16))))
                                        : (settingPvr.filteredShareWithMeList
                                                .isNotEmpty
                                            ? Column(
                                                children: settingPvr
                                                    .filteredShareWithMeList
                                                    .asMap()
                                                    .entries
                                                    .map((e) {
                                                return Column(children: [
                                                  SettingListLayouts(
                                                      image: e.value['display_picture'] !=
                                                                  "" &&
                                                              e.value['display_picture'] !=
                                                                  null &&
                                                              e.value['display_picture'] !=
                                                                  "https://firebase_file_upload_url"
                                                          ? e.value[
                                                              'display_picture']
                                                          : settingPvr
                                                              .profilePictureUrl!
                                                              .replaceAll(
                                                                  '\$name',
                                                                  e.value[
                                                                      'display_name']),
                                                      index: e.key,
                                                      isShare: true,
                                                      widget:
                                                          PopUpMenuButtonLayout(
                                                              onSelected:
                                                                  (value) {
                                                        if (value == 1) {
                                                          final bottomNavPvr =
                                                              Provider.of<
                                                                      BottomNavProvider>(
                                                                  context,
                                                                  listen:
                                                                      false);
                                                          final monitoringPvr =
                                                              Provider.of<
                                                                      MonitoringProvider>(
                                                                  context,
                                                                  listen:
                                                                      false);
                                                          Navigator.pop(
                                                              context);
                                                          bottomNavPvr
                                                              .onTapTab(2);
                                                          monitoringPvr
                                                                  .isAllSelected =
                                                              false;
                                                          monitoringPvr
                                                              .getSingleData(
                                                                  context);
                                                          monitoringPvr
                                                                  .selectedIndex =
                                                              e.key;

                                                          monitoringPvr
                                                              .notifyListeners();
                                                        } else if (value == 2) {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return BlockSharingWithMeDialog(
                                                                    dataInt:
                                                                        e.key,
                                                                    data: e
                                                                        .value);
                                                              });
                                                        }
                                                      }),
                                                      list: settingPvr
                                                          .filteredShareWithMeList,
                                                      text: e.value[
                                                          'display_name'])
                                                ]);
                                              }).toList())
                                            : Center(
                                                child: Text(
                                                    language(context,
                                                        appFonts.noUsersFound),
                                                    style: const TextStyle(
                                                        fontSize: 16))))))
                            : FutureBuilder<void>(
                                future:
                                    Future.delayed(const Duration(seconds: 3)),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else {
                                    return Center(
                                        child: Text(
                                            language(
                                                context, appFonts.noUsersFound),
                                            style:
                                                const TextStyle(fontSize: 16)));
                                  }
                                }))
                  ]).paddingSymmetric(horizontal: Sizes.s20)))));
    });
  }
}
