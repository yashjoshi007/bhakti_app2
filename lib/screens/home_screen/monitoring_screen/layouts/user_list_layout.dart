import 'package:shimmer/shimmer.dart';
import 'package:bhakti_app/config.dart';

class MonitoringUserListView extends StatelessWidget {
  final List shareWithMeList;

  const MonitoringUserListView({
    super.key,
    required this.shareWithMeList
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<MonitoringProvider, SettingProvider>(
        builder: (context, monitoringPvr, settingPvr, child) {
          bool isLoading = settingPvr.shareWithMeList.isEmpty;
          return SizedBox(
              height: monitoringPvr.isAllSelected ? Sizes.s60 : Sizes.s80,
              child: isLoading
                  ? _buildShimmerLoading()
                  : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: settingPvr.shareWithMeList.length,
                  itemBuilder: (context, index) {
                    final userDataIndex = index;
                    Widget userText() {
                      String displayName = settingPvr
                          .shareWithMeList[userDataIndex]['display_name'];
                      displayName = displayName.split(' ')[0];
                      return Container(
                          alignment: Alignment.center,
                          width: Sizes.s60,
                          height: Sizes.s16,
                          child: Text(
                              displayName, style: appCss.dmDenseBlack12));
                    }
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: monitoringPvr.isAllSelected
                                  ? Sizes.s40
                                  : (monitoringPvr.selectedIndex ==
                                  userDataIndex
                                  ? Sizes.s50
                                  : Sizes.s40),
                              height: monitoringPvr.isAllSelected
                                  ? Sizes.s40
                                  : (monitoringPvr.selectedIndex ==
                                  userDataIndex
                                  ? Sizes.s50
                                  : Sizes.s40),
                              decoration: BoxDecoration(
                                  color: appColor(context).appTheme.whiteColor,
                                  shape: BoxShape.circle
                              ),
                              child: settingPvr
                                  .shareWithMeList[userDataIndex]['display_picture'] !=
                                  "" &&
                                  settingPvr
                                      .shareWithMeList[userDataIndex]['display_picture'] !=
                                      "https://firebase_file_upload_url" &&
                                  settingPvr
                                      .shareWithMeList[userDataIndex]['display_picture'] !=
                                      null
                                  ? ClipOval(
                                  child: CachedNetworkImage(
                                      placeholder: (context, url) =>
                                          Image.network(
                                              settingPvr
                                                  .shareWithMeList[userDataIndex]['display_picture'],
                                              fit: BoxFit.fill,
                                              loadingBuilder: (
                                                  BuildContext context,
                                                  Widget child,
                                                  ImageChunkEvent? loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                } else {
                                                  return const Center(
                                                      child: CircularProgressIndicator());
                                                }
                                              }
                                          ),
                                      errorWidget: (context, url,
                                          error) => const CircularProgressIndicator(),
                                      imageUrl: settingPvr
                                          .shareWithMeList[userDataIndex]['display_picture'],
                                      fit: BoxFit.fill
                                  )
                              )
                                  : Center(
                                  child: CachedNetworkImage(
                                      errorWidget: (context, url,
                                          error) => const CircularProgressIndicator(),
                                      imageUrl: monitoringPvr
                                          .profilePictureUrl != null
                                          ? monitoringPvr.profilePictureUrl!
                                          .replaceAll(
                                          '\$name',
                                          settingPvr
                                              .shareWithMeList[userDataIndex]['display_name'] ??
                                              '')
                                          : '',

                                      placeholder: (context, url) =>
                                          Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          monitoringPvr
                                                              .profilePictureUrl !=
                                                              null
                                                              ?
                                                          monitoringPvr
                                                              .profilePictureUrl!
                                                              .replaceAll(
                                                              '\$name',
                                                              settingPvr
                                                                  .shareWithMeList[userDataIndex]['display_name'])
                                                              : ""
                                                      )
                                                  )
                                              )
                                          )
                                  )
                              )
                          ).marginOnly(
                              left: Sizes.s5,
                              right: Sizes.s5,
                              top: monitoringPvr.isAllSelected
                                  ? Sizes.s10
                                  : (monitoringPvr.selectedIndex ==
                                  userDataIndex
                                  ? Sizes.s10
                                  : Sizes.s15)
                          ).inkWell(
                              onTap: () =>
                                  monitoringPvr.onUserSelection(context,
                                      isAllSelected: false,
                                      index: userDataIndex)
                          ),
                          if (!monitoringPvr.isAllSelected &&
                              monitoringPvr.selectedIndex == userDataIndex)
                            userText()
                        ]
                    );
                  }
              )
          );
        }
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                  width: Sizes.s40,
                  height: Sizes.s40,
                  margin: const EdgeInsets.symmetric(horizontal: Sizes.s5),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle
                  )
              )
          );
        }
    );
  }
}
