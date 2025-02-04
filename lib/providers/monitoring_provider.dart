import 'dart:developer';
import 'package:bhakti_app/config.dart';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart' as wd;

class MonitoringProvider extends ChangeNotifier {
  int isSelected = 0;
  bool isAllSelected = true;
  int selectedIndex = 0;
  List worshipDataList = [];
  DateTime selectedDate = DateTime.now();
  List sleepDataList = [];
  List bookReadingDataList = [];

  // List of worship items
  List worshipList = [
    "",
    appFonts.mangalaArti,
    appFonts.guruAstaka,
    appFonts.narasimhaArti,
    appFonts.tulasiArti,
    appFonts.guruArti,
    appFonts.bhogaOffering,
    appFonts.sandhyaArtiTime,
    appFonts.sandhyaAarti,
    appFonts.narasimhaArti,
    appFonts.bhogaOffering,
  ];

  // Function for handling calendar date change
  onCalendarDateChange(date, context) {
    selectedDate = date;
    if (isAllSelected) {
      getGroupData(context);
    } else {
      getSingleData(context);
    }
    notifyListeners();
  }

  // Function for handling user selection
  onUserSelection(context, {bool isAllSelected = false, int index = 0}) {
    selectedIndex = index;
    this.isAllSelected = isAllSelected;

    if (isAllSelected) {
      getGroupData(context);
    } else {
      getSingleData(context);
    }
    notifyListeners();
  }

  List sleepListApi = [
    "",
    appFonts.sleepAtApi,
    appFonts.wokeUpAtApi,
    appFonts.durationsApi
  ];
  List worshipApiList = [
    "",
    appFonts.mangalaAartiApi,
    appFonts.guruAstakaApi,
    appFonts.narasimhaArtiApi,
    appFonts.tulasiArtiApi,
    appFonts.guruArtiApi,
    appFonts.bhogaOfferingApi,
    appFonts.sandhyaArtiTimeApi,
    appFonts.sandhyaArtiApi,
    appFonts.sandhyaNarasimhaArtiApi,
    appFonts.sandhyaBhogaOfferingApi
  ];
  List sleepList = [
    "",
    appFonts.sleepAt,
    appFonts.wokeUpAt,
    appFonts.durations
  ];
  List allList = [
    "",
    appFonts.sleepAt,
    appFonts.wokeUpAt,
    appFonts.durations,

    ///
    appFonts.mangalaArti,
    appFonts.guruAstaka,
    appFonts.narasimhaArti,
    appFonts.tulasiArti,
    appFonts.guruArti,
    appFonts.bhogaOffering,
    appFonts.sandhyaArtiTime,
    appFonts.sandhyaAarti,
    appFonts.narasimhaArti,
    appFonts.bhogaOffering,

    ///
    appFonts.total,
    appFonts.before630,
    appFonts.before830,
    appFonts.before10,
    appFonts.before930,
    appFonts.after930,
    //
    appFonts.noMeat,
    appFonts.noIntox,
    appFonts.noIllicit,
    appFonts.noGambling,
    appFonts.onlyPrasadam,
    //
    appFonts.gita,
    appFonts.bhagavatham,
    appFonts.cC,
    appFonts.others,
    appFonts.total,
    //
    appFonts.prabhupada,
    appFonts.guruMaharaja,
    appFonts.others,
    appFonts.preaching,
    appFonts.otherActivities,
    appFonts.totalAssociationTime,
    //
    appFonts.smallBooks,
    appFonts.mediumBooks,
    appFonts.bigBooks,
    //
    appFonts.notes
  ];

  // Function to generate columns for sleep data table
  List<DataColumn> sleepDataColumn(context) {
    return sleepList
        .map((task) => DataColumn(label: Text(language(context, task))))
        .toList();
  }

  String defaultData = "";
  Map<String, dynamic> defaultsMap = {};

  String? profilePictureUrl;

  // Fetches the default profile picture URL from remote config
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
      return appFonts.enterFetchRemote;
    }
  }

  // Function to generate rows for sleep data table
  List<DataRow> sleepDataRow(context, shareWithMeList) {
    return sleepDataList.map((data) {
      return DataRow(
          cells: sleepListApi.map((task) {
            if (task == '') {
              dynamic settingPvr =
              Provider.of<SettingProvider>(context, listen: true);
              int isSameUID = shareWithMeList.indexWhere((element) {
                return element['uid'] == data['uid'];
              });

              return DataCell(onTap: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return CommonMonitoringDialog(
                          data: settingPvr.shareWithMeList[isSameUID]);
                    });
              }, const SizedBox(width: Sizes.s40, height: Sizes.s40));
            } else {
              return DataCell(Center(child: Text(data[task] ?? "-")));
            }
          }).toList());
    }).toList();
  }

  List associationList = [
    "",
    appFonts.prabhupada,
    appFonts.guruMaharaja,
    appFonts.others,
    appFonts.preaching,
    appFonts.otherActivities,
    appFonts.totalAssociationTime,
  ];
  List allDataList = [];
  List allInOneData = [
    "",
    appFonts.sleepAtApi,
    appFonts.wokeUpAtApi,
    appFonts.durationsApi,
    //
    appFonts.mangalaAartiApi,
    appFonts.guruAstakaApi,
    appFonts.narasimhaArtiApi,
    appFonts.tulasiArtiApi,
    appFonts.guruArtiApi,
    appFonts.bhogaOfferingApi,
    appFonts.sandhyaArtiTimeApi,
    appFonts.sandhyaArtiApi,
    appFonts.sandhyaNarasimhaArtiApi,
    appFonts.sandhyaBhogaOfferingApi,
    //

    appFonts.totalChantingApi,
    appFonts.before630Api,
    appFonts.before830Api,
    appFonts.before10Api,
    appFonts.before930Api,
    appFonts.after930Api,
//
    appFonts.noMeatEatingApi,
    appFonts.noIntoxicationApi,
    appFonts.noIllicitSexApi,
    appFonts.noGamblingApi,
    appFonts.onlyPrasadamApi,
    //
    appFonts.gita,
    appFonts.bhagavatham,
    appFonts.cC,
    appFonts.otherApi,
    appFonts.totalBooksApi,
    //
    appFonts.prabhupadaApi,
    appFonts.guruMaharajaApi,
    appFonts.othersApi,
    appFonts.preachingApi,
    appFonts.otherActivitiesApi,
    appFonts.totalAssociationTimeApi,
    //
    appFonts.smallBooksApi,
    appFonts.mediumBooksApi,
    appFonts.bigBooksApi,
    //
    appFonts.notesApi
  ];

  List<DataColumn> allDataColumn(context) {
    return allList
        .map((task) => DataColumn(label: Text(language(context, task))))
        .toList();
  }

  List<DataRow> allDataRow(context, shareWithMeList) {
    return allDataList.map((data) {
      return DataRow(
          cells: allInOneData.map((task) {
            if (task == '') {
              dynamic settingPvr =
              Provider.of<SettingProvider>(context, listen: true);
              int isSameUID = shareWithMeList.indexWhere((element) {
                return element['uid'] == data['uid'];
              });

              return DataCell(onTap: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return CommonMonitoringDialog(
                          data:shareWithMeList[isSameUID]);
                    });
              }, const SizedBox(width: Sizes.s40, height: Sizes.s40));
            } else {
              dynamic value = data[task];
              if (value == null) {
                return const DataCell(Center(child: Text("-")));
              } else if (value.runtimeType == String) {
                return DataCell(Center(child: Text(value)));
              } else if (value == true || value == false) {
                return DataCell(Center(
                  child: value == true
                      ? SvgPicture.asset(eSvgAssets.right)
                      : SvgPicture.asset(eSvgAssets.wrong),
                ));
              } else if (value is int) {
                return DataCell(Center(child: Text(value.toString())));
              } else {
                return DataCell(Center(child: Text(data[task].toString())));
              }
            }
          }).toList());
    }).toList();
  }

  List associationApiList = [
    "",
    appFonts.prabhupadaApi,
    appFonts.guruMaharajaApi,
    appFonts.othersApi,
    appFonts.preachingApi,
    appFonts.otherActivitiesApi,
    appFonts.totalAssociationTimeApi,
  ];

  List bookDistributionList = [
    "",
    appFonts.smallBooks,
    appFonts.mediumBooks,
    appFonts.bigBooks
  ];
  List bookDistributionApiList = [
    "",
    appFonts.smallBooksApi,
    appFonts.mediumBooksApi,
    appFonts.bigBooksApi
  ];
  List bookDistributionDataList = [];

  // Function to generate columns for book distribution data table
  List<DataColumn> bookDistributionDataColumn(context) {
    return bookDistributionList
        .map((task) => DataColumn(label: Text(language(context, task))))
        .toList();
  }

  // Function to generate rows for book distribution data table
  List<DataRow> bookDistributionDataRow(context) {
    return bookDistributionDataList.map((data) {
      return DataRow(
          cells: bookDistributionApiList.map((task) {
            if (task == '') {
              dynamic settingPvr =
              Provider.of<SettingProvider>(context, listen: true);
              int isSameUID = settingPvr.shareWithMeList.indexWhere((element) {
                return element['uid'] == data['uid'];
              });

              return DataCell(onTap: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return CommonMonitoringDialog(
                          data: settingPvr.shareWithMeList[isSameUID]);
                    });
              }, const SizedBox(width: Sizes.s40, height: Sizes.s40));
            } else {
              return DataCell(Center(child: Text(data[task].toString())));
            }
          }).toList());
    }).toList();
  }

  List associationDataList = [];

  // Function to generate columns for association data table
  List<DataColumn> associationDataColumn(context) {
    return associationList
        .map((task) => DataColumn(label: Text(language(context, task))))
        .toList();
  }

  // Function to generate rows for association data table
  List<DataRow> associationDataRow(context) {
    return associationDataList.map((data) {
      return DataRow(
          cells: associationApiList.map((task) {
            if (task == '') {
              dynamic settingPvr =
              Provider.of<SettingProvider>(context, listen: true);
              int isSameUID = settingPvr.shareWithMeList.indexWhere((element) {
                return element['uid'] == data['uid'];
              });

              return DataCell(onTap: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return CommonMonitoringDialog(
                          data: settingPvr.shareWithMeList[isSameUID]);
                    });
              }, const SizedBox(width: Sizes.s40, height: Sizes.s40));
            } else {
              return DataCell(Center(child: Text(data[task].toString())));
            }
          }).toList());
    }).toList();
  }

  // Function to retrieve worship data for a user
  worshipData(context, SettingProvider settingPvr) {
    dynamic userWorshipData = worshipDataList
        .where((element) =>
    element['uid'] == settingPvr.shareWithMeList[selectedIndex]['uid'])
        .toList();
    return userWorshipData;
  }

  // Function to retrieve sleep data for a user
  sleepData(context, SettingProvider settingPvr) {
    dynamic userSleepData = sleepDataList
        .where((element) =>
    element['uid'] == settingPvr.shareWithMeList[selectedIndex]['uid'])
        .toList();
    return userSleepData;
  }

  // Function to retrieve chanting data for a user
  chantingData(context, SettingProvider settingPvr) {
    dynamic userChantingData = chantingDataList
        .where((element) =>
    element['uid'] == settingPvr.shareWithMeList[selectedIndex]['uid'])
        .toList();
    return userChantingData;
  }

  // Function to retrieve regulation data for a user
  regulationData(context, SettingProvider settingPvr) {
    dynamic userRegulationData = regulationsDataList
        .where((element) =>
    element['uid'] == settingPvr.shareWithMeList[selectedIndex]['uid'])
        .toList();
    return userRegulationData;
  }

  // Function to retrieve book read data for a user
  bookReadData(context, SettingProvider settingPvr) {
    dynamic userBookReadData = bookReadingDataList
        .where((element) =>
    element['uid'] == settingPvr.shareWithMeList[selectedIndex]['uid'])
        .toList();
    return userBookReadData;
  }

  // Function to retrieve association data for a user
  associationData(context, SettingProvider settingPvr) {
    dynamic userAssociationData = associationDataList
        .where((element) =>
    element['uid'] == settingPvr.shareWithMeList[selectedIndex]['uid'])
        .toList();
    return userAssociationData;
  }

  // Function to retrieve book distribution data for a user
  bookDistributionData(context, SettingProvider settingPvr) {
    dynamic userBookDistributionData = bookDistributionDataList
        .where((element) =>
    element['uid'] == settingPvr.shareWithMeList[selectedIndex]['uid'])
        .toList();
    return userBookDistributionData;
  }

  // Function to generate columns for chanting data table
  List<DataColumn> chantingDataColumn(context) {
    return chantingList
        .map((task) => DataColumn(label: Text(language(context, task))))
        .toList();
  }

  // Function to generate rows for chanting data table
  List<DataRow> chantingDataRow(context) {
    return chantingDataList.map((data) {
      return DataRow(
          cells: chantingApiList.map((task) {
            if (task == '') {
              dynamic settingPvr =
              Provider.of<SettingProvider>(context, listen: true);
              int isSameUID = settingPvr.shareWithMeList.indexWhere((element) {
                return element['uid'] == data['uid'];
              });

              return DataCell(onTap: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return CommonMonitoringDialog(
                          data: settingPvr.shareWithMeList[isSameUID]);
                    });
              }, const SizedBox(width: Sizes.s40, height: Sizes.s40));
            } else {
              return DataCell(Center(child: Text(data[task].toString())));
            }
          }).toList());
    }).toList();
  }

  // Function to generate columns for worship data table
  List<DataColumn> worshipDataColumn(context) {
    return worshipList
        .map((task) => DataColumn(label: Text(language(context, task))))
        .toList();
  }

  // Function to generate rows for worship data table
  List<DataRow> worshipDataRow(context, shareWithMeList) {
    return worshipDataList.map((data) {
      return DataRow(
          cells: worshipApiList.map((task) {
            if (task == '') {
              dynamic settingPvr =
              Provider.of<SettingProvider>(context, listen: true);
              int isSameUID = settingPvr.shareWithMeList.indexWhere((element) {
                return element['uid'] == data['uid'];
              });
              return DataCell(onTap: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return CommonMonitoringDialog(
                          data: settingPvr.shareWithMeList[isSameUID]);
                    });
              }, const SizedBox(width: Sizes.s40, height: Sizes.s40));
            } else {
              dynamic value = data[task];
              return DataCell(Center(
                  child: value.runtimeType == String || value == null
                      ? Text(value ?? "00:00")
                      : value == true
                      ? SvgPicture.asset(eSvgAssets.right)
                      : SvgPicture.asset(eSvgAssets.wrong)));
            }
          }).toList());
    }).toList();
  }

  // Function to perform initialization
  onInit(context) {
    notifyListeners();
    final settingPvr = Provider.of<SettingProvider>(context, listen: false);
    settingPvr.getShareWithMeData(context);
    getDefaultPic(context);

    notifyListeners();
    if (isAllSelected) {
      getGroupData(context);
    } else {
      getSingleData(context);
    }
    notifyListeners();
  }

  String notes = "";
  List bookReadList = [];
  dynamic isSadhnaDataEmpty = [];
  bool isLoading = false;
  var isHavingData;

  getSingleData(context) async {
    isLoading = true;
    var selectedDateData = DateFormat("yyyy-MM-dd").format(selectedDate);
    try {
      Map<String, String> body = {"date": selectedDateData};
      await apiServices
          .postApi(context, api.getGroupViewData, body, isToken: true)
          .then((value) async {
        if (value.isSuccess!) {
          isHavingData = value.data['sadhana'];
          isLoading = false;
          notifyListeners();
          if (value.data['sadhana'].isNotEmpty) {
            notifyListeners();
            allDataList.clear();
            sleepDataList.clear();
            bookDistributionDataList.clear();
            worshipDataList.clear();
            associationDataList.clear();
            bookReadingDataList.clear();
            chantingDataList.clear();
            notesDataList.clear();
            regulationsDataList.clear();
            bookReadList.clear();
            isSadhnaDataEmpty = [];
            notifyListeners();

            for (var sadhnaData in value.data['sadhana']) {
              // settingPvr
              //     .shareWithMeList[userDataIndex]['uid']
              // final sfUID = pref.getString(session.id);
              String uid = sadhnaData['uid'] ?? "";

              // if (sfUID != uid) {
              isSadhnaDataEmpty = sadhnaData;
              String? sleepTime12, wakeUpTime12, durationTime;
              dynamic sleepTime = sadhnaData['data']['sleep'];
              if (sleepTime['slept_time'] != null) {
                sleepTime12 = DateFormat('h:mm a')
                    .format(DateFormat('HH:mm').parse(sleepTime['slept_time']));
              }
              if (sleepTime['wakeup_time'] != null) {
                wakeUpTime12 = DateFormat('h:mm a').format(
                    DateFormat('HH:mm').parse(sleepTime['wakeup_time']));
              }
              dynamic sandhyaArtiTime =
              sadhnaData['data']['sandhya_arti']['time'];
              bool sandhyaArti =
              sadhnaData['data']['sandhya_arti']['sandhya_arti'];
              bool sNarasimhaArti =
              sadhnaData['data']['sandhya_arti']['narasimha_arti'];
              bool sBhogaOffering =
              sadhnaData['data']['sandhya_arti']['bhoga_offering'];
              dynamic mangalaTime = sadhnaData['data']['mangala_arti']['time'];
              dynamic chanting = sadhnaData['data']['chanting'];
              dynamic association = sadhnaData['data']['association'];
              dynamic bookDistribution =
              sadhnaData['data']['book_distribution'];
              dynamic notesData = sadhnaData['data']['notes'];
              dynamic bookReadingSummary =
              sadhnaData['data']['book_reading_summary'];
              dynamic totalReadingTime = sadhnaData['data']
              ['book_reading_summary']['total_reading_time'];
              List<String>? timeComponents;
              String? durationString;
              if (sleepTime['duration'] != null) {
                durationTime = sleepTime["duration"];
                timeComponents = durationTime!.split(':');
                int hours = int.parse(timeComponents[0]);
                int minutes = int.parse(timeComponents[1]);
                Duration duration = Duration(hours: hours, minutes: minutes);
                if (duration.inMinutes.remainder(60) == 0) {
                  durationString = '${duration.inHours}h';
                } else {
                  durationString =
                  '${duration.inHours}h ${duration.inMinutes.remainder(60)}m';
                }
              }

              if (!sleepDataList.any((element) => element['uid'] == uid)) {
                sleepDataList.add({
                  "uid": uid,
                  "Sleep at": sleepTime12 ?? "-",
                  "Woke up at": wakeUpTime12 ?? "-",
                  "Duration": durationString ?? "-"
                });
              }

              log('sleepDataList 12345 $sleepDataList');
              if (!bookDistributionDataList
                  .any((element) => element['uid'] == uid)) {
                bookDistributionDataList.add({
                  "uid": uid,
                  "Small Books": bookDistribution['small_books'] ?? "-",
                  "Medium Books": bookDistribution['medium_books'] ?? "-",
                  "Big Books": bookDistribution['big_books'] ?? "-"
                });
              }
              log('bookDistributionDataList 12345 $bookDistributionDataList');

              if (!bookReadingDataList
                  .any((element) => element['uid'] == uid)) {
                bookReadingDataList.add({
                  "uid": uid,
                  "Gita": bookReadingSummary['bhagavad_gita'] ?? "-",
                  "Bhagavatham": bookReadingSummary['bhagavatham'] ?? "-",
                  "CC": bookReadingSummary['caitanya_caritamrita'] ?? "-",
                  "Others": bookReadingSummary['others'] ?? "-",
                  "Total": totalReadingTime ?? "-"
                });
              }
              log('bookReadingDataList 12345 $bookReadingDataList');

              notesDataList.add({
                "uid": uid,
                "Notes": notesData != ""
                    ? notesData
                    : language(context, appFonts.noNotes)
              });

              log('notesDataList 12345 $notesDataList');

              String? mangalaTime12, sandhyaArtiTime12;
              if (mangalaTime != null) {
                mangalaTime12 = DateFormat('h:mm a')
                    .format(DateFormat('HH:mm').parse(mangalaTime));
              }
              if (sandhyaArtiTime != null) {
                sandhyaArtiTime12 = DateFormat('h:mm a')
                    .format(DateFormat('HH:mm').parse(sandhyaArtiTime));
              }

              bool guruAstaka =
              sadhnaData['data']['mangala_arti']['guru_astaka'];
              bool mNarasimhaArti =
              sadhnaData['data']['mangala_arti']['narasimha_arti'];
              bool tulasiArti =
              sadhnaData['data']['mangala_arti']['tulasi_arti'];
              bool guruArti = sadhnaData['data']['mangala_arti']['guru_arti'];
              bool mBhogaOffering =
              sadhnaData['data']['mangala_arti']['bhoga_offering'];

              final settingProvider =
              Provider.of<SettingProvider>(context, listen: false);

              for (var d in settingProvider.shareWithMeList) {
                log("message message d $d");
                if (!allDataList.any((element) => element['uid'] == uid)) {
                  allDataList.add({
                    "uid": uid,
                    "Sleep at": sleepTime12 ?? "-",
                    "Woke up at": wakeUpTime12 ?? "-",
                    "Duration": durationString ?? "-",
                    "Mangala Aarti": mangalaTime12 ?? "-",
                    "Guru Astaka": guruAstaka,
                    "Narasimha Arti": mNarasimhaArti,
                    "Tulasi Arti": tulasiArti,
                    "Guru Arti": guruArti,
                    "Bhoga Offering": mBhogaOffering,
                    "Sandhya Arti Time": sandhyaArtiTime12 ?? "-",
                    "Sandhya Arti": sandhyaArti,
                    "Sandhya Narasimha Arti": sNarasimhaArti,
                    "Sandhya Bhoga Offering": sBhogaOffering,
                    "Total": chanting['total'] ?? "-",
                    'Before 6:30 am': chanting['slot_1']['rounds'] ?? "-",
                    'Before 8:30 am': chanting['slot_2']['rounds'] ?? "-",
                    'Before 10 am': chanting['slot_3']['rounds'] ?? "-",
                    'Before 9:30 pm': chanting['slot_4']['rounds'] ?? "-",
                    'After 9:30 pm': chanting['slot_5']['rounds'] ?? "-",
                    "No Meat Eating": sadhnaData['data']['regulations']
                    ['no_meat_eating'] ??
                        "-",
                    "No Intoxication": sadhnaData['data']['regulations']
                    ['no_intoxication'] ??
                        "-",
                    "No Illicit Sex": sadhnaData['data']['regulations']
                    ['no_illicit_sex'] ??
                        "-",
                    "No Gambling":
                    sadhnaData['data']['regulations']['no_gambling'] ?? "-",
                    "Only Prasadam": sadhnaData['data']['regulations']
                    ['only_prasadam'] ??
                        "-",
                    "Gita": bookReadingSummary['bhagavad_gita'] ?? "-",
                    "Bhagavatham": bookReadingSummary['bhagavatham'] ?? "-",
                    "CC": bookReadingSummary['caitanya_caritamrita'] ?? "-",
                    "Others": bookReadingSummary['others'] ?? "-",
                    "Total": totalReadingTime ?? "-",
                    "Prabhupada": association['hearing_sp'] ?? "-",
                    "Guru Maharaja": association['hearing_guru'] ?? "-",
                    "Others": association['hearing_others'] ?? "-",
                    "Preaching": association['preaching'] ?? "-",
                    "Other Activities": association['other_activities'] ?? "-",
                    "Total Association Time":
                    association['total_association_time'] ?? "-",
                    "Small Books": bookDistribution['small_books'] ?? 0,
                    "Medium Books": bookDistribution['medium_books'] ?? 0,
                    "Big Books": bookDistribution['big_books'] ?? 0,
                    "Notes": notesData != ""
                        ? notesData
                        : language(context, appFonts.noNotes)
                  });
                  log("allDataList allDataList allDataList $allDataList");
                }
              }

              log('allDataList 12345 $allDataList');
              if (!worshipDataList.any((element) => element['uid'] == uid)) {
                worshipDataList.add({
                  "uid": uid,
                  "Mangala Aarti": mangalaTime12 ?? "-",
                  "Guru Astaka": guruAstaka,
                  "Narasimha Arti": mNarasimhaArti,
                  "Tulasi Arti": tulasiArti,
                  "Guru Arti": guruArti,
                  "Bhoga Offering": mBhogaOffering,
                  "Sandhya Arti Time": sandhyaArtiTime12 ?? "-",
                  "Sandhya Arti": sandhyaArti,
                  "Sandhya Narasimha Arti": sNarasimhaArti,
                  "Sandhya Bhoga Offering": sBhogaOffering
                });
              }
              log('worshipDataList 12345 $worshipDataList');

              if (!associationDataList
                  .any((element) => element['uid'] == uid)) {
                associationDataList.add({
                  "uid": uid,
                  "Prabhupada": association['hearing_sp'] ?? "-",
                  "Guru Maharaja": association['hearing_guru'] ?? "-",
                  "Others": association['hearing_others'] ?? "-",
                  "Preaching": association['preaching'] ?? "-",
                  "Other Activities": association['other_activities'] ?? "-",
                  "Total Association Time":
                  association['total_association_time'] ?? "-"
                });
              }
              log('associationDataList 12345 $associationDataList');
              if (!chantingDataList.any((element) => element['uid'] == uid)) {
                chantingDataList.add({
                  "uid": uid,
                  "Total": chanting['total'] ?? "-",
                  'Before 6:30 am': chanting['slot_1']['rounds'] ?? "-",
                  'Before 8:30 am': chanting['slot_2']['rounds'] ?? "-",
                  'Before 10 am': chanting['slot_3']['rounds'] ?? "-",
                  'Before 9:30 pm': chanting['slot_4']['rounds'] ?? "-",
                  'After 9:30 pm': chanting['slot_5']['rounds'] ?? "-"
                });
              }
              log('chantingDataList 12345 $chantingDataList');

              if (!regulationsDataList
                  .any((element) => element['uid'] == uid)) {
                regulationsDataList.add({
                  "uid": uid,
                  "No Meat Eating": sadhnaData['data']['regulations']
                  ['no_meat_eating'] ??
                      "-",
                  "No Intoxication": sadhnaData['data']['regulations']
                  ['no_intoxication'] ??
                      "-",
                  "No Illicit Sex": sadhnaData['data']['regulations']
                  ['no_illicit_sex'] ??
                      "-",
                  "No Gambling":
                  sadhnaData['data']['regulations']['no_gambling'] ?? "-",
                  "Only Prasadam":
                  sadhnaData['data']['regulations']['only_prasadam'] ?? "-"
                });
              }
            }

            notifyListeners();
          } else {
            isLoading = false;
            isSadhnaDataEmpty = [];
            notifyListeners();

            final settingPvr =
            Provider.of<SettingProvider>(context, listen: false);

            allDataList = [];

            sleepDataList = [];
            bookDistributionDataList = [];
            worshipDataList = [];
            associationDataList = [];
            bookReadingDataList = [];
            chantingDataList = [];
            notesDataList = [];
            regulationsDataList = [];
            bookReadList = [];

            for (int i = 0; i < settingPvr.shareWithMeList.length; i++) {
              allDataList.add({
                "uid": settingPvr.shareWithMeList[i]['uid'],
                "Sleep at": "-",
                "Woke up at": "-",
                "Duration": "-",
                "Small Books": 0,
                "Medium Books": 0,
                "Big Books": 0,
                "Mangala Aarti": "-",
                "Guru Astaka": false,
                "Narasimha Arti": false,
                "Tulasi Arti": false,
                "Guru Arti": false,
                "Bhoga Offering": false,
                "Sandhya Arti Time": "-",
                "Sandhya Arti": false,
                "Sandhya Narasimha Arti": false,
                "Sandhya Bhoga Offering": false,
                "Prabhupada": "-",
                "Guru Maharaja": "-",
                "Others": "-",
                "Preaching": "-",
                "Other Activities": "-",
                "Total Association Time": "-",
                "Notes": language(context, appFonts.noNotes),
                "Total": 0,
                'Before 6:30 am': 0,
                'Before 8:30 am': 0,
                'Before 10 am': 0,
                'Before 9:30 pm': 0,
                'After 9:30 pm': 0,
                "No Meat Eating": false,
                "No Intoxication": false,
                "No Illicit Sex": false,
                "No Gambling": false,
                "Only Prasadam": false,
                "Gita": "-",
                "Bhagavatham": "-",
                "CC": "-",
                "Others": "-",
                "Total": "-",
              });
            }

            bookReadList = [];

            notifyListeners();
          }
        }
      });
    } catch (e) {
      isLoading = false;
    }
  }

  // Asynchronous function to fetch group data for the selected date
  getGroupData(context) async {
    isLoading = true;
    var selectedDateData = DateFormat("yyyy-MM-dd").format(selectedDate);
    try {
      Map<String, String> body = {"date": selectedDateData};
      await apiServices
          .postApi(context, api.getGroupViewData, body, isToken: true)
          .then((value) async {
        if (value.isSuccess!) {
          isLoading = false;
          allDataList.clear();
          sleepDataList.clear();
          bookDistributionDataList.clear();
          worshipDataList.clear();
          associationDataList.clear();
          bookReadingDataList.clear();
          chantingDataList.clear();
          notesDataList.clear();
          regulationsDataList.clear();

          isSadhnaDataEmpty = [];
          if (value.data['sadhana'].isNotEmpty) {
            final settingProvider =
            Provider.of<SettingProvider>(context, listen: false);

            for (var sadhnaData in value.data['sadhana']) {
              String uid = sadhnaData['uid'] ?? "";

              String? sleepTime12, wakeUpTime12, durationTime;
              dynamic sleepTime = sadhnaData['data']['sleep'];
              if (sleepTime['slept_time'] != null) {
                sleepTime12 = DateFormat('h:mm a')
                    .format(DateFormat('HH:mm').parse(sleepTime['slept_time']));
                log("ssssssssss $sleepTime12");
              }
              if (sleepTime['wakeup_time'] != null) {
                wakeUpTime12 = DateFormat('h:mm a').format(
                    DateFormat('HH:mm').parse(sleepTime['wakeup_time']));
              }
              List<String>? timeComponents;
              String? durationString;
              if (sleepTime['duration'] != null) {
                durationTime = sleepTime["duration"];
                timeComponents = durationTime!.split(':');
                int hours = int.parse(timeComponents[0]);
                int minutes = int.parse(timeComponents[1]);
                Duration duration = Duration(hours: hours, minutes: minutes);
                if (duration.inMinutes.remainder(60) == 0) {
                  durationString = '${duration.inHours}h';
                } else {
                  durationString =
                  '${duration.inHours}h ${duration.inMinutes.remainder(60)}m';
                }
              }

              String? mangalaTime12, sandhyaArtiTime12;
              dynamic mangalaTime = sadhnaData['data']['mangala_arti']['time'];
              if (mangalaTime != null) {
                mangalaTime12 = DateFormat('h:mm a')
                    .format(DateFormat('HH:mm').parse(mangalaTime));
              }
              dynamic sandhyaArtiTime =
              sadhnaData['data']['sandhya_arti']['time'];
              if (sandhyaArtiTime != null) {
                sandhyaArtiTime12 = DateFormat('h:mm a')
                    .format(DateFormat('HH:mm').parse(sandhyaArtiTime));
              }

              bool guruAstaka =
              sadhnaData['data']['mangala_arti']['guru_astaka'];
              bool mNarasimhaArti =
              sadhnaData['data']['mangala_arti']['narasimha_arti'];
              bool tulasiArti =
              sadhnaData['data']['mangala_arti']['tulasi_arti'];
              bool guruArti = sadhnaData['data']['mangala_arti']['guru_arti'];
              bool mBhogaOffering =
              sadhnaData['data']['mangala_arti']['bhoga_offering'];

              bool sandhyaArti =
              sadhnaData['data']['sandhya_arti']['sandhya_arti'];
              bool sNarasimhaArti =
              sadhnaData['data']['sandhya_arti']['narasimha_arti'];
              bool sBhogaOffering =
              sadhnaData['data']['sandhya_arti']['bhoga_offering'];
              dynamic chanting = sadhnaData['data']['chanting'];
              dynamic association = sadhnaData['data']['association'];
              dynamic bookDistribution =
              sadhnaData['data']['book_distribution'];
              dynamic notesData = sadhnaData['data']['notes'];
              dynamic bookReadingSummary =
              sadhnaData['data']['book_reading_summary'];
              dynamic totalReadingTime = sadhnaData['data']
              ['book_reading_summary']['total_reading_time'];
              // Populate data in the list for the user with data
              log("sleepTime12sleepTime12 $sleepTime12");
              allDataList.add({
                "uid": uid,
                "Sleep at": sleepTime12 ?? "-",
                "Woke up at": wakeUpTime12 ?? "-",
                "Duration": durationString ?? "-",
                "Mangala Aarti": mangalaTime12 ?? "-",
                "Guru Astaka": guruAstaka,
                "Narasimha Arti": mNarasimhaArti,
                "Tulasi Arti": tulasiArti,
                "Guru Arti": guruArti,
                "Bhoga Offering": mBhogaOffering,
                "Sandhya Arti Time": sandhyaArtiTime12 ?? "-",
                "Sandhya Arti": sandhyaArti,
                "Sandhya Narasimha Arti": sNarasimhaArti,
                "Sandhya Bhoga Offering": sBhogaOffering,
                "Total": chanting['total'] ?? "-",
                'Before 6:30 am': chanting['slot_1']['rounds'] ?? "-",
                'Before 8:30 am': chanting['slot_2']['rounds'] ?? "-",
                'Before 10 am': chanting['slot_3']['rounds'] ?? "-",
                'Before 9:30 pm': chanting['slot_4']['rounds'] ?? "-",
                'After 9:30 pm': chanting['slot_5']['rounds'] ?? "-",
                "No Meat Eating":
                sadhnaData['data']['regulations']['no_meat_eating'] ?? "-",
                "No Intoxication":
                sadhnaData['data']['regulations']['no_intoxication'] ?? "-",
                "No Illicit Sex":
                sadhnaData['data']['regulations']['no_illicit_sex'] ?? "-",
                "No Gambling":
                sadhnaData['data']['regulations']['no_gambling'] ?? "-",
                "Only Prasadam":
                sadhnaData['data']['regulations']['only_prasadam'] ?? "-",
                "Gita": bookReadingSummary['bhagavad_gita'] ?? "-",
                "Bhagavatham": bookReadingSummary['bhagavatham'] ?? "-",
                "CC": bookReadingSummary['caitanya_caritamrita'] ?? "-",
                "Others": bookReadingSummary['others'] ?? "-",
                "total_reading_time": totalReadingTime ?? "-",
                "Prabhupada": association['hearing_sp'] ?? "-",
                "Guru Maharaja": association['hearing_guru'] ?? "-",
                "Others": association['hearing_others'] ?? "-",
                "Preaching": association['preaching'] ?? "-",
                "Other Activities": association['other_activities'] ?? "-",
                "Total Association Time":
                association['total_association_time'] ?? "-",
                "Small Books": bookDistribution['small_books'] ?? 0,
                "Medium Books": bookDistribution['medium_books'] ?? 0,
                "Big Books": bookDistribution['big_books'] ?? 0,
                "Notes": notesData != ""
                    ? notesData
                    : language(context, appFonts.noNotes)
              });
            }

            // Check for users who have no data and add them with blank/default values
            for (var shareWithMeData in settingProvider.shareWithMeList) {
              String uid = shareWithMeData['uid'];
              if (!allDataList.any((element) => element['uid'] == uid)) {
                allDataList.add({
                  "uid": uid,
                  "Sleep at": "-",
                  "Woke up at": "-",
                  "Duration": "-",
                  "Mangala Aarti": "-",
                  "Guru Astaka": false,
                  "Narasimha Arti": false,
                  "Tulasi Arti": false,
                  "Guru Arti": false,
                  "Bhoga Offering": false,
                  "Sandhya Arti Time": "-",
                  "Sandhya Arti": false,
                  "Sandhya Narasimha Arti": false,
                  "Sandhya Bhoga Offering": false,
                  "Total": "-",
                  'Before 6:30 am': 0,
                  'Before 8:30 am': 0,
                  'Before 10 am': 0,
                  'Before 9:30 pm': 0,
                  'After 9:30 pm': 0,
                  "No Meat Eating": false,
                  "No Intoxication": false,
                  "No Illicit Sex": false,
                  "No Gambling": false,
                  "Only Prasadam": false,
                  "Gita": "-",
                  "Bhagavatham": "-",
                  "CC": "-",
                  "Others": "-",
                  "Total Reading Time": "-",
                  "Prabhupada": "-",
                  "Guru Maharaja": "-",
                  "Others": "-",
                  "Preaching": "-",
                  "Other Activities": "-",
                  "Total Association Time": "-",
                  "Small Books": 0,
                  "Medium Books": 0,
                  "Big Books": 0,
                  "Notes": language(context, appFonts.noNotes)
                });
              }
              log("allDataList $allDataList");
            }
            notifyListeners();
          } else {
            isLoading = false;
            isSadhnaDataEmpty = [];
            notifyListeners();

            final settingPvr =
            Provider.of<SettingProvider>(context, listen: false);

            allDataList = [];

            sleepDataList = [];
            bookDistributionDataList = [];
            worshipDataList = [];
            associationDataList = [];
            bookReadingDataList = [];
            chantingDataList = [];
            notesDataList = [];
            regulationsDataList = [];

            log("allDataList allDataList $allDataList");
            for (int i = 0; i < settingPvr.shareWithMeList.length; i++) {
              allDataList.add({
                "uid": settingPvr.shareWithMeList[i]['uid'],
                "Sleep at": "-",
                "Woke up at": "-",
                "Duration": "-",
                "Small Books": 0,
                "Medium Books": 0,
                "Big Books": 0,
                "Mangala Aarti": "-",
                "Guru Astaka": false,
                "Narasimha Arti": false,
                "Tulasi Arti": false,
                "Guru Arti": false,
                "Bhoga Offering": false,
                "Sandhya Arti Time": "-",
                "Sandhya Arti": false,
                "Sandhya Narasimha Arti": false,
                "Sandhya Bhoga Offering": false,
                "Prabhupada": "-",
                "Guru Maharaja": "-",
                "Others": "-",
                "Preaching": "-",
                "Other Activities": "-",
                "Total Association Time": "-",
                "Notes": language(context, appFonts.noNotes),
                "Total": 0,
                'Before 6:30 am': 0,
                'Before 8:30 am': 0,
                'Before 10 am': 0,
                'Before 9:30 pm': 0,
                'After 9:30 pm': 0,
                "No Meat Eating": false,
                "No Intoxication": false,
                "No Illicit Sex": false,
                "No Gambling": false,
                "Only Prasadam": false,
                "Gita": "-",
                "Bhagavatham": "-",
                "CC": "-",
                "Others": "-",
                "Total": "-",
              });

              log("allDataList 11113333 $allDataList");
            }

            notifyListeners();
          }
        }
      });
    } catch (e) {
      notifyListeners();
      isLoading = false;
      notifyListeners();
    }
  }

  List userToDo = [
    appFonts.sleep,
    appFonts.worship,
    appFonts.chanting,
    appFonts.regulations,
    appFonts.books,
    appFonts.association,
    appFonts.bookDistribution,
    appFonts.notes
  ];

  List chantingList = [
    "",
    appFonts.total,
    appFonts.before630,
    appFonts.before830,
    appFonts.before10,
    appFonts.before930,
    appFonts.after930
  ];
  List chantingApiList = [
    "",
    appFonts.totalChantingApi,
    appFonts.before630Api,
    appFonts.before830Api,
    appFonts.before10Api,
    appFonts.before930Api,
    appFonts.after930Api,
  ];

  List regulationsList = [
    "",
    appFonts.noMeat,
    appFonts.noIntox,
    appFonts.noIllicit,
    appFonts.noGambling,
    appFonts.onlyPrasadam,
  ];

  List regulationsApiList = [
    "",
    appFonts.noMeatEatingApi,
    appFonts.noIntoxicationApi,
    appFonts.noIllicitSexApi,
    appFonts.noGamblingApi,
    appFonts.onlyPrasadamApi
  ];

  List regulationsDataList = [];

  // Defines a list of DataColumn widgets for displaying regulations data.
  List<DataColumn> regulationsDataColumn(context) {
    return regulationsList
        .map((task) => DataColumn(label: Text(language(context, task))))
        .toList();
  }

  // Defines a list of DataRow widgets for displaying regulations data.
  List<DataRow> regulationsDataRow(context) {
    return regulationsDataList.map((data) {
      return DataRow(
          cells: regulationsApiList.map((task) {
            if (task == '') {
              dynamic settingPvr =
              Provider.of<SettingProvider>(context, listen: true);
              int isSameUID = settingPvr.shareWithMeList.indexWhere((element) {
                return element['uid'] == data['uid'];
              });

              return DataCell(onTap: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return CommonMonitoringDialog(
                          data: settingPvr.shareWithMeList[isSameUID]);
                    });
              }, const SizedBox(width: Sizes.s40, height: Sizes.s40));
            } else {
              return DataCell(Center(
                  child: data[task] == true
                      ? SvgPicture.asset(eSvgAssets.right)
                      : SvgPicture.asset(eSvgAssets.wrong)));
            }
          }).toList());
    }).toList();
  }

  // Controls the tab navigation, switching to the specified tab index.
  tabControl(context) {
    final bottomNavPvr = Provider.of<BottomNavProvider>(context, listen: false);
    bottomNavPvr.onTapTab(0);
    notifyListeners();
  }

  List notesList = ["", appFonts.notes];
  List notesApiList = ["", appFonts.notesApi];
  List bookReadingList = [
    "",
    appFonts.gita,
    appFonts.bhagavatham,
    appFonts.cC,
    appFonts.others,
    appFonts.total
  ];

  List bookReadingApiList = [
    "",
    appFonts.gita,
    appFonts.bhagavatham,
    appFonts.cC,
    appFonts.otherApi,
    appFonts.totalBooksApi
  ];

  List chantingDataList = [];

  List notesDataList = [];

  // Generates a list of DataColumn widgets for displaying notes data.
  List<DataColumn> notesDataColumn(context) {
    return notesList
        .map((task) => DataColumn(
        label: Text(language(context, task), textAlign: TextAlign.center)))
        .toList();
  }

  // Generates a list of DataRow widgets for displaying notes data.
  List<DataRow> notesDataRow(context) {
    return notesDataList.map((data) {
      return DataRow(
          cells: notesApiList.map((task) {
            if (task == '') {
              dynamic settingPvr =
              Provider.of<SettingProvider>(context, listen: true);
              int isSameUID = settingPvr.shareWithMeList.indexWhere((element) {
                return element['uid'] == data['uid'];
              });
              return DataCell(onTap: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return CommonMonitoringDialog(
                          data: settingPvr.shareWithMeList[isSameUID]);
                    });
              }, const SizedBox(width: Sizes.s40, height: Sizes.s40));
            } else {
              return DataCell(SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(data[task])));
            }
          }).toList());
    }).toList();
  }

  // int selectedTabIndex = 0;
  ScrollController scrollController = ScrollController();

  List<List<int>> calculateUserToDoRanges() {
    return [
      [0], // sleep
      [4], // worship
      [14], // association
      [20], // regulations
      [25], // books
      [30], // chanting
      [36], // book distribution
      [39], // notes
    ];
  }

  void scrollToRange(int startIndex, BuildContext context, int index, List<double> columnWidths) {
    isSelected = index;
    notifyListeners();

    // Define the width of each item (adjust this value as needed).
    // const double itemWidth = 100.0; // Example fixed width per item.
    double offset = 24.0;
    for(int i=0;i<startIndex;i++){
      offset += (columnWidths[i] + 24.0);
      // print("col width = ${columnWidths[i]}");
      // print(offset);
      print(i);
    }
    // Calculate the scroll position.
    double scrollPosition = offset;
    // double scrollPosition = startIndex * 150;
    print(scrollPosition);

    scrollController.animateTo(
      scrollPosition,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  List<double> getColumnWidths(List<DataColumn> columns) {
    final List<double> columnWidths = [];

    for (var column in columns) {
      // print((column.label as Text).data ?? '');
      final textPainter = TextPainter(
        text: TextSpan(text: (column.label as Text).data ?? '', style: appCss.dmDenseSemiBold16),
        textDirection: wd.TextDirection.ltr,
      )..layout();
      // print("width ${textPainter.width}");

      // Track the max width of the column
      // maxWidth = textPainter.width == 0.0 ? maxWidth : 0.0;

      // Convert the width to an integer and store it in the result list
      columnWidths.add(textPainter.width);
    }
    // print(columnWidths);

    return columnWidths;
  }


}