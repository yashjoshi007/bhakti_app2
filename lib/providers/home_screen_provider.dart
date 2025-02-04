import 'dart:developer' as developer;
import 'dart:math' as math;
import 'package:bhakti_app/screens/home_screen/drawer_screen/layouts/support_us_screen.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:bhakti_app/config.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bhakti_app/screens/home_screen/drawer_screen/layouts/pdf_view_screen.dart';

import '../screens/home_screen/drawer_screen/layouts/my_doc_layout/doc_widget_layout.dart';

class HomeScreenProvider extends ChangeNotifier {
  Color containerBorderColor = Colors.white;
  String? appVersion;
  String? shraddavan;
  String? krishnaSevaka;
  String? krishnaSadhaka;
  String? srilaPrabhupadaAshraya;
  String? srilaGuruCaranaAshraya;
  String? bhaktiSteps;
  String? cDM;
  String? aCBhaktiVedantaSwami;
  String? iSKCON;
  String? bhaktiUserName;
  String? userAppBarProfilePictureUrl;
  String? regulationsHelpURL;
  String? getLinkOfDrawerMenusURL;
  String preachingTime24 = '00:00';
  String staticPreachingTime24 = '00:00';
  String staticReadingBook24 = "";
  String? chosenValue;
  String? originalChosenValue;
  String? sleptTime;
  String? wakeTime;
  String? mangalaTime;
  String? sandhyaTime;
  String sleepAt24 = "";
  String sleepStatic12 = "";
  String? bhaktiAccessKey;
  String defaultData = "";
  String wakeupTime24 = "";
  String wokeStatic12 = "";
  String? downloadUrlLink;
  String? fileName;
  String? fileSizeFormatted;
  String wakeupTime = "";
  String sleepAt = "";
  String sandhyaArtiTime = "";
  String mangalaArtiTime = "";
  String sandhyaArtiTime24 = "";
  String mangalaStatic12 = "";
  String sandhyaStatic12 = "";
  String manglaArtiTime24 = "";
  String bookReadingTime24 = '00:00';
  String staticHearingSpTime24 = "00:00";
  String hearingSpTime24 = '00:00';
  String othersActivitiesTime24 = '00:00';
  String staticOthersActivitiesTime24 = '00:00';
  String hearingGuruTime24 = '00:00';
  String staticHearingGuruTime24 = '00:00';
  String hearingOthersTime24 = '00:00';
  String staticHearingOthersTime24 = '00:00';
  String notes = "";
  double uploadProgress = 0.0;
  double perc = 0.0;
  Reference? uploadTask;
  bool loading = false;
  bool onLastPage = false;
  bool onChange = false;
  bool onLength = false;
  bool isLoading = false, isCallFun = false;
  bool isExpanded = false;
  bool isExpanded1 = false;
  int index = 0;
  int selectedIndex = 0;
  int sleepTimeHour = 0;
  int sleepTimeMin = 0;
  int sandhyaArtiMin = 0;
  int sandhyaArtiHour = 0;
  int bhagavadGitaHour = 0;
  int srilaHour = 0;
  int selfRealizationHour = 0;
  int selfRealizationMin = 0;
  int srilaMin = 0;
  int bhagavadGitaMin = 0;
  int hearingHour = 0;
  int hearingMin = 0;
  int chantingHour = 0;
  int chantingMin = 0;
  int preachingHour = 0;
  int preachingMin = 0;
  int countRounds = 0;
  int qualityRating = 0;
  int wokeUpTimeHour = 0;
  int wokeUpTimeMin = 0;
  int count = 0;
  dynamic slot1, slot2, slot3, slot4;
  final colors = [Colors.amber[400], Colors.yellow[400]];
  final stops = [0.0, 0.9];
  ScrollController scrollController = ScrollController();
  final GlobalKey<ScaffoldState> homeScreenKey = GlobalKey();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemScrollController itemScrollController1 = ItemScrollController();
  TextEditingController searchHere = TextEditingController();
  TextEditingController smallBookCtrl = TextEditingController();
  TextEditingController mediumBookCtrl = TextEditingController();
  TextEditingController largeBookCtrl = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController notesCtrl = TextEditingController();
  DateTime selectedDate = DateTime.now();
  bool isSearch = false;
  final dynamic sleepTotalHour = 23;
  final dynamic sleepTotalMinute = 55;
  final dynamic wokeUpTotalHour = 23;
  final dynamic wokeUpTotalMinute = 55;
  dynamic sleepCurrentHour = 0;
  dynamic sleepCurrentMinute = 0;
  dynamic wokeUpCurrentHour = 0;
  dynamic wokeUpCurrentMinute = 0;
  final dynamic chantingCountTotalRounds = 100;
  dynamic chantingCountCurrentRounds = 0;
  dynamic chantingCountCurrentQuality = 1;
  final dynamic chantingCountTotalQuality = 10;
  final dynamic sandhyaArtiTotalHour = 23;
  dynamic sandhyaArtiCurrentHour = 0;
  final dynamic sandhyaArtiTotalMinute = 55;
  dynamic sandhyaArtiCurrentMinute = 0;
  final dynamic manglaArtiTotalHour = 23;
  dynamic manglaArtiCurrentHour = 0;
  final dynamic manglaArtiTotalMinute = 55;
  dynamic manglaArtiCurrentMinute = 0;
  final dynamic bookReadingTotalHour = 23;
  dynamic bookReadingCurrentHour = 0;
  final dynamic bookReadingTotalMinute = 55;
  dynamic bookReadingCurrentMinute = 0;
  final dynamic hearingSpTotalHour = 23;
  dynamic hearingSpCurrentHour = 0;
  final dynamic hearingSpTotalMinute = 55;
  dynamic hearingSpCurrentMinute = 0;
  final dynamic hearingGuruTotalHour = 23;
  dynamic hearingGuruCurrentHour = 0;
  final dynamic hearingGuruTotalMinute = 55;
  dynamic hearingGuruCurrentMinute = 0;
  final dynamic hearingOthersTotalHour = 23;
  dynamic hearingOthersCurrentHour = 0;
  final dynamic hearingOthersTotalMinute = 55;
  dynamic hearingOthersCurrentMinute = 0;
  final dynamic preachingTotalHour = 23;
  dynamic preachingCurrentHour = 0;
  final dynamic preachingTotalMinute = 55;
  dynamic preachingCurrentMinute = 0;
  final dynamic othersActivitiesTotalHour = 23;
  dynamic othersActivitiesCurrentHour = 0;
  final dynamic othersActivitiesTotalMinute = 55;
  dynamic othersActivitiesCurrentMinute = 0;
  List regulations = [];
  List<DateTime> currentWeek = [];
  List<String> missingDates = [];

  List allCurrentDate = [];
  List<DateTime> dateList = [];
  List myDownloadUrl = [];
  List bookRmtCnfgList = [];
  List defaultTimeData = [];
  List defaultList = [];
  List searchData = [];
  List<bool> selectedList = List.generate(3, (index) => false);
  List<bool> selectedCertificationsList = List.generate(5, (index) => false);

  List<bool> get selectedLists => selectedList;
  List chantingTitle = [
    appFonts.before630,
    appFonts.before830,
    appFonts.before10,
    appFonts.before930,
    appFonts.after930,
  ];
  List chantingList = [
    {'rounds': 0, 'quality': 1},
    {'rounds': 0, 'quality': 1},
    {'rounds': 0, 'quality': 1},
    {'rounds': 0, 'quality': 1},
    {'rounds': 0, 'quality': 1},
  ];
  List chantingListStatic = [
    {'rounds': 0, 'quality': 1},
    {'rounds': 0, 'quality': 1},
    {'rounds': 0, 'quality': 1},
    {'rounds': 0, 'quality': 1},
    {'rounds': 0, 'quality': 1},
  ];
  Map defaultsMap = {};
  List<Widget> sectionWidgets = [];
  UserModel? userModel;
  List getDataList = [];

  // Function to get the current app version
  getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    appVersion = version;

    //developer.log("'version $version $appVersion $packageInfo');
  }

  // Function to fetch links for drawer items from Firebase Remote Config
  Future<List<Map<String, dynamic>>?> getLinkOfDrawer(context) async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(minutes: 5),
      ));
      await remoteConfig.fetchAndActivate();
      String getLinkOfDrawerURL = remoteConfig.getString('Menus');

      // Parse the JSON string into a dynamic object
      dynamic jsonResult = jsonDecode(getLinkOfDrawerURL);

      if (jsonResult is List<dynamic>) {
        List<Map<String, dynamic>> drawerMenuList =
            jsonResult.cast<Map<String, dynamic>>();

        shraddavan = drawerMenuList[0]['sub_menus'][0]['url'];
        krishnaSevaka = drawerMenuList[0]['sub_menus'][1]['url'];
        krishnaSadhaka = drawerMenuList[0]['sub_menus'][2]['url'];
        srilaPrabhupadaAshraya = drawerMenuList[0]['sub_menus'][3]['url'];
        srilaGuruCaranaAshraya = drawerMenuList[0]['sub_menus'][4]['url'];
        bhaktiSteps = drawerMenuList[1]['sub_menus'][0]['url'];
        cDM = drawerMenuList[1]['sub_menus'][1]['url'];
        aCBhaktiVedantaSwami = drawerMenuList[1]['sub_menus'][2]['url'];
        iSKCON = drawerMenuList[2]['url'];
        return drawerMenuList;
      } else {
        //developer.log("'Error: JSON result is not a list');
        return null;
      }
    } catch (e) {
      //developer.log("'Error fetching remote config: $e');
      return null;
    }
  }

  // Function to navigate to the book reading screen
  bookReadingPresentlyNavigate(context) {
    FocusManager.instance.primaryFocus?.unfocus();
    notifyListeners();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return BookReadPresentlyScreen(bookReadingList: bookRmtCnfgList);
    }));
  }

  // Function to toggle regulations
  regulationToggle(val, e, context) {
    notifyListeners();
    e.value['isOn'] = val;
    updateData(context);
    notifyListeners();
  }

  HomeScreenProvider() {
    notesCtrl.addListener(onTextChanged);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    notesCtrl.removeListener(onTextChanged);
    notesCtrl.dispose();
    super.dispose();
  }

  void onTextChanged() {
    notifyListeners();
  }

  // Function to cache network images
  cacheNetworkImage(context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const ProfileEditScreen();
    })).then((value) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      userModel =
          UserModel.fromJson(json.decode(pref.getString(session.user)!));
      notifyListeners();
    });
  }

  // Function to get the stored username
  Future<String?> getStoredName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bhaktiUserName = pref.getString('Name');
    return bhaktiUserName;
  }

  // Function to get the default profile picture
  Future<String?> getDefaultPic(context) async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(minutes: 5)));
      await remoteConfig.fetchAndActivate();

      String defaultUserProfilePictureUrl =
          remoteConfig.getString('DefaultProfilePicture');
      userAppBarProfilePictureUrl = defaultUserProfilePictureUrl;
      return userAppBarProfilePictureUrl;
    } catch (e) {
      //developer.log("'Error fetching remote config: $e');
      return appFonts.errorFetchingRemoteConfig;
    }
  }

  // Function to get the stored access key
  Future<String?> getStoredAccessKey() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bhaktiAccessKey = pref.getString('BhaktiStepsAccessKey');
    return bhaktiAccessKey;
  }

  int? loggedInId;

  getLoggedUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    loggedInId = pref.getInt('LoggedInId');
    //developer.log(""bhakti logged in user $loggedInId");
    return loggedInId;
  }

  // Function to get the default regulations help URL
  Future<String?> getDefaultRegulationsHelpURL(context) async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(minutes: 5)));
      await remoteConfig.fetchAndActivate();
      String defaultRegulationsHelpURL =
          remoteConfig.getString('RegulationsHelpURL');
      regulationsHelpURL = defaultRegulationsHelpURL;

      return regulationsHelpURL;
    } catch (e) {
      //developer.log("'Error fetching remote config: $e');
      return language(context, appFonts.errorFetchingRemoteConfig);
    }
  }

  // Function to handle default profile image
  defaultProfileImage(context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const ProfileEditScreen();
    }));
  }

  // Function to return a background widget
  Widget yourBackgroundWidget() {
    return Container(color: Colors.blue[100]);
  }

  // Function to handle drawer item taps
  onTapDrawer(index, value, context) {
    isExpanded = false;
    selectedIndex = index;
    if (language(context, value['name']) == language(context, appFonts.home)) {
      homeScreenKey.currentState!.closeDrawer();
    } else if (language(context, value['name']) ==
        language(context, appFonts.profile)) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ProfileEditScreen()));
      homeScreenKey.currentState!.closeDrawer();
    } else if (language(context, value['name']) ==
        language(context, appFonts.aboutUs)) {
      isExpanded = true;
    } else if (language(context, value['name']) ==
        language(context, appFonts.myDocuments)) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const MyDocumentScreen()));
      homeScreenKey.currentState!.closeDrawer();
    } else if (language(context, value['name']) ==
        language(context, appFonts.iSkcon)) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const IskconUrl()));
      homeScreenKey.currentState!.closeDrawer();
    } else if (language(context, value['name']) ==
        language(context, appFonts.contactUs)) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ContactUsScreen()));
      homeScreenKey.currentState!.closeDrawer();
    } else if (language(context, value['name']) ==
        language(context, appFonts.supportUs)) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SupportUsScreen()));
      homeScreenKey.currentState!.closeDrawer();
    }

    notifyListeners();
  }

  // Function to fetch default time data from Firebase Remote Config
  Future<void> getDefaultTime() async {
    try {
      // Initialize Firebase Remote Config
      final remoteConfig = FirebaseRemoteConfig.instance;
      // Set configuration settings for Remote Config
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(minutes: 5)));
      // Fetch and activate remote config data
      await remoteConfig.fetchAndActivate();
      // Get default time data from remote config
      defaultData = remoteConfig.getString('Defaults');
      // Parse the default time data into a map
      defaultsMap = json.decode(defaultData);
    } catch (e) {
      // Handle any errors that occur during the process
      //developer.log(""error error :: $e");
    }
  }

  // this is the function which is fetching the default data from the firebase remote config
  setSleepTimeFromDefaults() {
    if (defaultsMap.containsKey('SleepingTime') &&
        defaultsMap.containsKey('MagalaArtiTime') &&
        defaultsMap.containsKey('WakeUpTime') &&
        defaultsMap.containsKey('SandhyaArtiTime') &&
        defaultsMap.containsKey('ChantingQualityRating')) {
      List<String> sleepTimeComponents =
          defaultsMap['SleepingTime']?.split(':') ?? ['0', '0'];
      List<String> manglaTimeComponents =
          defaultsMap['MagalaArtiTime']?.split(':') ?? ['0', '0'];
      List<String> wokeUpTimeComponents =
          defaultsMap['WakeUpTime']?.split(':') ?? ['0', '0'];
      List<String> sandhyaTimeComponents =
          defaultsMap['SandhyaArtiTime']?.split(':') ?? ['0', '0'];
      int chantingQualityRating = defaultsMap['ChantingQualityRating'] ?? 1;
      if (sleepCurrentHour == 0 && sleepCurrentMinute == 0) {
        sleepCurrentHour = int.parse(sleepTimeComponents[0]);
        sleepCurrentMinute = int.parse(sleepTimeComponents[1]);
      }
      if (manglaArtiCurrentHour == 0 && manglaArtiCurrentMinute == 0) {
        manglaArtiCurrentHour = int.parse(manglaTimeComponents[0]);
        manglaArtiCurrentMinute = int.parse(manglaTimeComponents[1]);
      }
      if (wokeUpCurrentHour == 0 && wokeUpCurrentMinute == 0) {
        wokeUpCurrentHour = int.parse(wokeUpTimeComponents[0]);
        wokeUpCurrentMinute = int.parse(wokeUpTimeComponents[1]);
      }
      if (sandhyaArtiCurrentHour == 0 && sandhyaArtiCurrentMinute == 0) {
        sandhyaArtiCurrentHour = int.parse(sandhyaTimeComponents[0]);
        sandhyaArtiCurrentMinute = int.parse(sandhyaTimeComponents[1]);
      }
      chantingCountCurrentQuality = chantingQualityRating;
      int index = 0;
      chantingList[index]['quality'] = chantingQualityRating;

      notifyListeners();
    } else {}
  }

  onSleepAtHour(val) {
    int hour12 = val % 12;
    String period = (val < 12) ? 'AM' : 'PM';
    sleepStatic12 =
        "${hour12.toString().padLeft(2, '0')}:${sleepCurrentMinute.toString().padLeft(2, '0')} $period";
    sleepCurrentHour = val;
    notifyListeners();
  }

  // Function to handle changes in the hour for sleep time
  onSleepAtMinute(val) {
    int hour12 = sleepCurrentHour % 12;
    String period = (sleepCurrentHour < 12) ? 'AM' : 'PM';
    sleepStatic12 =
        "${hour12.toString().padLeft(2, '0')}:${val.toString().padLeft(2, '0')} $period";
    notifyListeners();
    sleepCurrentMinute = val;
    notifyListeners();
  }

  // on slept at time selection function
  onSleepTimeSelect(context) {
    FocusManager.instance.primaryFocus?.unfocus();
    sleepCurrentHour = 0;
    sleepCurrentMinute = 0;
    int originalHour = sleepCurrentHour;
    int originalMinute = sleepCurrentMinute;
    if (sleepAt.isEmpty) {
      // if slept at is empty then it will call the default time from the firebase remote config
      setSleepTimeFromDefaults();
    } else {
      int hour = int.parse(sleepAt.split(":")[0]);
      int minute = int.parse(sleepAt.split(":")[1].split(" ")[0]);
      if (sleepAt.contains("PM") && hour < 12) {
        hour += 12;
      } else if (sleepAt.contains("AM") && hour == 12) {
        hour = 0;
      }
      sleepCurrentHour = hour;
      sleepCurrentMinute = minute;
      notifyListeners();
    }
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context1) {
          return SleepAtSectionDialog(originalHour, originalMinute);
        });
  }

  // Function to handle changes in the hour for waking up time
  onWokeUpHour(val) {
    // Calculate the hour in 12-hour format
    int hour12 = val % 12;
    // Determine the period (AM or PM)
    String period = (val < 12) ? 'AM' : 'PM';
    // Format the waking up time in 12-hour format with leading zeros for hour and minute
    wokeStatic12 =
        "${hour12.toString().padLeft(2, '0')}:${wokeUpCurrentMinute.toString().padLeft(2, '0')} $period";
    // Update the current hour for waking up time
    wokeUpCurrentHour = val;
    notifyListeners();
  }

  // Function to handle changes in the minute for waking up time
  onWokeUpMinute(val) {
    // Calculate the hour in 12-hour format for display
    int hour12 = wokeUpCurrentHour % 12;
    // Determine the period (AM or PM) based on the current hour
    String period = (wokeUpCurrentHour < 12) ? 'AM' : 'PM';
    // Format the waking up time in 12-hour format with leading zeros for hour and minute
    wokeStatic12 =
        "${hour12.toString().padLeft(2, '0')}:${val.toString().padLeft(2, '0')} $period";
    // Update the current minute for waking up time
    wokeUpCurrentMinute = val;
    notifyListeners();
  }

  // Function to handle selection of waking up time
  onWokeUpTimeSelect(context) {
    FocusManager.instance.primaryFocus?.unfocus();
    // Reset the current hour and minute for waking up time
    wokeUpCurrentHour = 0;
    wokeUpCurrentMinute = 0;

    // Store the original hour and minute for waking up time
    int originalHour = wokeUpCurrentHour;
    int originalMinute = wokeUpCurrentMinute;

    // If the waking up time is not empty, parse and set the hour and minute
    if (wakeupTime.isEmpty) {
      setSleepTimeFromDefaults(); // if wokeup at is empty then it will call the default time from the firebase remote config
    } else {
      int hour = int.parse(wakeupTime.split(":")[0]);
      int minute = int.parse(wakeupTime.split(":")[1].split(" ")[0]);

      if (wakeupTime.contains("PM") && hour < 12) {
        hour += 12;
      } else if (wakeupTime.contains("AM") && hour == 12) {
        hour = 0;
      }
      wokeUpCurrentHour = hour;
      wokeUpCurrentMinute = minute;
      notifyListeners();
    }
    // Show the dialog for selecting waking up time
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context1) {
          return WokeUpSectionDialog(originalHour, originalMinute);
        });
  }

  // Function to toggle expansion of a tile
  onExpandTileTap() {
    // Toggle the expansion state
    isExpanded = !isExpanded;
    notifyListeners();
  }

  // Function to toggle expansion of certifications tile
  onExpandTileCertificationsTap() {
    // Toggle the expansion state
    isExpanded1 = !isExpanded1;
    notifyListeners();
  }

  // Function to handle expansion of drawer items related to about us
  void drawerAboutUsExpansionList(index) {
    // Toggle the expansion state for the selected item
    selectedList[index] = !selectedList[index];
    notifyListeners();
  }

  // Function to handle expansion of drawer items related to certifications
  void drawerCertificationsExpansionList(index, context) {
    // Toggle the expansion state for the selected item
    selectedCertificationsList[index] = !selectedCertificationsList[index];
    notifyListeners();
  }

  // Function to prepare the home screen by fetching data from Firebase Remote Config
  onReadyHome() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    // Configure settings for remote config fetch
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(minutes: 5)));

    notifyListeners();
    // Fetch and activate remote config data
    await remoteConfig.fetchAndActivate();
    notifyListeners();
    // Decode and store the fetched book data
    List<dynamic> mapValues =
        json.decode(remoteConfig.getValue("books").asString());
    defaultList = mapValues;
    bookRmtCnfgList = mapValues;

    notifyListeners();
    // Get the current app version
    getAppVersion();
  }

  // Function to format file size in bytes to a human-readable format
  String formatBytes(int bytes, [int decimals = 2]) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    final i = (math.log(bytes) / math.log(1024)).floor();
    return '${(bytes / math.pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  // Function to pick a file from device storage
  filePick(context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    // Show loading indicator
    loading = true;
    notifyListeners();

    // Open file picker
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if (result != null) {
      // Get file details
      fileName = result.files.first.name;
      File file = File(result.files.first.path!);
      int fileSize = file.lengthSync();
      fileSizeFormatted = formatBytes(fileSize);
      try {
        // Upload the file to Firebase Storage
        final Reference reference = FirebaseStorage.instance
            .ref()
            .child('BhaktiSteps-Documents/${user!.uid}/$fileName');

        final UploadTask uploadTask = reference.putFile(file);

        // Listen to upload task events
        uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) async {
          switch (snapshot.state) {
            case TaskState.running:
              final progress =
                  100 * (snapshot.bytesTransferred / snapshot.totalBytes);
              perc = progress.toDouble();
              if (perc == 100.0) {
                myDocumentLink(context);
                getDocumentUrlLink(context);
              }

              notifyListeners();
            // TODO: Handle this case.
            case TaskState.paused:
              // TODO: Handle this case.
              //developer.log("'paused');
              myDocumentLink(context);
              getDocumentUrlLink(context);
              break;
            case TaskState.canceled:
              // TODO: Handle this case.
              loading = false;
              myDocumentLink(context);
              getDocumentUrlLink(context);
              //developer.log("'canceled loading $loading');
              notifyListeners();
              break;
            case TaskState.error:
              // TODO: Handle this case.
              loading = false;
              myDocumentLink(context);
              getDocumentUrlLink(context);
              //developer.log("'error loading $loading');
              notifyListeners();
              break;
            case TaskState.success:
              await reference.getDownloadURL().then((fileUrl) {
                myDocumentLink(context);
                getDocumentUrlLink(context);
                //developer.log("'success success');
                //developer.log(""pdf url link $fileUrl");
              });
              //developer.log("'upload id success');
              //developer.log("'success success11111');
              // TODO: Handle this case.

              loading = false;
              notifyListeners();
              break;
          }
        });
        await uploadTask.whenComplete(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('File Uploaded Successfully',
                  style: appCss.dmDenseMedium16
                      .textColor(appColor(context).appTheme.black))));
        });

        final downloadLink = await reference.getDownloadURL();
        downloadUrlLink = downloadLink;
        myDocumentLink(context);
        getDocumentUrlLink(context);
        notifyListeners();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('File Upload Failed: $e',
                style: appCss.dmDenseMedium16
                    .textColor(appColor(context).appTheme.black))));
      }
    } else {
      loading = false;
      notifyListeners();
      // User canceled the picker
    }
  }

  Future<void> fetchData(context) async {
    try {
      notifyListeners();
      myDocumentLink(context);
      // Simulate a network delay
      await Future.delayed(Duration(seconds: 2));

      // Notify listeners to update UI
      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error fetching data: $e');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> refreshData(context) async {
    await fetchData(context);
  }

  // Function to update the document link on the server
  myDocumentLink(context, {isTap = false}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    final Reference reference = FirebaseStorage.instance
        .ref()
        .child('BhaktiSteps-Documents/${user!.uid}/$fileName');

    //developer.log(""reference ${reference.fullPath}");
    isLoading = true;
    try {
      Map<String, String> body = {
        "document_upload_url": downloadUrlLink!,
        "storage_path": reference.fullPath,
        "title": fileName!
      };
      //developer.log(""body % $body");
      await apiServices
          .postApi(context, api.documentUpload, body, isToken: true)
          .then((value) async {
        if (value.isSuccess!) {
          isLoading = false;
          myDocumentLink(context);
          getDocumentUrlLink(context);
          notifyListeners();
        }
      });
    } catch (e) {
      isLoading = false;
      //developer.log(""message $e");
    }
  }

  deleteDocument(context, documentId, storagePath) async {
    isLoading = true;
    //developer.log("'storagePath $storagePath $documentId');
    final Reference reference =
        FirebaseStorage.instance.ref().child(storagePath);
    await reference.delete();
    try {
      isLoading = true;
      Map<String, String> body = {"id": documentId};
      //developer.log(""body % $body");
      await apiServices
          .postApi(context, api.documentDelete, body, isToken: true)
          .then((value) async {
        if (value.isSuccess!) {
          isLoading = false;
          //developer.log(""  value value $value");

          myDownloadUrl.removeWhere((document) => document['id'] == documentId);
          notifyListeners();
          getDocumentUrlLink(context);

          notifyListeners();
        } else {
          isLoading = false;
          //developer.log(""Failed to delete document entry from API: ${value.message}");
        }
      });
    } catch (e) {
      isLoading = false;

      //developer.log(""Error deleting document: $e");
      notifyListeners();
    }
  }

  // Function to fetch document URLs from the server
  getDocumentUrlLink(context) async {
    isLoading = true;
    try {
      await apiServices
          .getApi(context, api.getDocuments, [], isToken: true)
          .then((value) async {
        isLoading = true;
        if (value.isSuccess!) {
          isLoading = false;
          myDownloadUrl = [];
          notifyListeners();
          for (var document in value.data['documents']) {
            developer
                .log("document['storage_path'] ${document['storage_path']}");
            myDownloadUrl.add({
              'id': document['id'],
              'uid': document['uid'],
              'document_url': document['document_url'],
              "storage_path": document['storage_path'],
              'title': document['title'],
              'created_dtm': document['created_dtm']
            });
          }
          notifyListeners();
        }
      });
    } catch (e) {
      isLoading = false;

      notifyListeners();
      //developer.log(""error error :: $e");
    }
  }

  bool isDownloading = false;
  String progress = "";

// download and open pdf
  Future<void> downloadAndOpenPdf(String url, String fileName, context) async {
    notifyListeners();
    isDownloading = true;

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName.pdf');

    try {
      final response = await Dio().download(url, file.path,
          onReceiveProgress: (received, total) {
        if (total != -1) {
          notifyListeners();
          progress = (received / total * 100).toStringAsFixed(0);
        }
      });

      //developer.log("'$response');

      isDownloading = false;
      progress = "";
      notifyListeners();

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PdfViewerScreen(filePath: file.path, fileName: fileName)));
    } catch (e) {
      notifyListeners();
      isDownloading = false;
      progress = "";

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error downloading PDF: $e')));
    }
  }

  // Function to update chanting count rounds
  onChantingCountRounds(val, index) {
    notifyListeners();
    // Update chanting count rounds
    chantingCountCurrentRounds = val;
    // Update chanting list static
    chantingListStatic[index]["rounds"] = val;
    notifyListeners();
  }

  // Function to update chanting count quality
  onChantingCountQuality(val, index) {
    notifyListeners();
    // Update chanting count quality
    chantingCountCurrentQuality = val;
    // Update chanting list static
    chantingListStatic[index]["quality"] = val;
    notifyListeners();
  }

  // Function to handle selecting chanting count
  onChantingCountSelect(context, index) {
    FocusManager.instance.primaryFocus?.unfocus();
    notifyListeners();
    chantingCountCurrentRounds = 0;
    if (chantingList[index]['quality'] != 1) {
      notifyListeners();
      // Update chanting count rounds
      chantingCountCurrentRounds = chantingList[index]['rounds'];
      notifyListeners();
      // Update chanting count quality
      chantingCountCurrentQuality = chantingList[index]['quality'];
      notifyListeners();
    } else {
      // if chanting quality is not having an value then it will take default value from the firebase remote config
      setSleepTimeFromDefaults();
      notifyListeners();
    }
    int originalRounds = chantingList[index]['rounds'];
    int originalQuality = chantingList[index]['quality'];
    // Show chanting dialog
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context1) {
          return ChantingDialog(originalRounds, originalQuality, index);
        });
  }

  // Function to handle calendar date change
  onCalendarChange(context) async {
    var results = await showCalendarDatePicker2Dialog(
        barrierDismissible: false,
        context: context,
        config: CalendarDatePicker2WithActionButtonsConfig(
            lastDate: DateTime.now(), firstDate: DateTime(1886)),
        dialogSize: const Size(325, 400),
        dialogBackgroundColor: appColor(context).appTheme.whiteColor,
        builder: (context, child) {
          return AppbarCalendarDialog(child);
        },
        borderRadius: BorderRadius.circular(15));
    debugPrint("result :: $results");
    if (results != null && results.isNotEmpty) {
      isCallFun = true;
      notifyListeners();
      selectedDate = results[0]!;
      notifyListeners();
      debugPrint("Selected date: $selectedDate");
    }
  }

  // Function to handle calendar date change
  onCalendarDateChange(date, {list}) {
    selectedDate = date;
    if (list != null) {
      dateList = list;
    }
    notifyListeners();
  }

  // Function to filter books based on search query
  filterBooks(String query) {
    if (query.isNotEmpty) {
      notifyListeners();
      isSearch = true;
      query = query.toLowerCase();
      notifyListeners();
      searchData = bookRmtCnfgList
          .where((book) => book["book_name"].toLowerCase().contains(query))
          .toList();

      // Sort the searchData by book names
      searchData.sort((a, b) {
        String nameA = a["book_name"].toLowerCase();
        String nameB = b["book_name"].toLowerCase();
        return nameA.compareTo(nameB);
      });
    } else {
      notifyListeners();
      searchData = bookRmtCnfgList;
      notifyListeners();
    }
  }

  // Function to handle Mangla Arti hour change
  onManglaArtiHour(val) {
    int hour12 = val % 12;
    String period = (val < 12) ? 'AM' : 'PM';
    mangalaStatic12 =
        "${hour12.toString().padLeft(2, '0')}:${manglaArtiCurrentMinute.toString().padLeft(2, '0')} $period";

    manglaArtiCurrentHour = val;
    notifyListeners();
  }

  // Function to handle Mangla Arti minute change
  onManglaArtiMinute(val) {
    int hour12 = manglaArtiCurrentHour % 12;
    String period = (manglaArtiCurrentHour < 12) ? 'AM' : 'PM';
    mangalaStatic12 =
        "${hour12.toString().padLeft(2, '0')}:${val.toString().padLeft(2, '0')} $period";

    notifyListeners();
    manglaArtiCurrentMinute = val;
  }

  // Function to handle Sandhya Arti hour change
  onSandhyaArtiHour(val) {
    int hour12 = val % 12;
    String period = (val < 12) ? 'AM' : 'PM';
    sandhyaStatic12 =
        "${hour12.toString().padLeft(2, '0')}:${sandhyaArtiCurrentMinute.toString().padLeft(2, '0')} $period";
    sandhyaArtiCurrentHour = val;
    notifyListeners();
  }

  // Function to handle Sandhya Arti minute change
  onSandhyaArtiMinute(val) {
    int hour12 = sandhyaArtiCurrentHour % 12;
    String period = (sandhyaArtiCurrentHour < 12) ? 'AM' : 'PM';
    sandhyaStatic12 =
        "${hour12.toString().padLeft(2, '0')}:${val.toString().padLeft(2, '0')} $period";

    notifyListeners();
    sandhyaArtiCurrentMinute = val;
  }

  // Function to handle Sandhya Arti toggle change
  onSandhyaToggle(val, e) {
    notifyListeners();
    e.value['isOn'] = val;
    notifyListeners();
  }

  // Function to handle Sandhya Arti time selection
  onSandhyaArtiSelect(context) {
    FocusManager.instance.primaryFocus?.unfocus();
    sandhyaArtiCurrentHour = 0;
    sandhyaArtiCurrentMinute = 0;
    int originalSandhyaHour = sandhyaArtiCurrentHour;
    int originalSandhyaMinute = sandhyaArtiCurrentMinute;
    if (sandhyaArtiTime.isEmpty) {
      setSleepTimeFromDefaults(); // if sandhya Arti Time is empty then it will call the default time from the firebase remote config
    } else {
      int hour = int.parse(sandhyaArtiTime.split(":")[0]);
      int minute = int.parse(sandhyaArtiTime.split(":")[1].split(" ")[0]);

      if (sandhyaArtiTime.contains("PM") && hour < 12) {
        hour += 12;
      } else if (sandhyaArtiTime.contains("AM") && hour == 12) {
        hour = 0;
      }

      sandhyaArtiCurrentHour = hour;
      sandhyaArtiCurrentMinute = minute;
      notifyListeners();
    }
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return SandhyaSectionDialog(
              originalSandhyaHour, originalSandhyaMinute);
        });
  }

  // Function to handle Mangla Arti toggle change
  manglaArtiToggle(val, e) {
    notifyListeners();
    e.value['isOn'] = val;
    notifyListeners();
  }

  // Function to handle Mangla Arti time selection
  onManglaArtiSelect(context) {
    FocusManager.instance.primaryFocus?.unfocus();
    manglaArtiCurrentHour = 0;
    manglaArtiCurrentMinute = 0;
    int originalmanglaHour = manglaArtiCurrentHour;
    int originalmanglaMin = manglaArtiCurrentMinute;
    if (mangalaArtiTime.isEmpty) {
      setSleepTimeFromDefaults(); // if mangala arti time is empty then it will call the default time from the firebase remote config
    } else {
      int hour = int.parse(mangalaArtiTime.split(":")[0]);
      int minute = int.parse(mangalaArtiTime.split(":")[1].split(" ")[0]);

      if (mangalaArtiTime.contains("PM") && hour < 12) {
        hour += 12;
      } else if (mangalaArtiTime.contains("AM") && hour == 12) {
        hour = 0;
      }

      manglaArtiCurrentHour = hour;
      manglaArtiCurrentMinute = minute;
      notifyListeners();
    }
    notifyListeners();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context1) {
          return MangalaSectionContainer(originalmanglaHour, originalmanglaMin);
        });
  }

  // Function to show exit popup dialog
  Future<bool> showExitPopup(context) async {
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: SizedBox(
                  height: Sizes.s175,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(language(context, appFonts.doYouWantToExit)),
                        const SizedBox(height: Sizes.s20),
                        const VSpace(Insets.i25),
                        CommonSelectionButton(
                            textTwo: language(context, appFonts.exit),
                            onTapOne: () => Navigator.pop(context),
                            onTapTwo: () => exit(0))
                      ])));
        });
  }

  // Function to handle Hear Prabhupada hour change
  onHearPrabhupadaHour(val) {
    staticHearingSpTime24 =
        "${val.toString().padLeft(2, '0')}:${hearingSpCurrentMinute.toString().padLeft(2, '0')}";

    hearingSpCurrentHour = val;
    notifyListeners();
  }

  // Function to handle Hear Prabhupada minute change
  onHearPrabhupadaMinute(val) {
    notifyListeners();
    staticHearingSpTime24 =
        "${hearingSpCurrentHour.toString().padLeft(2, '0')}:${val.toString().padLeft(2, '0')}";

    //developer.log(""staticHearingSpTime24 $hearingSpCurrentHour");

    notifyListeners();
    hearingSpCurrentMinute = val;
    notifyListeners();
  }

  // Function to handle Hear Prabhupada dialog
  onHearPrabhupada(context) {
    FocusManager.instance.primaryFocus?.unfocus();
    notifyListeners();
    int originalSpHour = hearingSpCurrentHour;
    int originalSpMin = hearingSpCurrentMinute;

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context1) {
          return HearPrabhupadaDialog(originalSpHour, originalSpMin);
        });
  }

  // Function to handle Hear Guru Maharaja hour change
  onHearGuruMaharajaHour(val) {
    staticHearingGuruTime24 =
        "${val.toString().padLeft(2, '0')}:${hearingGuruCurrentMinute.toString().padLeft(2, '0')}";

    hearingGuruCurrentHour = val;
    notifyListeners();
  }

  // Function to handle Hear Guru Maharaja minute change
  onHearGuruMaharajaMinute(val) {
    staticHearingGuruTime24 =
        "${hearingGuruCurrentHour.toString().padLeft(2, '0')}:${val.toString().padLeft(2, '0')}";

    notifyListeners();
    hearingGuruCurrentMinute = val;
  }

  // Function to handle Hear Guru Maharaja dialog
  onHearGuruMaharaja(context) {
    FocusManager.instance.primaryFocus?.unfocus();
    notifyListeners();
    int originalGuruHour = hearingGuruCurrentHour;
    int originalGuruMin = hearingGuruCurrentMinute;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context1) {
          return HearGuruMaharajaDialog(originalGuruHour, originalGuruMin);
        });
  }

  // Function to handle Hearing Others hour change
  onHearingOthersHour(val) {
    staticHearingOthersTime24 =
        "${val.toString().padLeft(2, '0')}:${hearingOthersCurrentMinute.toString().padLeft(2, '0')}";
    hearingOthersCurrentHour = val;
    notifyListeners();
  }

  // Function to handle Hearing Others minute change
  onHearingOthersMinute(val) {
    staticHearingOthersTime24 =
        "${hearingOthersCurrentHour.toString().padLeft(2, '0')}:${val.toString().padLeft(2, '0')}";

    notifyListeners();
    hearingOthersCurrentMinute = val;
  }

  // Function to handle Hearing Others dialog
  onHearOthers(context) {
    FocusManager.instance.primaryFocus?.unfocus();
    notifyListeners();
    int originalOthersHour = hearingOthersCurrentHour;
    int originalOthersMinute = hearingOthersCurrentMinute;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context1) {
          return HearOthersDialog(originalOthersHour, originalOthersMinute);
        });
  }

  // Function to handle Preaching hour change
  onPreachingHour(val) {
    staticPreachingTime24 =
        "${val.toString().padLeft(2, '0')}:${preachingCurrentMinute.toString().padLeft(2, '0')}";

    preachingCurrentHour = val;
    notifyListeners();
  }

  // Function to handle Preaching minute change
  onPreachingMinute(val) {
    staticPreachingTime24 =
        "${preachingCurrentHour.toString().padLeft(2, '0')}:${val.toString().padLeft(2, '0')}";

    notifyListeners();
    preachingCurrentMinute = val;
  }

  // Function to handle Preaching dialog
  onPreaching(context) {
    FocusManager.instance.primaryFocus?.unfocus();
    notifyListeners();

    int originalPreachingHour = preachingCurrentHour;
    int originalPreachingMin = preachingCurrentMinute;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context1) {
          return PreachingDialog(originalPreachingHour, originalPreachingMin);
        });
  }

  showBookReadingDialog(BuildContext context, index, data) async {
    // //developer.log(""abcdefg ${data}");
    if (data['reading_time'] == null) {
      bookReadingCurrentHour = 0;
      bookReadingCurrentMinute = 0;
      chosenValue = null;
    } else {
      //developer.log("" ${data['reading_time']}");
      String readingTime =
          data['reading_time'] != "" ? data['reading_time'] : "0:0";
      chosenValue = data['selected_chapters'];

      bookReadingCurrentHour = int.parse(readingTime.split(":")[0]);
      notifyListeners();
      bookReadingCurrentMinute =
          int.parse(readingTime.split(":")[1].split(" ")[0]);
      notifyListeners();
    }
    // int originalReadingHour = 0;
    // int originalReadingMinute = 10;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context1) {
          return BookReadingDialog(
              bookReadingCurrentHour, bookReadingCurrentMinute, index, data);
        });
  }

  // Function to handle Others Activities hour change
  onOthersActivitiesHour(val) {
    staticOthersActivitiesTime24 =
        "${val.toString().padLeft(2, '0')}:${othersActivitiesCurrentMinute.toString().padLeft(2, '0')}";
    othersActivitiesCurrentHour = val;
    notifyListeners();
  }

  // Function to handle Others Activities minute change
  onOthersActivitiesMinute(val) {
    staticOthersActivitiesTime24 =
        "${othersActivitiesCurrentHour.toString().padLeft(2, '0')}:${val.toString().padLeft(2, '0')}";

    notifyListeners();
    othersActivitiesCurrentMinute = val;
  }

  // Function to handle Others Activities dialog
  onOtherActivities(context) {
    FocusManager.instance.primaryFocus?.unfocus();
    notifyListeners();
    int originalOthersActivitiesHour = othersActivitiesCurrentHour;
    int originalOthersActivitiesMinute = othersActivitiesCurrentMinute;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context1) {
          return OtherActivitiesDialog(
              originalOthersActivitiesHour, originalOthersActivitiesMinute);
        });
  }

  // Function to handle sign out click
  onSignOutClick(context) async {
    try {
      await apiServices
          .getApi(context, api.logout, [], isToken: true)
          .then((value) async {
        final prefs = await SharedPreferences.getInstance();

        if (value.isSuccess!) {
          prefs.clear();

          if (await prefs.clear()) {
            prefs.remove("session.accessToken");
            prefs.remove("bookList");
            prefs.remove("selectedLocale");
            prefs.remove("session.user");
            prefs.remove("Name");
            prefs.remove("BhaktiStepsAccessKey");
            prefs.remove("homePageSectionList");
            prefs.remove("DefaultProfilePicture");
            await FirebaseAuth.instance.signOut().then((value) async {
              notifyListeners();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const LoginAuthScreen();
              }));
            });
          } else {
            //developer.log(""Something went wrong while Login");
          }
          notifyListeners();
        }
      });
    } catch (e) {
      notifyListeners();
    }
  }

  reorderFunction(context) {
    notifyListeners();
    final settingPvr = Provider.of<SettingProvider>(context, listen: false);
    settingPvr.loadHomePageSectionList();
    notifyListeners();
  }

  // This function is called when the app is ready, it initializes various data and retrieves necessary information.
  onReady(context) async {
    await onReadyHome(); // Perform necessary actions when the home screen is ready
    getDefaultTime(); // Get default time settings
    getLinkOfDrawer(context); // Retrieve the link of the drawer
    reorderFunction(context);
    notifyListeners();
    getDefaultPic(context); // Get default profile picture
    getStoredAccessKey(); // Retrieve stored access key
    getLoggedUserId(); // Retrieve stored user logged in id
    getDefaultRegulationsHelpURL(
        context); // Retrieve default regulations help URL
    getStoredName(); // Retrieve stored user name
    getData(context); // Retrieve data from the server
    getCalendarScoreData(context);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    notifyListeners();
    await Future.delayed(DurationsClass.s1);
    userModel =
        UserModel.fromJson(json.decode(preferences.getString(session.user)!));
    getDocumentUrlLink(context); // Retrieve document URL link
    notifyListeners();
    final settingPvr = Provider.of<SettingProvider>(context, listen: false);
    settingPvr.getShareWithMeData(context);
    final commonApi = Provider.of<CommonApiProvider>(context, listen: false);

    await commonApi.selfApi(context);
    notifyListeners();
  }

  // Find missing dates between two date ranges based on existing sadhana data
  List<String> findMissingDates(
      String fromDate, String toDate, List<Map<String, dynamic>> sadhanaList) {
    // Generate a list of all dates in the given range
    List<String> allDates = generateDateRange(fromDate, toDate);
    // Extract existing dates from sadhanaList
    List existingDates = sadhanaList.map((entry) => entry['date']).toList();
    // Return dates in allDates that are not present in existingDates
    return allDates.where((date) => !existingDates.contains(date)).toList();
  }

  // Generate a list of dates between a given date range
  List<String> generateDateRange(String fromDate, String toDate) {
    // Parse start and end dates
    DateTime start = DateTime.parse(fromDate);
    DateTime end = DateTime.parse(toDate);

    // Iterate through dates and add them to the date range list
    List<String> dateRange = [];
    for (var d = start;
        d.isBefore(end) || d.isAtSameMomentAs(end);
        d = d.add(const Duration(days: 1))) {
      dateRange.add(d.toIso8601String().split('T')[0]);
    }
    return dateRange;
  }

  List existingDates = [];

  getCalendarScoreData(context) async {
    var newD = DateFormat("yyyy-MM-dd")
        .format(DateTime.now().subtract(const Duration(days: 6)));
    DateTime firstDate =
        dateList.isNotEmpty ? dateList[0] : DateTime.parse(newD);
    DateTime lastDate = dateList.isNotEmpty ? dateList[6] : selectedDate;
    var fromData = DateFormat("yyyy-MM-dd").format(firstDate);
    var toData = DateFormat("yyyy-MM-dd").format(lastDate);

    try {
      Map<String, String> body = {"from_date": fromData, "to_date": toData};

      await apiServices
          .postApi(context, api.getCalendarScore, body, isToken: true)
          .then((value) async {
        for (var scores in value.data['scores']) {
          notifyListeners();
          //developer.log("'dataaaa $scores');

          if (scores['score'] > 0) {
            notifyListeners();
            existingDates.add(scores['date']);
            notifyListeners();
          }
        }
        notifyListeners();
      });
    } catch (e) {
      notifyListeners();
      //developer.log("'error :: $e');
    }
  }

  List<dynamic> getCombinedData() {
    // Filter out local data that has the same 'book_id' as any API data item
    List<dynamic> filteredLocalData = appArray.localBookList.where((localItem) {
      // Check if the local item is not present in the API data

      return !appArray.bookList.any((apiItem) {
        return apiItem['book_id'] == localItem['book_id'];
      });
    }).toList();

    List<dynamic> filteredLocalData2 = checkAndReturnList();

    // //developer.log(""message 11 ${filteredLocalData}");
    // //developer.log(""message 12 ${bookRmtCnfgList}");

    filteredLocalData2.asMap().entries.forEach(
        (element) => print("SS : ${element.value['selected_chapters']}"));

    // Combine the filtered local data with the API data
    appArray.combineList = [...filteredLocalData, ...filteredLocalData2];
    //developer.log(""ndwr : $filteredLocalData2.");
    appArray.combineList.sort((a, b) => a['book_id'].compareTo(b['book_id']));
    return appArray.combineList;
  }

  List<dynamic> checkAndReturnList() {
    List newList = [];
    for (var localItem in bookRmtCnfgList) {
      // print("Local item = $localItem");
      // print("API data = ${appArray.bookList}");

      if (appArray.bookList
          .where((apiItem) => apiItem['book_id'] == localItem['book_id'])
          .isNotEmpty) {
        // If a match is found, return the second list
        int index = appArray.bookList.indexWhere(
            (apiItem) => apiItem['book_id'] == localItem['book_id']);
        if (index >= 0) {
          localItem["selected_chapters"] =
              appArray.bookList[index]['selected_chapters'];
          localItem["reading_time"] = appArray.bookList[index]['reading_time'];
          //developer.log(""localItem :${appArray.bookList[index]}");
          newList.add(localItem);
        }
      }
    }
    return newList;
  }

  // Retrieve data from the Get API for the specified date range
  getData(context, {isTap = false}) async {
    // Set loading state to true
    isLoading = true;
    count++;
    print("Get Data called for $count time");
    print("Tap = $isTap");

    var fromData = DateFormat("yyyy-MM-dd").format(selectedDate);
    var toData = DateFormat("yyyy-MM-dd").format(selectedDate);

    print("from date - $fromData");
    print("from date - $toData");

    //developer.log(""fromData is this  $fromData");
    //developer.log(""toData is this  $toData");
    try {
      Map<String, String> body = {"from_date": fromData, "to_date": toData};
      await apiServices
          .postApi(context, api.getSadhana, body, isToken: true)
          .then((value) async {
        debugPrint("COUNT L$count");
        // Check if request is successful
        if (value.isSuccess!) {
          //
          print("Api Success");
          print(appArray.bookList);
          print(appArray.combineList);

          appArray.bookList.clear();
          appArray.combineList.clear();

          ///
          print(appArray.bookList);

          notifyListeners();
          isCallFun = false;
          Sadhana sadhana = Sadhana.fromJson(value.data);

          // Check if sadhana data is not empty
          if (sadhana.sadhanaData.isNotEmpty) {
            ///
            print("inside sadhana data");

            debugPrint("isTap :$isTap");
            // Iterate through sadhana data
            for (var sadhnaData in value.data['sadhana']) {
              //developer.log(""sadhnaData sadhnaData $sadhnaData");
              // Determine the date to compare based on whether it's a tap event or not
              DateTime dd = isTap ? selectedDate : DateTime.parse(toData);
              // Check if the date matches the selected date or the last date in the range
              if (isTap) {
                for (var book in appArray.bookList) {
                  book['reading_time'] = null;
                  book['selected_chapters'] = [];
                  developer
                      .log("hello ajay how are you ${book['reading_time']}");
                }
                for (var book in appArray.localBookList) {
                  book['reading_time'] = null;
                  book['selected_chapters'] = [];
                  // //developer.log("
                  //     "hello ajay how are you 1111 ${book['reading_time']}");
                }

                for (var book in appArray.combineList) {
                  book['reading_time'] = null;
                  book['selected_chapters'] = [];
                  // //developer.log("
                  //     "hello ajay how are you 1111 ${book['reading_time']}");
                }

                notifyListeners();
                if (DateFormat('dd-MM-yyyy')
                        .format(DateTime.parse(sadhnaData["date"])) ==
                    DateFormat('dd-MM-yyyy').format(dd)) {
                  if (sadhnaData['data']['sleep']['slept_time'] != null) {
                    sleepAt = DateFormat('h:mm a').format(DateFormat('HH:mm')
                        .parse(sadhnaData['data']['sleep']['slept_time']));
                  } else {
                    sleepAt = "";
                  }
                  if (sadhnaData['data']['sleep']['wakeup_time'] != null) {
                    wakeupTime = DateFormat('h:mm a').format(DateFormat('HH:mm')
                        .parse(sadhnaData['data']['sleep']['wakeup_time']));
                  } else {
                    wakeupTime = "";
                  }

                  if (sadhnaData['data']['mangala_arti']['time'] != null) {
                    mangalaArtiTime = DateFormat('h:mm a').format(
                        DateFormat('HH:mm')
                            .parse(sadhnaData['data']['mangala_arti']['time']));
                  } else {
                    mangalaArtiTime = "";
                  }
                  if (sadhnaData['data']['sandhya_arti']['time'] != null) {
                    sandhyaArtiTime = DateFormat('h:mm a').format(
                        DateFormat('HH:mm')
                            .parse(sadhnaData['data']['sandhya_arti']['time']));
                  } else {
                    sandhyaArtiTime = "";
                  }
                  notifyListeners();
                  var regulations = sadhnaData['data']['regulations'];

                  if (sadhnaData['data']['association'] != null) {
                    hearingSpTime24 = sadhnaData['data']['association']
                            ['hearing_sp']
                        .substring(0, 5);

                    // //developer.log("
                    //     "hearingSpTime24 ajay $hearingSpTime24 ${sadhnaData['data']['association']['hearing_sp'].substring(0, 5)}");
                    hearingGuruTime24 = sadhnaData['data']['association']
                            ['hearing_guru']
                        .substring(0, 5);
                    hearingOthersTime24 = sadhnaData['data']['association']
                            ['hearing_others']
                        .substring(0, 5);
                    preachingTime24 = sadhnaData['data']['association']
                            ['preaching']
                        .substring(0, 5);
                    othersActivitiesTime24 = sadhnaData['data']['association']
                            ['other_activities']
                        .substring(0, 5);
                  } else {
                    hearingSpTime24 = '00:00';
                    hearingGuruTime24 = '00:00';
                    hearingOthersTime24 = '00:00';
                    preachingTime24 = '00:00';
                    othersActivitiesTime24 = '00:00';
                  }
                  notifyListeners();
                  notes = sadhnaData['data']['notes'];
                  notesCtrl.text = notes != "" ? notes : "";
                  notifyListeners();
                  smallBookCtrl.text =
                      sadhnaData['data']['book_distribution']['small_books'];
                  mediumBookCtrl.text =
                      sadhnaData['data']['book_distribution']['medium_books'];
                  largeBookCtrl.text =
                      sadhnaData['data']['book_distribution']['big_books'];

                  notifyListeners();
                  List bookData = sadhnaData['data']['book_reading'];

                  notifyListeners();
                  for (int i = 0; i < bookData.length; i++) {
                    Map<String, dynamic> currentBook = bookData[i];
                    //developer.log("'currentBook currentBook $currentBook');
                    notifyListeners();
                    // Check if book_id already exists in appArray.bookList
                    bool isBookIdExist = appArray.bookList.any(
                        (book) => book['book_id'] == currentBook['book_id']);

                    //developer.log("'message current $currentBook');
                    if (!isBookIdExist) {
                      appArray.bookList.add(currentBook);
                    } else {
                      int index = appArray.bookList.indexWhere((apiItem) =>
                          apiItem['book_id'] == currentBook['book_id']);
                      if (index >= 0) {
                        appArray.bookList[index] = currentBook;
                        print(
                            "currentBookcurrentBook1 :${appArray.bookList[index]} || $currentBook");
                      }
                    }
                    //developer.log(""bookRmtCnfgList $bookRmtCnfgList");
                    //developer.log(""bookRmtCnfgList $chosenValue");
                    //developer.log(""appArray.bookList ${appArray.bookList}");
                  }

                  var mangalaData = sadhnaData['data']['mangala_arti'];

                  notifyListeners();
                  chantingList = [
                    {
                      'rounds': sadhnaData['data']['chanting']['slot_1']
                          ['rounds'],
                      'quality': sadhnaData['data']['chanting']['slot_1']
                          ['quality']
                    },
                    {
                      'rounds': sadhnaData['data']['chanting']['slot_2']
                          ['rounds'],
                      'quality': sadhnaData['data']['chanting']['slot_2']
                          ['quality']
                    },
                    {
                      'rounds': sadhnaData['data']['chanting']['slot_3']
                          ['rounds'],
                      'quality': sadhnaData['data']['chanting']['slot_3']
                          ['quality']
                    },
                    {
                      'rounds': sadhnaData['data']['chanting']['slot_4']
                          ['rounds'],
                      'quality': sadhnaData['data']['chanting']['slot_4']
                          ['quality']
                    },
                    {
                      'rounds': sadhnaData['data']['chanting']['slot_5']
                          ['rounds'],
                      'quality': sadhnaData['data']['chanting']['slot_5']
                          ['quality']
                    }
                  ];
                  appArray.rulesList = [
                    {
                      'rule': 'No meat eating',
                      'isOn': regulations['no_meat_eating']
                    },
                    {
                      'rule': 'No intoxication',
                      'isOn': regulations['no_intoxication']
                    },
                    {
                      'rule': 'No illicit sex',
                      'isOn': regulations['no_illicit_sex']
                    },
                    {'rule': 'No gambling', 'isOn': regulations['no_gambling']},
                    {
                      'rule': 'Only prasadam',
                      'isOn': regulations['only_prasadam']
                    }
                  ];
                  appArray.manglaArtiTypeList = [
                    {
                      'artiType': 'Guru Astaka',
                      'isOn': mangalaData['guru_astaka']
                    },
                    {
                      'artiType': 'Narasimha Arti',
                      'isOn': mangalaData['narasimha_arti']
                    },
                    {
                      'artiType': 'Tulasi Arti & Parikrama',
                      'isOn': mangalaData['tulasi_arti']
                    },
                    {'artiType': 'Guru Arti', 'isOn': mangalaData['guru_arti']},
                    {
                      'artiType': 'Bhoga Offering ',
                      'isOn': mangalaData['bhoga_offering']
                    }
                  ];
                  appArray.sandhyaTypeList = [
                    {
                      'artiType': 'Sandhya Arti',
                      'isOn': sadhnaData['data']['sandhya_arti']['sandhya_arti']
                    },
                    {
                      'artiType': 'Narasimha Arti',
                      'isOn': sadhnaData['data']['sandhya_arti']
                          ['narasimha_arti']
                    },
                    {
                      'artiType': 'Bhoga Offering',
                      'isOn': sadhnaData['data']['sandhya_arti']
                          ['bhoga_offering']
                    }
                  ];

                  isLoading = false;
                  notifyListeners();
                  break;
                } else {
                  notifyListeners();
                  sleepAt = "";
                  wakeupTime = "";
                  mangalaArtiTime = "";
                  sandhyaArtiTime = "";
                  hearingSpTime24 = '00:00';
                  hearingGuruTime24 = '00:00';
                  hearingOthersTime24 = '00:00';
                  preachingTime24 = '00:00';
                  othersActivitiesTime24 = '00:00';
                  bookReadingCurrentHour = '00:00';
                  bookReadingCurrentMinute = '00:00';
                  chosenValue = "";
                  notifyListeners();

                  notifyListeners();
                  chantingList = [
                    {'rounds': 0, 'quality': 1},
                    {'rounds': 0, 'quality': 1},
                    {'rounds': 0, 'quality': 1},
                    {'rounds': 0, 'quality': 1},
                    {'rounds': 0, 'quality': 1}
                  ];
                  smallBookCtrl.text = '';
                  mediumBookCtrl.text = '';
                  largeBookCtrl.text = '';
                  notifyListeners();
                  for (int ii = 0; ii < appArray.rulesList.length; ii++) {
                    appArray.rulesList[ii]['isOn'] = false;
                  }
                  notesCtrl.text = "";
                }
                isLoading = false;
                notifyListeners();
              } else {
                notifyListeners();
                if (DateFormat('dd-MM-yyyy')
                        .format(DateTime.parse(sadhnaData["date"])) ==
                    DateFormat('dd-MM-yyyy').format(dd)) {
                  if (sadhnaData['data']['sleep']['slept_time'] != null) {
                    sleepAt = DateFormat('h:mm a').format(DateFormat('HH:mm')
                        .parse(sadhnaData['data']['sleep']['slept_time']));
                  }
                  if (sadhnaData['data']['sleep']['wakeup_time'] != null) {
                    wakeupTime = DateFormat('h:mm a').format(DateFormat('HH:mm')
                        .parse(sadhnaData['data']['sleep']['wakeup_time']));
                  }
                  if (sadhnaData['data']['mangala_arti']['time'] != null) {
                    mangalaArtiTime = DateFormat('h:mm a').format(
                        DateFormat('HH:mm')
                            .parse(sadhnaData['data']['mangala_arti']['time']));
                  }
                  if (sadhnaData['data']['sandhya_arti']['time'] != null) {
                    sandhyaArtiTime = DateFormat('h:mm a').format(
                        DateFormat('HH:mm')
                            .parse(sadhnaData['data']['sandhya_arti']['time']));
                  }
                  notifyListeners();
                  var regulations = sadhnaData['data']['regulations'];

                  if (sadhnaData['data']['association'] != null) {
                    notifyListeners();
                    hearingSpTime24 = sadhnaData['data']['association']
                            ['hearing_sp']
                        .substring(0, 5);
                    //developer.log(""hearingSpTime24 $hearingSpTime24");
                    hearingGuruTime24 = sadhnaData['data']['association']
                            ['hearing_guru']
                        .substring(0, 5);
                    hearingOthersTime24 = sadhnaData['data']['association']
                            ['hearing_others']
                        .substring(0, 5);
                    preachingTime24 = sadhnaData['data']['association']
                            ['preaching']
                        .substring(0, 5);
                    othersActivitiesTime24 = sadhnaData['data']['association']
                            ['other_activities']
                        .substring(0, 5);
                  } else {
                    notifyListeners();
                    hearingSpTime24 = '00:00';
                    hearingGuruTime24 = '00:00';
                    hearingOthersTime24 = '00:00';
                    preachingTime24 = '00:00';
                    othersActivitiesTime24 = '00:00';
                    bookReadingCurrentHour = '00:00';
                    bookReadingCurrentMinute = '00:00';
                    chosenValue = "";
                  }
                  notifyListeners();
                  notes = sadhnaData['data']['notes'];
                  notesCtrl.text = notes != "" ? notes : "";
                  notifyListeners();
                  smallBookCtrl.text =
                      sadhnaData['data']['book_distribution']['small_books'];
                  mediumBookCtrl.text =
                      sadhnaData['data']['book_distribution']['medium_books'];
                  largeBookCtrl.text =
                      sadhnaData['data']['book_distribution']['big_books'];
                  //  appArray.bookList = [];
                  notifyListeners();
                  List bookData = sadhnaData['data']['book_reading'];
//////////////////////////////
                  print("Book data is - \n $bookData");
/////////////////////////////
                  for (int i = 0; i < bookData.length; i++) {
                    Map<String, dynamic> currentBook = bookData[i];
                    notifyListeners();
                    bool isBookIdExist = appArray.bookList.any(
                        (book) => book['book_id'] == currentBook['book_id']);
                    notifyListeners();
                    if (!isBookIdExist) {
                      //developer.log(""LOGGGG 4");
                      appArray.bookList.add(currentBook);
                    } else {
                      int isBookIdExist = appArray.bookList.indexWhere(
                          (book) => book['book_id'] == currentBook['book_id']);
                      if (isBookIdExist >= 0) {
                        print("currentBookcurrentBook : $currentBook");
                      }
                    }
                  }

                  notifyListeners();
                  var mangalaData = sadhnaData['data']['mangala_arti'];

                  notifyListeners();
                  chantingList = [
                    {
                      'rounds': sadhnaData['data']['chanting']['slot_1']
                          ['rounds'],
                      'quality': sadhnaData['data']['chanting']['slot_1']
                          ['quality']
                    },
                    {
                      'rounds': sadhnaData['data']['chanting']['slot_2']
                          ['rounds'],
                      'quality': sadhnaData['data']['chanting']['slot_2']
                          ['quality']
                    },
                    {
                      'rounds': sadhnaData['data']['chanting']['slot_3']
                          ['rounds'],
                      'quality': sadhnaData['data']['chanting']['slot_3']
                          ['quality']
                    },
                    {
                      'rounds': sadhnaData['data']['chanting']['slot_4']
                          ['rounds'],
                      'quality': sadhnaData['data']['chanting']['slot_4']
                          ['quality']
                    },
                    {
                      'rounds': sadhnaData['data']['chanting']['slot_5']
                          ['rounds'],
                      'quality': sadhnaData['data']['chanting']['slot_5']
                          ['quality']
                    }
                  ];
                  appArray.rulesList = [
                    {
                      'rule': 'No meat eating',
                      'isOn': regulations['no_meat_eating']
                    },
                    {
                      'rule': 'No intoxication',
                      'isOn': regulations['no_intoxication']
                    },
                    {
                      'rule': 'No illicit sex',
                      'isOn': regulations['no_illicit_sex']
                    },
                    {'rule': 'No gambling', 'isOn': regulations['no_gambling']},
                    {
                      'rule': 'Only prasadam',
                      'isOn': regulations['only_prasadam']
                    }
                  ];
                  appArray.manglaArtiTypeList = [
                    {
                      'artiType': 'Guru Astaka',
                      'isOn': mangalaData['guru_astaka']
                    },
                    {
                      'artiType': 'Narasimha Arti',
                      'isOn': mangalaData['narasimha_arti']
                    },
                    {
                      'artiType': 'Tulasi Arti & Parikrama',
                      'isOn': mangalaData['tulasi_arti']
                    },
                    {'artiType': 'Guru Arti', 'isOn': mangalaData['guru_arti']},
                    {
                      'artiType': 'Bhoga Offering ',
                      'isOn': mangalaData['bhoga_offering']
                    }
                  ];
                  appArray.sandhyaTypeList = [
                    {
                      'artiType': 'Sandhya Arti',
                      'isOn': sadhnaData['data']['sandhya_arti']['sandhya_arti']
                    },
                    {
                      'artiType': 'Narasimha Arti',
                      'isOn': sadhnaData['data']['sandhya_arti']
                          ['narasimha_arti']
                    },
                    {
                      'artiType': 'Bhoga Offering',
                      'isOn': sadhnaData['data']['sandhya_arti']
                          ['bhoga_offering']
                    }
                  ];
                  isLoading = false;
                  notifyListeners();
                } else {
                  notifyListeners();
                  sleepAt = "";
                  wakeupTime = "";
                  mangalaArtiTime = "";
                  sandhyaArtiTime = "";
                  hearingSpTime24 = '00:00';
                  hearingGuruTime24 = '00:00';
                  hearingOthersTime24 = '00:00';
                  bookReadingCurrentHour = '00:00';
                  bookReadingCurrentMinute = '00:00';
                  chosenValue = "";
                  preachingTime24 = '00:00';
                  othersActivitiesTime24 = '00:00';

                  notifyListeners();

                  notifyListeners();
                  chantingList = [
                    {'rounds': 0, 'quality': 1},
                    {'rounds': 0, 'quality': 1},
                    {'rounds': 0, 'quality': 1},
                    {'rounds': 0, 'quality': 1},
                    {'rounds': 0, 'quality': 1},
                  ];

                  smallBookCtrl.text = '';
                  mediumBookCtrl.text = '';
                  largeBookCtrl.text = '';
                  notifyListeners();
                  for (int ii = 0; ii < appArray.rulesList.length; ii++) {
                    appArray.rulesList[ii]['isOn'] = false;
                  }
                  notesCtrl.text = "";
                }
              }
            }
            isLoading = false;
            notifyListeners();
          } else {
            for (var book in appArray.bookList) {
              book['reading_time'] = null;
              book['selected_chapters'] = [];
            }
            /////
            print("inside else");
            print(appArray.bookList);

            notifyListeners();
            sleepAt = "";
            wakeupTime = "";
            mangalaArtiTime = "";
            sandhyaArtiTime = "";
            hearingSpTime24 = '00:00';
            hearingGuruTime24 = '00:00';
            hearingOthersTime24 = '00:00';
            preachingTime24 = '00:00';
            othersActivitiesTime24 = '00:00';
            bookReadingCurrentHour = '00:00';
            bookReadingCurrentMinute = '00:00';
            chosenValue = "";

            notifyListeners();
            chantingList = [
              {'rounds': 0, 'quality': 1},
              {'rounds': 0, 'quality': 1},
              {'rounds': 0, 'quality': 1},
              {'rounds': 0, 'quality': 1},
              {'rounds': 0, 'quality': 1},
            ];
            notifyListeners();
            smallBookCtrl.text = '';
            mediumBookCtrl.text = '';
            largeBookCtrl.text = '';
            notifyListeners();
            for (int ii = 0; ii < appArray.rulesList.length; ii++) {
              appArray.rulesList[ii]['isOn'] = false;
            }
            notifyListeners();
            notesCtrl.text = "";

            notifyListeners();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(value.message,
                    style: appCss.dmDenseRegular16
                        .textColor(appColor(context).appTheme.black))));
          }
          isLoading = false;
          notifyListeners();
        }
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  bool shouldShowTick = false;

  // Retrieve data from the Post API for the update data
  updateData(context, {getDataIndex}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    notifyListeners();
    isLoading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setLoading(false);
    });
    List bookReadingList = [];

    for (var book in getDataList) {
      bookReadingList.add({
        "book_id": book['book_id'],
        "chapters": book['chapters'],
        "selected_chapters": book['selected_chapters'],
        "reading_time": book['reading_time']
      });
    }

    DateTime? sleepAtDateTime,
        wakeupTimeDateTime,
        mangalaArtiTimeDateTime,
        sandhyaArtiTimeDateTime;

    if (sleepAt != "") {
      sleepAtDateTime = DateFormat('h:mm a').parse(sleepAt);
    }
    if (wakeupTime != "") {
      wakeupTimeDateTime = DateFormat('h:mm a').parse(wakeupTime);
    }
    if (mangalaArtiTime != "") {
      mangalaArtiTimeDateTime = DateFormat('h:mm a').parse(mangalaArtiTime);
    }
    if (sandhyaArtiTime != "") {
      sandhyaArtiTimeDateTime = DateFormat('h:mm a').parse(sandhyaArtiTime);
    }

// Format the DateTime objects in 24-hour format

    String? sleepAt1, wakeupTime1, mangalaArtiTime1, sandhyaArtiTime1;

    if (sleepAtDateTime != null) {
      sleepAt1 = DateFormat('HH:mm:ss').format(sleepAtDateTime);
    }
    if (wakeupTimeDateTime != null) {
      wakeupTime1 = DateFormat('HH:mm:ss').format(wakeupTimeDateTime);
    }
    if (mangalaArtiTimeDateTime != null) {
      mangalaArtiTime1 = DateFormat('HH:mm:ss').format(mangalaArtiTimeDateTime);
    }
    if (sandhyaArtiTimeDateTime != null) {
      sandhyaArtiTime1 = DateFormat('HH:mm:ss').format(sandhyaArtiTimeDateTime);
    }

    var body = {
      "date": DateFormat('yyyy-MM-dd').format(selectedDate),
      "data": {
        "sleep": {"slept_time": sleepAt1, "wakeup_time": wakeupTime1},
        "mangala_arti": {
          "time": mangalaArtiTime1,
          "guru_astaka": appArray.manglaArtiTypeList[0]['isOn'],
          "narasimha_arti": appArray.manglaArtiTypeList[1]['isOn'],
          "tulasi_arti": appArray.manglaArtiTypeList[2]['isOn'],
          "guru_arti": appArray.manglaArtiTypeList[3]['isOn'],
          "bhoga_offering": appArray.manglaArtiTypeList[4]['isOn']
        },
        "sandhya_arti": {
          "time": sandhyaArtiTime1,
          "sandhya_arti": appArray.sandhyaTypeList[0]['isOn'],
          "narasimha_arti": appArray.sandhyaTypeList[1]['isOn'],
          "bhoga_offering": appArray.sandhyaTypeList[2]['isOn']
        },
        "chanting": {
          "slot_1": {
            "rounds": chantingList[0]['rounds'] ?? 0,
            "quality": chantingList[0]['quality'] ?? 1
          },
          "slot_2": {
            "rounds": chantingList[1]['rounds'] ?? 0,
            "quality": chantingList[1]['quality'] ?? 1
          },
          "slot_3": {
            "rounds": chantingList[2]['rounds'] ?? 0,
            "quality": chantingList[2]['quality'] ?? 1
          },
          "slot_4": {
            "rounds": chantingList[3]['rounds'] ?? 0,
            "quality": chantingList[3]['quality'] ?? 1
          },
          "slot_5": {
            "rounds": chantingList[4]['rounds'] ?? 0,
            "quality": chantingList[4]['quality'] ?? 1
          }
        },
        "regulations": {
          "no_meat_eating": appArray.rulesList[0]['isOn'],
          "no_intoxication": appArray.rulesList[1]['isOn'],
          "no_illicit_sex": appArray.rulesList[2]['isOn'],
          "no_gambling": appArray.rulesList[3]['isOn'],
          "only_prasadam": appArray.rulesList[4]['isOn']
        },
        "book_reading": bookReadingList,
        "association": {
          "hearing_sp": hearingSpTime24,
          "hearing_guru": hearingGuruTime24,
          "hearing_others": hearingOthersTime24,
          "preaching": preachingTime24,
          "other_activities": othersActivitiesTime24
        },
        "book_distribution": {
          "small_books": smallBookCtrl.text,
          "medium_books": mediumBookCtrl.text,
          "big_books": largeBookCtrl.text
        },
        "notes": notesCtrl.text
      }
    };

    await apiServices
        .postApi(context, api.sadhanaUpdate, body, isToken: true)
        .then((value) async {
      notifyListeners();
      if (value.isSuccess!) {
        isLoading = false;
        onReadyHome();

        notifyListeners();
      } else {
        isLoading = false;
        hideLoading(context);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(value.message,
                style: appCss.dmDenseRegular16
                    .textColor(appColor(context).appTheme.black))));
      }
    });
  }

  deleteDocDialogOnTap(homeScreenPvr, context) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return DocWidgetLayout().docDeleteDialog(homeScreenPvr, context);
        });
  }

  certificateExpansionTileOnTap(certificationListName, context) {
    drawerCertificationsExpansionList(certificationListName.key, context);
    if (language(context, certificationListName.value['name']) ==
        language(context, appFonts.shraddavan)) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ShraddavanUrl()));
    } else if (language(context, certificationListName.value['name']) ==
        language(context, appFonts.krishnaSevaka)) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const KrishnaSevakaUrl()));
    } else if (language(context, certificationListName.value['name']) ==
        language(context, appFonts.krishnaSadhaka)) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const KrishnaSadhakaUrl()));
    } else if (language(context, certificationListName.value['name']) ==
        language(context, appFonts.srilaPrabhupadaAshraya)) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SrilaPrabhuPadaUrl()));
    } else if (language(context, certificationListName.value['name']) ==
        language(context, appFonts.srilaGuruCaranaAshraya)) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SrilaGuruCaranaUrl()));
    }
  }

  aboutUsExpansionTileOnTap(aboutUsName, context) {
    drawerAboutUsExpansionList(aboutUsName.key);

    if (language(context, aboutUsName.value['name']) ==
        language(context, appFonts.bhaktiSteps)) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const BhaktiStepsUrl()));
    } else if (language(context, aboutUsName.value['name']) ==
        language(context, appFonts.cdm)) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const CDMUrl()));
    } else if (language(context, aboutUsName.value['name']) ==
        language(context, appFonts.aCBhaktiVedantaSwami)) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ACBhaktiVedantaUrl()));
    }
  }
}
