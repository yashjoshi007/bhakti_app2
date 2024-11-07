import 'package:bhakti_app/config.dart';

class AddUserLayout extends StatelessWidget {
  const AddUserLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(builder: (context, settingPvr, child) {
      return Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          body: CommonBgWidget().commonBgImage(
            SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                  CommonAppBar(
                      text: language(context,appFonts.search),
                      onTap: () async {
                        settingPvr.notifyListeners();
                        Navigator.pop(context);
                      },
                      hSpace: Insets.i120),
                  CommonLeftSideText(text: language(context,appFonts.userList)),
                  const VSpace(Insets.i10),
                  CommonTextField(
                      prefixIcon: Row(children: [
                        SvgPicture.asset(eSvgAssets.searchNormal)
                            .paddingOnly(right: Sizes.s10, left: Sizes.s10),
                        SvgPicture.asset(eSvgAssets.line).paddingOnly(right: Sizes.s10)
                      ]),
                      height: Sizes.s50,
                      controller: settingPvr.searchUser,
                      hintText: language(context,appFonts.searchHere)),
                  const VSpace(Insets.i10),
                  settingPvr.searchUserList.isNotEmpty
                      ? CommonContainerTile(
                          paddingArea: const EdgeInsets.all(Sizes.s15),
                          child: Column(
                              children: settingPvr.searchUserList
                                  .asMap()
                                  .entries
                                  .map((e) {
                            final index = e.key;
                            return SettingListLayouts(
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
                                index: index,
                                isShare: true,
                                widget: settingPvr.isLoadingAtIndex(index)
                                    ? const SizedBox(
                                        height: Sizes.s25,
                                        width: Sizes.s25,
                                        child: CircularProgressIndicator())
                                    : Container(
                                        padding: const EdgeInsets.all(Sizes.s6),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: appColor(context)
                                                      .appTheme
                                                      .shadowClr,
                                                  blurRadius: 16,
                                                  offset: const Offset(0, 4),
                                                  spreadRadius: 0)
                                            ],
                                            color: appColor(context)
                                                .appTheme
                                                .whiteColor),
                                        width: Sizes.s34,
                                        height: Sizes.s35,
                                        child: settingPvr.shareMySadhanaList
                                                .any((element) =>
                                                    element['uid'] ==
                                                    e.value!['uid'])
                                            ? SvgPicture.asset(
                                                    eSvgAssets.delete)
                                                .inkWell(onTap: () async {
                                                settingPvr.setLoadingIndex(
                                                    true, index);
                                                await settingPvr
                                                    .stopSharingWith(
                                                        e.value!['uid'],
                                                        context);
                                                settingPvr.setLoadingIndex(
                                                    false, index);
                                              })
                                            : SvgPicture.asset(eSvgAssets.add)
                                                .inkWell(onTap: () async {
                                                settingPvr.setLoadingIndex(
                                                    true, index);
                                                await settingPvr
                                                    .startSharingWith(
                                                        e.value, context);
                                                settingPvr.setLoadingIndex(
                                                    false, index);
                                              })),
                                list: settingPvr.searchUserList,
                                text: e.value?['display_name'] ?? '');
                          }).toList()))
                      : Text(language(context,appFonts.thereHasBeenNoSearch),
                              style: appCss.dmDenseMedium14.textColor(
                                  appColor(context).appTheme.lightText))
                          .marginOnly(top: Sizes.s300)
                ]).paddingSymmetric(horizontal: Sizes.s20))
          ));
    });
  }
}
