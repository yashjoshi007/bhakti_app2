import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../config.dart';

class DashboardProvider extends ChangeNotifier {
  String displayUid = "";
  DashboardWidget dashboardWidget = DashboardWidget();
  bool isLoading = false;
  int selectedIndex = 0;
  List<String> names = [];
  DateTime? selectedDay;
  bool onChange = false;
  DateTime focusedDay = DateTime.now();
  DateTime fromDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime toDate = DateTime.now();
  DateFormat dateFormat = DateFormat('d MMM yy');
  bool isSelected = false;
  bool isSingleUserSelected = false;
  String selectedUID = "";
  final userDataIndex = 0;
  CalendarFormat calendarFormat = CalendarFormat.month;
  String? endedRange;
  String? startedRange;
  String? profilePictureUrl;
  TooltipBehavior? tooltipBehavior;
  List<DateTime> dateList = [];
  DateTime selectedDate = DateTime.now();
  List<ChartData> chartData = [];
  List<SalesData> salesData = [];
  List<ChartsData> sleepChartData = [];
  bool _isButtonDisabled = false;

  bool get isButtonDisabled => _isButtonDisabled;

  set isButtonDisabled(bool value) {
    _isButtonDisabled = value;
    notifyListeners();
  }

  tabControl(context) {
    final bottomNavPvr = Provider.of<BottomNavProvider>(context, listen: false);
    bottomNavPvr.onTapTab(0);
    notifyListeners();
  }

  onFormatChanged(format) {
    if (calendarFormat != format) {
      calendarFormat = format;
    }
  }

  onDaySelected() {
    selectedDay = selectedDay;
    focusedDay = focusedDay;
    notifyListeners();
  }

  onExpansionChanged() {
    onChange = !onChange;
    notifyListeners();
  }

  fromDateOnTap(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.r10)),
              content: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(language(context, appFonts.selectFromDate),
                            style: const TextStyle(
                                fontSize: Sizes.s18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: Insets.i10),
                        SfDateRangePicker(
                            confirmText: language(context, appFonts.ok),
                            cancelText: language(context, appFonts.cancel),
                            controller: fromDatePickerController,
                            initialSelectedDate: fromDate,
                            selectionColor: appColor(context)
                                .appTheme
                                .primary
                                .withOpacity(0.2),
                            endRangeSelectionColor: Colors.black,
                            yearCellStyle: DateRangePickerYearCellStyle(
                                textStyle: const TextStyle(color: Colors.black),
                                cellDecoration:
                                    const BoxDecoration(color: Colors.white),
                                disabledDatesDecoration:
                                    const BoxDecoration(color: Colors.white),
                                disabledDatesTextStyle:
                                    const TextStyle(color: Colors.grey),
                                leadingDatesDecoration:
                                    const BoxDecoration(color: Colors.white),
                                leadingDatesTextStyle:
                                    const TextStyle(color: Colors.black),
                                todayCellDecoration: BoxDecoration(
                                    color: appColor(context)
                                        .appTheme
                                        .primary
                                        .withOpacity(0.4)),
                                todayTextStyle:
                                    const TextStyle(color: Colors.white)),
                            backgroundColor: Colors.white,
                            monthCellStyle: const DateRangePickerMonthCellStyle(
                                todayTextStyle: TextStyle(color: Colors.black),
                                leadingDatesTextStyle:
                                    TextStyle(color: Colors.black),
                                textStyle: TextStyle(color: Colors.black),
                                disabledDatesTextStyle:
                                    TextStyle(color: Colors.grey)),
                            view: DateRangePickerView.month,
                            monthViewSettings: const DateRangePickerMonthViewSettings(
                                firstDayOfWeek: 6,
                                weekNumberStyle: DateRangePickerWeekNumberStyle(
                                    textStyle: TextStyle(color: Colors.black)),
                                viewHeaderStyle: DateRangePickerViewHeaderStyle(
                                    textStyle: TextStyle(color: Colors.black))),
                            headerStyle: const DateRangePickerHeaderStyle(
                                textStyle: TextStyle(color: Colors.black)),
                            selectionTextStyle: const TextStyle(color: Colors.black),
                            selectionMode: DateRangePickerSelectionMode.single,
                            maxDate: DateTime.now(),
                            showActionButtons: true,
                            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                              if (args.value is DateTime) {
                                fromDate = args.value;
                              }
                            },
                            onSubmit: (Object? val) {
                              if (fromDate != null) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(fromDate);
                                // fromDate =
                                //     formattedDate;
                                fromDate = fromDate;
                                toDate = toDate;

                                notifyListeners();
                              }
                              Navigator.of(context).pop();
                            },
                            onCancel: () {
                              Navigator.of(context).pop();
                            })
                      ])));
        });
    Future.delayed(const Duration(milliseconds: 300), () {
      fromDatePickerController.displayDate = fromDate;
    });
  }

  toDateOnTap(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.r10)),
              content: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(language(context, appFonts.selectToDate),
                            style: const TextStyle(
                                fontSize: Sizes.s18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: Insets.i10),
                        SfDateRangePicker(
                            confirmText: language(context, appFonts.ok),
                            cancelText: language(context, appFonts.cancel),
                            controller: toDatePickerController,
                            initialSelectedDate: toDate,
                            selectionColor: appColor(context)
                                .appTheme
                                .primary
                                .withOpacity(0.2),
                            endRangeSelectionColor: Colors.black,
                            yearCellStyle: DateRangePickerYearCellStyle(
                                textStyle: const TextStyle(color: Colors.black),
                                cellDecoration:
                                    const BoxDecoration(color: Colors.white),
                                disabledDatesDecoration:
                                    const BoxDecoration(color: Colors.white),
                                disabledDatesTextStyle:
                                    const TextStyle(color: Colors.grey),
                                leadingDatesDecoration:
                                    const BoxDecoration(color: Colors.white),
                                leadingDatesTextStyle:
                                    const TextStyle(color: Colors.black),
                                todayCellDecoration: BoxDecoration(
                                    color: appColor(context)
                                        .appTheme
                                        .primary
                                        .withOpacity(0.4)),
                                todayTextStyle:
                                    const TextStyle(color: Colors.white)),
                            backgroundColor: Colors.white,
                            monthCellStyle: const DateRangePickerMonthCellStyle(
                                todayTextStyle: TextStyle(color: Colors.black),
                                leadingDatesTextStyle:
                                    TextStyle(color: Colors.black),
                                textStyle: TextStyle(color: Colors.black),
                                disabledDatesTextStyle:
                                    TextStyle(color: Colors.grey)),
                            view: DateRangePickerView.month,
                            monthViewSettings: const DateRangePickerMonthViewSettings(
                                firstDayOfWeek: 6,
                                weekNumberStyle: DateRangePickerWeekNumberStyle(
                                    textStyle: TextStyle(color: Colors.black)),
                                viewHeaderStyle: DateRangePickerViewHeaderStyle(
                                    textStyle: TextStyle(color: Colors.black))),
                            headerStyle: const DateRangePickerHeaderStyle(
                                textStyle: TextStyle(color: Colors.black)),
                            selectionTextStyle: const TextStyle(color: Colors.black),
                            selectionMode: DateRangePickerSelectionMode.single,
                            maxDate: DateTime.now(),
                            showActionButtons: true,
                            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                              if (args.value is DateTime) {
                                toDate = args.value;
                              }
                            },
                            onSubmit: (Object? val) {
                              if (toDate != null) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(fromDate);
                                // fromDate =
                                //     formattedDate;
                                fromDate = fromDate;
                                toDate = toDate;

                                notifyListeners();
                              }
                              Navigator.of(context).pop();
                            },
                            onCancel: () {
                              Navigator.of(context).pop();
                            })
                      ])));
        });
    Future.delayed(const Duration(milliseconds: 300), () {
      toDatePickerController.displayDate = toDate;
    });
  }

  goButtonOnTap(context) {
    int differenceInDays = toDate.difference(fromDate).inDays;
    if (differenceInDays >= 7 && differenceInDays <= 30) {
      isButtonDisabled = true;
      Future.delayed(const Duration(seconds: 2), () {
        // Your data loading logic here
        getDashboardData(context);
        isButtonDisabled = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(appFonts.pleaseSelectADateRange,
              style: appCss.dmDenseMedium16
                  .textColor(appColor(context).appTheme.black))));
    }
  }

  final DateRangePickerController fromDatePickerController =
      DateRangePickerController();
  final DateRangePickerController toDatePickerController =
      DateRangePickerController();

  void onUserSelection(isSingleUserSelected, index, context) {
    final settingPvr = Provider.of<SettingProvider>(context, listen: false);
    selectedIndex = index;
    this.isSingleUserSelected = isSingleUserSelected;
    selectedUID = settingPvr.shareWithMeList[index]['uid'];

    notifyListeners();
    getDashboardData(context);
    notifyListeners();
  }

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
      return appFonts.enterFetchRemote;
    }
  }

  DateTime parseTime(String timeString) {
    List<String> parts = timeString.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = 0;
    if (parts.length == 3) {
      seconds = int.parse(parts[2]);
    }
    return DateTime(0, 1, 1, hours, minutes, seconds);
  }

  onInit(context) async {
    final settingPvr = Provider.of<SettingProvider>(context, listen: false);
    await settingPvr.getShareWithMeData(context);
    getDefaultPic(context);

    isSingleUserSelected = isSingleUserSelected;
    selectedUID = settingPvr.shareWithMeList[userDataIndex]['uid'];
    getDashboardData(context);
    notifyListeners();
  }

  List<ChartData> chantingDataList = [];

  String errorMessage = '';

  getDashboardData(context) async {
    isLoading = true;
    var fromData = DateFormat("yyyy-MM-dd").format(fromDate);
    var toData = DateFormat("yyyy-MM-dd").format(toDate);
    try {
      Map<String, String> body = {
        "from_date": fromData,
        "to_date": toData,
        "uid": selectedUID
      };
      await apiServices
          .postApi(context, api.getDashboardData, body, isToken: true)
          .then((value) async {
        if (value.isSuccess!) {
          sleepChartData = [];
          chartData = [];
          salesData = [];
          isLoading = false;
          log('is loading $isLoading');
          List<dynamic> sleepData = value.data['dashboard']['sleep'];
          List<ChartsData> sleepDataList = [];

          for (var sleepEntry in sleepData) {
            log("sleepEntry $sleepEntry");

            DateTime sleepTime;
            DateTime wakeUpTime;

            if (sleepData.isNotEmpty) {
              if (sleepEntry['slept_time'] == null ||
                  sleepEntry['wakeup_time'] == null) {
                sleepTime = DateTime(0, 1, 1, 0, 0, 0);
                wakeUpTime = DateTime(0, 1, 1, 0, 0, 0);
                log("sleepTime (default) $sleepTime");
                log("wakeUpTime (default) $wakeUpTime");
              } else {
                sleepTime = parseTime(sleepEntry['slept_time']);
                wakeUpTime = parseTime(sleepEntry['wakeup_time']);
                log("sleepTime $sleepTime");
                log("wakeUpTime $wakeUpTime");
                String date = DateFormat('d-MMM')
                    .format(DateTime.parse(sleepEntry['date']));

                sleepDataList.add(ChartsData(
                    date,
                    wakeUpTime.millisecondsSinceEpoch.toDouble(),
                    sleepTime.millisecondsSinceEpoch.toDouble()));
              }
            } else {
              return "no Data";
            }
          }

          DateTime fromDate = DateTime.parse(fromData);
          DateTime toDate = DateTime.parse(toData);

          for (DateTime date = fromDate;
              date.isBefore(toDate);
              date = date.add(const Duration(days: 1))) {
            String formattedDate = DateFormat('d-MMM').format(date);
            if (!sleepDataList.any((data) => data.x == formattedDate)) {
              sleepDataList.add(ChartsData(
                  formattedDate,
                  DateTime(0, 1, 1, 0, 0, 0).millisecondsSinceEpoch.toDouble(),
                  DateTime(0, 1, 1, 0, 0, 0)
                      .millisecondsSinceEpoch
                      .toDouble()));
            }
          }

          sleepDataList.sort((a, b) => DateFormat('d-MMM')
              .parse(a.x)
              .compareTo(DateFormat('d-MMM').parse(b.x)));

          sleepChartData = sleepDataList;

          List<dynamic> chantingData = value.data['dashboard']['chanting'];
          List<ChartData> chantingDataList = [];

          for (var chantingEntry in chantingData) {
            DateTime parsedDate = DateTime.parse(chantingEntry['date']);
            String formattedDate = DateFormat('d-MMM').format(parsedDate);

            log('formattedDate $formattedDate');

            chantingDataList.add(ChartData(
                formattedDate,
                chantingEntry['slot_1'],
                chantingEntry['slot_2'],
                chantingEntry['slot_3'],
                chantingEntry['slot_4'],
                chantingEntry['slot_5']));
          }

          for (DateTime date = fromDate;
              date.isBefore(toDate);
              date = date.add(const Duration(days: 1))) {
            String formattedDate = DateFormat('d-MMM').format(date);
            log('formattedDate $formattedDate');
            if (!chantingDataList.any((data) => data.x == formattedDate)) {
              chantingDataList.add(ChartData(formattedDate, 0, 0, 0, 0, 0));
            }
          }

          chantingDataList.sort((a, b) => DateFormat('d-MMM')
              .parse(a.x)
              .compareTo(DateFormat('d-MMM').parse(b.x)));

          chartData = chantingDataList;

          List<dynamic> associationData =
              value.data['dashboard']['association'];
          List<SalesData> associationList = [];

          for (var associationEntry in associationData) {
            String totalReadingTime = associationEntry['total_reading_time'];
            String totalListeningTime =
                associationEntry['total_listening_time'];
            String otherActivitiesTime =
                associationEntry['other_activities_time'];

            DateTime readingTime = parseTime(totalReadingTime);
            DateTime listeningTime = parseTime(totalListeningTime);
            DateTime otherActivitiesTimes = parseTime(otherActivitiesTime);

            print('Reading Time: $readingTime');
            print('Listening Time: $listeningTime');
            print('Other Activities Time: $otherActivitiesTimes');

            DateTime parsedDate = DateTime.parse(associationEntry['date']);
            String formattedDate = DateFormat('d MMM').format(parsedDate);

            associationList.add(SalesData(formattedDate, readingTime,
                listeningTime, otherActivitiesTimes));
          }

          for (DateTime date = fromDate;
              date.isBefore(toDate);
              date = date.add(const Duration(days: 1))) {
            String formattedDate = DateFormat('d MMM').format(date);
            if (!associationList.any((data) => data.x == formattedDate)) {
              associationList.add(SalesData(formattedDate, DateTime(0, 1, 1),
                  DateTime(0, 1, 1), DateTime(0, 1, 1)));
            }
          }

          associationList.sort((a, b) => DateFormat('d MMM')
              .parse(a.x)
              .compareTo(DateFormat('d MMM').parse(b.x)));

          salesData = associationList;
          displayUid = "";
          notifyListeners();
        } else {
          isLoading = false;
          log('is loading $isLoading');
          errorMessage = 'Failed to load dashboard data';
          notifyListeners();
        }
      });
    } catch (e) {
      isLoading = false;
      log('is loading $isLoading');
      errorMessage = 'Error: $e';
      log("Error: $errorMessage");
      notifyListeners();
    }
  }
}
