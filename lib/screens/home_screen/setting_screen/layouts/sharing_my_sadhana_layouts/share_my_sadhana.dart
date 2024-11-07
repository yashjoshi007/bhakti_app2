import 'package:bhakti_app/config.dart';

class ShareMySadhana extends StatelessWidget {
  const ShareMySadhana({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(builder: (context, settingPvr, child) {
      return StatefulWrapper(
          onInit: () =>
              Future.delayed(const Duration(milliseconds: 50),
                      () => settingPvr.getIamSharingWithData(context)),
          child: Scaffold(
              extendBodyBehindAppBar: true,
              extendBody: true,
              body: CommonBgWidget().commonBgImage(SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CommonAppBar(
                            onTap: () {
                              settingPvr.isSearchShareMySadhana = true;
                              Navigator.pop(context);
                            },
                            text: language(context, appFonts.shareMyShadhana),
                            hSpace: Insets.i50),
                        CommonLeftSideText(
                            text: language(context, appFonts.userList),
                            onTap: () {
                              settingPvr.searchUser.clear();
                              settingPvr.searchUserList.clear();
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return const AddUserLayout();
                                  })).then((value) =>
                                  settingPvr.getIamSharingWithData(context));
                            },
                            isRightText: true,
                            rightText: language(context, appFonts.addUser)),
                        const VSpace(Insets.i10),
                        CommonTextField(
                            onChanged: (query) =>
                                settingPvr.filterShareMySadhanaList(query),
                            prefixIcon: Row(children: [
                              SvgPicture.asset(eSvgAssets.searchNormal)
                                  .paddingOnly(
                                  right: Sizes.s10, left: Sizes.s10),
                              SvgPicture.asset(eSvgAssets.line)
                                  .paddingOnly(right: Sizes.s10)
                            ]),
                            height: Sizes.s50,
                            controller: settingPvr.searchBookHere,
                            hintText: language(context, appFonts.searchHere)),
                        const VSpace(Insets.i10),
                        CommonContainerTile(
                            paddingArea: const EdgeInsets.all(Sizes.s15),
                            child: settingPvr.shareMySadhanaList.isNotEmpty
                                ? RefreshIndicator(
                                onRefresh: () async {
                                  await settingPvr
                                      .getIamSharingWithData(context);
                                },
                                child: SingleChildScrollView(
                                    physics:
                                    const AlwaysScrollableScrollPhysics(),
                                    child: settingPvr.isSearchShareMySadhana
                                        ? (settingPvr
                                        .shareMySadhanaList.isNotEmpty
                                        ? Column(
                                        children: settingPvr.shareMySadhanaList
                                            .asMap()
                                            .entries
                                            .map((e) {
                                          return Column(children: [
                                            SettingListLayouts(
                                                image: e
                                                    .value['display_picture'] !=
                                                    "" &&
                                                    e
                                                        .value['display_picture'] !=
                                                        null &&
                                                    e
                                                        .value['display_picture'] !=
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
                                                CommonTrailingLayout(
                                                    svg: eSvgAssets.delete)
                                                    .inkWell(
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return ShareMySadhanaDialog(
                                                                dataInt:
                                                                e.key,
                                                                data:
                                                                e.value);
                                                          });
                                                    }),
                                                list: settingPvr
                                                    .shareMySadhanaList,
                                                text: e.value['display_name'] ??
                                                    language(context,
                                                        appFonts.unknown))
                                          ]);
                                        }).toList())
                                        : Center(
                                        child: Text(language(
                                            context, appFonts.noUsersFound),
                                            style: const TextStyle(
                                                fontSize: 16))))
                                        : (settingPvr
                                        .filteredSadhanaList.isNotEmpty
                                        ? Column(
                                        children: settingPvr
                                            .filteredSadhanaList
                                            .asMap()
                                            .entries
                                            .map((e) {
                                          return Column(children: [
                                            SettingListLayouts(
                                                image: e
                                                    .value['display_picture'] !=
                                                    "" &&
                                                    e
                                                        .value['display_picture'] !=
                                                        null &&
                                                    e
                                                        .value['display_picture'] !=
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
                                                widget: CommonTrailingLayout(
                                                    svg: eSvgAssets
                                                        .delete)
                                                    .inkWell(onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return ShareMySadhanaDialog(
                                                            dataInt:
                                                            e.key,
                                                            data:
                                                            e.value);
                                                      });
                                                }),
                                                list: settingPvr
                                                    .filteredSadhanaList,
                                                text: e.value['display_name'] ??
                                                    appFonts.unknown)
                                          ]);
                                        }).toList())
                                        : Center(
                                        child: Text(
                                            language(context,
                                                appFonts.noUsersFound),
                                            style: appCss.dmDenseBlack14
                                                .textColor(appColor(context)
                                                .appTheme
                                                .lightText))))))
                                : FutureBuilder<void>(
                                future: Future.delayed(
                                    const Duration(seconds: 2)),
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
                                            style: appCss.dmDenseBlack14
                                                .textColor(appColor(context)
                                                .appTheme
                                                .lightText)));
                                  }
                                }))
                      ]).paddingSymmetric(horizontal: Sizes.s20)))));
    });
  }
}
