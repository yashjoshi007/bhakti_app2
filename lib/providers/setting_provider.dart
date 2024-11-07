import 'dart:developer';
import 'package:bhakti_app/config.dart';

class SettingProvider extends ChangeNotifier {
  TextEditingController? searchBookHere;
  TextEditingController numberOfRound = TextEditingController();
  TextEditingController averageTime = TextEditingController();
  TextEditingController searchUser = TextEditingController();
  TextEditingController searchSharingWithMe = TextEditingController();

  tabControl(context) {
    final bottomNavPvr = Provider.of<BottomNavProvider>(context, listen: false);
    bottomNavPvr.onTapTab(0);
    notifyListeners();
  }

  String? profilePictureUrl;

  Future<String?> getDefaultPic(context) async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(minutes: 5)));
      await remoteConfig.fetchAndActivate();

      String defaultProfilePictureUrl =
          remoteConfig.getString('DefaultProfilePicture');
      profilePictureUrl = defaultProfilePictureUrl;
      return profilePictureUrl;
    } catch (e) {
      log('Error fetching remote config: $e');
      return appFonts.errorFetchingRemoteConfig;
    }
  }

  List shareMySadhanaList = []; //share my sadhana

  bool iamSharingIsAlreadyAdded(String uid) {
    for (var item in shareMySadhanaList) {
      if (item['uid'] == uid) {
        return true;
      }
    }
    return false;
  }

  List<dynamic> filteredSadhanaList = [];

  bool isSearchShareMySadhana = true;

  filterShareMySadhanaList(String query) {
    if (query.isNotEmpty) {
      filteredSadhanaList = [];
      isSearchShareMySadhana = false;

      for (int i = 0; i < shareMySadhanaList.length; i++) {
        String name = shareMySadhanaList[i]["display_name"];
        String email = shareMySadhanaList[i]["masked_identity"];
        if (name.toLowerCase().contains(query.toLowerCase()) ||
            email.contains(query)) {
          filteredSadhanaList.add(shareMySadhanaList[i]);
        }
      }
    } else {
      filteredSadhanaList = shareMySadhanaList;
    }
    notifyListeners();
  }

  List<dynamic> filteredShareWithMeList = [];
  bool isSearchShareWithMe = true;

  void filterShareWithMeList(String query) {
    if (query.isNotEmpty) {
      filteredShareWithMeList = [];
      isSearchShareWithMe = false;

      for (int i = 0; i < shareWithMeList.length; i++) {
        String name = shareWithMeList[i]["display_name"];
        String email = shareWithMeList[i]["masked_identity"];
        if (name.toLowerCase().contains(query.toLowerCase()) ||
            email.contains(query)) {
          filteredShareWithMeList.add(shareWithMeList[i]);
        }
      }
    } else {
      filteredShareWithMeList = shareWithMeList;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    averageTime.dispose();
    super.dispose();
  }

  String? bhakti, bhaktiUserName;

  Future<String?> getStoredAccessKey() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bhakti = pref.getString('BhaktiStepsAccessKey');
    return bhakti;
  }

  Future<String?> getStoredName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bhaktiUserName = pref.getString('Name');
    return bhaktiUserName;
  }

  onTap(dataInt, context, data) async {
    if (dataInt == 4) {
      showDialog(
          context: context,
          builder: (context) {
            return const SettingDialogLayout();
          });
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return data!['navigate'];
      }));
    }
  }

  onNotificationToggle(val, data, context) {
    notifyListeners();
    data['isOn'] = val;
    updateData(context);
  }

  TextEditingController? accessKey;

  onSelected(context, value) {
    if (value == 1) {
      Navigator.pop(context);
    } else if (value == 2) {
      showDialog(
          context: context,
          builder: (context) {
            return const BlockSharingWithMeDialog();
          });
    }
  }

  final Map<int, bool> loadingIndexMap = {};

  void setLoadingIndex(bool value, int index) {
    loadingIndexMap[index] = value;
    notifyListeners();
  }

  bool isLoadingAtIndex(int index) {
    return loadingIndexMap.containsKey(index)
        ? loadingIndexMap[index] ?? false
        : false;
  }

  void onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = appArray.homePageSectionList.removeAt(oldIndex);
    appArray.homePageSectionList.insert(newIndex, item);
    notifyListeners();
    saveHomePageSectionList();
  }

  void onToggle(bool val, Map<String, dynamic> tile) {
    tile['isOn'] = val;
    notifyListeners();
    saveHomePageSectionList();
  }

  List<Map<String, dynamic>> get homePageSectionList =>
      appArray.homePageSectionList;

  Future<void> saveHomePageSectionList() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('homePageSectionList', jsonEncode(homePageSectionList));
  }

  Future<void> loadHomePageSectionList() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString('homePageSectionList');
    if (jsonString != null) {
      appArray.homePageSectionList =
          List<Map<String, dynamic>>.from(jsonDecode(jsonString));
      notifyListeners();
    }
  }

  getNotificationData(context) async {
    try {
      await apiServices
          .getApi(context, api.settings, [], isToken: true)
          .then((value) {
        if (value.isSuccess!) {
          Map<String, dynamic>? responseData =
              value.data as Map<String, dynamic>?;

          if (responseData != null) {
            appArray.notificationSettingList = [
              {
                'name': appFonts.mailNotifications,
                'isOn': responseData['mail_notifications']
              },
              {
                'name': appFonts.appNotifications,
                'isOn': responseData['app_notifications']
              },
              {
                'name': appFonts.sMSNotifications,
                'isOn': responseData['sms_notifications']
              }
            ];
            numberOfRound.text =
                responseData['committed_rounds_of_chanting'].toString();
            averageTime.text = responseData['average_time_for_each_round'];

            notifyListeners();
          }
        }
      });
    } catch (e) {
      notifyListeners();
      log("error error ssss :: $e");
    }
  }

  updateData(context) async {
    isLoading = true;
    var body = {
      "mail_notifications": appArray.notificationSettingList[0]['isOn'],
      "app_notifications": appArray.notificationSettingList[1]['isOn'],
      "sms_notifications": appArray.notificationSettingList[2]['isOn'],
      "committed_rounds_of_chanting": numberOfRound.text,
      "average_time_for_each_round": averageTime.text
    };

    await apiServices
        .postApi(context, api.updateSettings, body, isToken: true)
        .then((value) async {
      if (value.isSuccess!) {
        isLoading = false;
        getNotificationData(context);
        notifyListeners();
      } else {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(value.message)));
      }
    });
  }

  onReady(context) {
    loadHomePageSectionList();
    getNotificationData(context);
    notifyListeners();
    searchUser.addListener(() {
      searchUserData(searchUser.text, context);
    });
    getDefaultPic(context);
    notifyListeners();
    getStoredAccessKey();
    getStoredName();
    getShareTemplate(context);
    notifyListeners();
  }

  bool isLoading = false;

  List searchUserList = [];
  var searchUserDetails;

  Future<void> searchUserData(String query, context) async {
    if (query.length >= 2) {
      showLoading(context);
      Map<String, dynamic> body = {
        "search_text": query,
      };
      try {
        await apiServices
            .postApi(context, api.searchUser, body, isToken: true)
            .then((value) {
          if (value.isSuccess!) {
            hideLoading(context);
            searchUserList.clear();
            for (var i = 0; i < value.data.length; i++) {
              searchUserDetails = {
                'uid': value.data[i]['uid'] ?? '',
                'display_name': value.data[i]['display_name'] ?? '',
                'display_picture': value.data[i]['display_picture'] ?? '',
                'masked_identity': value.data[i]['masked_identity'] ?? '',
              };
              searchUserList.add(searchUserDetails);
            }
            notifyListeners();

            notifyListeners();
          }
        });
      } catch (e) {
        notifyListeners();
        log("error error :: $e");
      }
    }
  }

  Future<void> startSharingWith(dynamic data, BuildContext context) async {
    showLoading(context);
    Map<String, dynamic> body = {"uid": data["uid"]};
    try {
      await apiServices
          .postApi(context, api.startSharingWith, body, isToken: true)
          .then((value) {
        if (value.isSuccess!) {
          hideLoading(context);
          getIamSharingWithData(context);
          notifyListeners();
        }
      });
    } catch (e) {
      log("Error: $e");
    }
  }

  List shareWithMeList = [];

  bool shareIsAlreadyAdded(String uid) {
    for (var item in shareWithMeList) {
      if (item['uid'] == uid) {
        return true;
      }
    }
    return false;
  }

  stopSharingWith(String uid, BuildContext context) async {
    Map<String, dynamic> body = {'uid': uid};
    try {
      await apiServices
          .postApi(context, api.stopSharingWith, body, isToken: true)
          .then((value) {
        if (value.isSuccess!) {
          shareMySadhanaList.removeWhere((element) => element['uid'] == uid);

          getIamSharingWithData(context);
          notifyListeners();
        }
      });
    } catch (e) {
      log("error error :: $e");
    }
  }

  String? shareTemplate;

  Future<String?> getShareTemplate(context) async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(minutes: 5)));
      await remoteConfig.fetchAndActivate();

      String defaultKeyShareTemplate =
          remoteConfig.getString('AccessKeyShareTemplate');
      shareTemplate = defaultKeyShareTemplate;
      return shareTemplate;
    } catch (e) {
      log('Error fetching remote config: $e');
      return appFonts.errorFetchingRemoteConfig;
    }
  }

  blockSharingWithMe(uid, context) async {
    Map<String, dynamic> body = {'uid': uid};
    try {
      await apiServices
          .postApi(context, api.blockSharingWithMe, body, isToken: true)
          .then((value) {
        if (value.isSuccess!) {
          shareWithMeList.removeWhere((element) => element['uid'] == uid);
          getShareWithMeData(context);
          notifyListeners();
        } else {
          Fluttertoast.showToast(
              msg: value.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: appColor(context).appTheme.red,
              textColor: appColor(context).appTheme.whiteColor,
              fontSize: 16.0);
        }
      });
    } catch (e) {
      log("error 6e $e");

      notifyListeners();
    }
  }

  getIamSharingWithData(context) async {
    //share my sadhana
    isLoading = true;
    try {
      await apiServices
          .getApi(context, api.iamSharingWith, [], isToken: true)
          .then((value) {
        if (value.isSuccess!) {
          isLoading = false;
          for (var i = 0; i < value.data.length; i++) {
            Map<String, dynamic> userDetails = {
              'uid': value.data[i]['uid'] ?? "",
              'display_name': value.data[i]['display_name'] ?? "",
              'display_picture': value.data[i]['display_picture'] ?? "",
              'masked_identity': value.data[i]['masked_identity'] ?? "",
              'from_date': value.data[i]['from_date'] ?? ""
            };

            if (!iamSharingIsAlreadyAdded(userDetails['uid'])) {
              shareMySadhanaList.add(userDetails);
            }
          }
          notifyListeners();

          notifyListeners();
        }
      });
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log("error error :: $e");
    }
  }

  getShareWithMeData(context) async {
    isLoading = true;
    try {
      await apiServices
          .getApi(context, api.sharingWithMe, [], isToken: true)
          .then((value) {
        if (value.isSuccess!) {
          isLoading = false;
          for (var i = 0; i < value.data.length; i++) {
            Map<String, dynamic> shareWithMeUserDetails = {
              'uid': value.data[i]['uid'] ?? "",
              'display_name': value.data[i]['display_name'] ?? "",
              'display_picture': value.data[i]['display_picture'] ?? "",
              'masked_identity': value.data[i]['masked_identity'] ?? "",
              'from_date': value.data[i]['from_date'] ?? "",
            };
            if (!shareIsAlreadyAdded(shareWithMeUserDetails['uid'])) {
              shareWithMeList.add(shareWithMeUserDetails);
              notifyListeners();
            }
          }
          notifyListeners();
        }
      });
    } catch (e) {
      log("error error :: $e");
      notifyListeners();
    }
  }
}
