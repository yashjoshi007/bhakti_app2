library horizontal_week_calendar;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import '../../config.dart';

enum WeekStartFrom {
  sunday,
  monday,
}

class HorizontalWeekCalendar1 extends StatefulWidget {
  /// week start from [WeekStartFrom.Monday]
  final WeekStartFrom? weekStartFrom;

  ///get DateTime on date select
  final Function(DateTime)? onDateChange;

  ///get the list of DateTime on week change

  final Function(DateTime)? onInitChange;
  final Function(List<DateTime>)? onWeekChange;

  /// Active background color
  ///
  /// Default value [Theme.of(context).primaryColor]
  final Color? activeBackgroundColor;

  /// In-Active background color
  ///
  /// Default value [Theme.of(context).primaryColor.withOpacity(.2)]
  final Color? inactiveBackgroundColor;

  /// Disable background color
  ///
  /// Default value [Colors.grey]
  final Color? disabledBackgroundColor;

  /// Active text color
  ///
  /// Default value [Theme.of(context).primaryColor]
  final Color? activeTextColor;

  /// In-Active text color
  ///
  /// Default value [Theme.of(context).primaryColor.withOpacity(.2)]
  final Color? inactiveDateColor;
  final Color? inactiveWeekColor;

  /// Disable text color
  ///
  /// Default value [Colors.grey]
  final Color? disabledTextColor;

  /// Active Navigator color
  ///
  /// Default value [Theme.of(context).primaryColor]
  final Color? activeNavigatorColor;

  /// In-Active Navigator color
  ///
  /// Default value [Colors.grey]
  final Color? inactiveNavigatorColor;

  /// Month Color
  ///
  /// Default value [Theme.of(context).primaryColor.withOpacity(.2)]
  final Color? monthColor;
  String? selectDate;

  // final Widget Function(BuildContext context, DateTime date, bool isWeekend, bool isSelected) dateBuilder;

  final DateTime? datePickChange, todayDate;
  final bool isCallFun;

  HorizontalWeekCalendar1(
      {super.key,
      this.onDateChange,
      this.onWeekChange,
      this.activeBackgroundColor,
      this.inactiveBackgroundColor,
      this.disabledBackgroundColor,
      this.activeTextColor = Colors.white,
      this.inactiveWeekColor,
      this.inactiveDateColor,
      this.disabledTextColor,
      this.activeNavigatorColor,
      this.inactiveNavigatorColor,
      this.monthColor,
      this.weekStartFrom = WeekStartFrom.monday,
      this.datePickChange,
      this.todayDate,
      this.selectDate,
      this.onInitChange,
      this.isCallFun = false
      // required this.dateBuilder
      });

  @override
  State<HorizontalWeekCalendar1> createState() =>
      _HorizontalWeekCalendar1State();
}

class _HorizontalWeekCalendar1State extends State<HorizontalWeekCalendar1> {
  CarouselController carouselController = CarouselController();

  DateTime? today, selectedDate;
  List<DateTime> currentWeek = [];
  int currentWeekIndex = 0;
  List<List<DateTime>> listOfWeeks = [];
  late bool isTodayInCurrentWeek;

  @override
  void initState() {
    selectedDate = DateTime.now();

    initCalendar();
    super.initState();
  }

  String extractDate(DateTime datetime) {
    return DateFormat('yyyy-MM-dd').format(datetime);
  }

  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  initCalendar() {
    final date = DateTime.now();

    DateTime startOfCurrentWeek =
        getDate(date).subtract(const Duration(days: 6));

    currentWeek.add(startOfCurrentWeek);
    for (int index = 0; index < 6; index++) {
      DateTime addDate = startOfCurrentWeek.add(Duration(days: (index + 1)));
      currentWeek.add(addDate);
    }

    listOfWeeks.add(currentWeek);

    widget.selectDate =
        " ${currentWeek.first.year}-${currentWeek.first.month}-${currentWeek.first.day}";
    getMorePreviousWeeks();
  }

  getMorePreviousWeeks() {
    List<DateTime> minus7Days = [];
    DateTime startFrom = listOfWeeks.isEmpty
        ? DateTime.now()
        : listOfWeeks[currentWeekIndex].isEmpty
            ? DateTime.now()
            : listOfWeeks[currentWeekIndex][0];

    for (int index = 0; index < 7; index++) {
      DateTime minusDate = startFrom.add(Duration(days: -(index + 1)));
      minus7Days.add(minusDate);
    }
    listOfWeeks.add(minus7Days.reversed.toList());
    setState(() {});
  }

  onDateSelect(DateTime date) {
    setState(() {
      selectedDate = date;
    });
    widget.onDateChange?.call(selectedDate!);
  }

  onBackClick(context, {HomeScreenProvider? homeScreenPvr}) {
    carouselController.nextPage();

    // homeScreenPvr!.dateList = listOfWeeks[currentWeekIndex + 1];
    // homeScreenPvr.getData(context);
  }

  onNextClick(context) {
    carouselController.previousPage();
  }

  onWeekChange(context, index) {
    currentWeekIndex = index;
    currentWeek = listOfWeeks[currentWeekIndex];
    if (currentWeekIndex + 1 == listOfWeeks.length) {
      getMorePreviousWeeks();
    }

    widget.onWeekChange?.call(currentWeek);
  }

  // =================

  isNextDisabled() {
    return DateFormat("dd-MM-yyyy").format(listOfWeeks[currentWeekIndex][6]) ==
        DateFormat("dd-MM-yyyy").format(DateTime.now());
  }

  isCurrentYear() {
    return DateFormat('yyyy').format(currentWeek[0]) ==
        DateFormat('yyyy').format(today!);
  }

  onCallFun(context) {
    if (widget.isCallFun) {
      today = widget.todayDate;

      selectedDate = widget.datePickChange;
      if (today != selectedDate) {
        for (int ind = 0; ind < listOfWeeks.length; ind++) {
          for (int weekIndex = 0;
              weekIndex < listOfWeeks[ind].length;
              weekIndex++) {
            if (selectedDate == listOfWeeks[ind][weekIndex]) {
              carouselController.jumpToPage(ind);

              final provider =
                  Provider.of<HomeScreenProvider>(context, listen: false);
              provider.dateList = listOfWeeks[currentWeekIndex];
              // provider.getData(context, isTap: true);

              // provider.notifyListeners();
            }
          }
        }
        // carouselController.jumpToPage(page);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // bool isTodayInCurrentWeek =
    // currentWeek.map((date) => extractDate(date)).contains(todayDate);

    var theme = Theme.of(context);
    var theme1 =
        appCss.dmDenseMedium12.textColor(appColor(context).appTheme.rulesClr);
    var withOfScreen = MediaQuery.of(context).size.width;
    onCallFun(context);
    double boxHeight = withOfScreen / 5.5;
    final screenWidth = MediaQuery.of(context).size.width;

    return currentWeek.isEmpty
        ? const SizedBox()
        : Column(children: [
            Row(children: [
              GestureDetector(
                  onTap: () => onBackClick(context),
                  child: SvgPicture.asset("assets/svg/liftarrow.svg")),
              Expanded(
                  child: CarouselSlider(
                      carouselController: carouselController,
                      items: [
                        if (listOfWeeks.isNotEmpty)
                          for (int ind = 0; ind < listOfWeeks.length; ind++)
                            Row(children: [
                              for (int weekIndex = 0;
                                  weekIndex < listOfWeeks[ind].length;
                                  weekIndex++)
                                Expanded(
                                    child: GestureDetector(
                                        onTap: listOfWeeks[ind][weekIndex]
                                                .isBefore(DateTime.now())
                                            ? () {
                                                onDateSelect(listOfWeeks[ind]
                                                    [weekIndex]);
                                              }
                                            : null,
                                        child: Container(
                                            height: Sizes.s70,
                                            width: Sizes.s38,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 3),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                boxShadow: const [
                                                  BoxShadow(
                                                      color: Color(0x19000000),
                                                      blurRadius: 2,
                                                      offset: Offset(0, 2),
                                                      spreadRadius: 0)
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: DateFormat('dd-MM-yyyy').format(listOfWeeks[ind][weekIndex]) ==
                                                        DateFormat('dd-MM-yyyy')
                                                            .format(
                                                                selectedDate!)
                                                    ? widget.activeBackgroundColor ??
                                                        theme.primaryColor
                                                    : listOfWeeks[ind]
                                                                [weekIndex]
                                                            .isBefore(
                                                                DateTime.now())
                                                        ? widget.inactiveBackgroundColor ??
                                                            theme.primaryColor
                                                                .withOpacity(.2)
                                                        : widget.disabledBackgroundColor ??
                                                            appColor(context)
                                                                .appTheme
                                                                .whiteColor),
                                            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                              Text(
                                                DateFormat('MMM').format(
                                                    listOfWeeks[ind]
                                                        [weekIndex]),
                                                style: theme1.copyWith(
                                                    fontSize: screenWidth <= 350
                                                        ? 10
                                                        : 12,
                                                    color: DateFormat('dd-MM-yyyy').format(
                                                                listOfWeeks[ind]
                                                                    [
                                                                    weekIndex]) ==
                                                            DateFormat('dd-MM-yyyy')
                                                                .format(
                                                                    selectedDate!)
                                                        ? widget.activeTextColor ??
                                                            Colors.white
                                                        : listOfWeeks[ind][weekIndex].isBefore(
                                                                DateTime.now())
                                                            ? widget.inactiveWeekColor ??
                                                                Colors.white
                                                                    .withOpacity(
                                                                        .2)
                                                            : widget.inactiveWeekColor ??
                                                                Colors.white),
                                              ),
                                              FittedBox(
                                                  child: Text(
                                                      "${listOfWeeks[ind][weekIndex].day}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: theme1.copyWith(
                                                          fontSize:
                                                              screenWidth <= 350
                                                                  ? 14
                                                                  : 15,
                                                          color: DateFormat('dd-MM-yyyy').format(
                                                                      listOfWeeks[ind]
                                                                          [
                                                                          weekIndex]) ==
                                                                  DateFormat('dd-MM-yyyy')
                                                                      .format(
                                                                          selectedDate!)
                                                              ? widget.activeTextColor ??
                                                                  Colors.white
                                                              : listOfWeeks[ind]
                                                                          [weekIndex]
                                                                      .isBefore(DateTime.now())
                                                                  ? widget.inactiveDateColor ?? Colors.white.withOpacity(.2)
                                                                  : widget.disabledTextColor ?? Colors.white,
                                                          fontWeight: FontWeight.bold))),
                                              Text(
                                                DateFormat('E')
                                                    .format(listOfWeeks[ind]
                                                        [weekIndex])
                                                    .substring(0, 3),
                                                textAlign: TextAlign.center,
                                                style: theme1.copyWith(
                                                    fontSize: screenWidth <= 350
                                                        ? 10
                                                        : 12,
                                                    color: DateFormat('dd-MM-yyyy').format(
                                                                listOfWeeks[ind]
                                                                    [
                                                                    weekIndex]) ==
                                                            DateFormat('dd-MM-yyyy')
                                                                .format(
                                                                    selectedDate!)
                                                        ? widget.activeTextColor ??
                                                            Colors.white
                                                        : listOfWeeks[ind][weekIndex].isBefore(
                                                                DateTime.now())
                                                            ? widget.inactiveWeekColor ??
                                                                Colors.white
                                                                    .withOpacity(
                                                                        .2)
                                                            : widget.inactiveWeekColor ??
                                                                Colors.white),
                                              ),
                                            ]))))
                            ]).paddingSymmetric(horizontal: 8)
                      ],
                      options: CarouselOptions(
                          scrollPhysics: const AlwaysScrollableScrollPhysics(),
                          height: boxHeight,
                          viewportFraction: 1,
                          enableInfiniteScroll: false,
                          reverse: true,
                          onPageChanged: (index, reason) {
                            onWeekChange(context, index);
                          }))),
              GestureDetector(
                  onTap: !isNextDisabled()
                      ? () {
                          onNextClick(context);
                        }
                      : null,
                  child: DateFormat("dd-MM-yyyy")
                              .format(listOfWeeks[currentWeekIndex][6]) ==
                          DateFormat("dd-MM-yyyy").format(DateTime.now())
                      ? SvgPicture.asset("assets/svg/rightArrow.svg",
                          colorFilter: ColorFilter.mode(
                              appColor(context)
                                  .appTheme
                                  .lightText
                                  .withOpacity(.5),
                              BlendMode.srcIn))
                      : SvgPicture.asset("assets/svg/rightArrow.svg"))
            ])
          ]);
  }
}
