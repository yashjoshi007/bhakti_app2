import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:bhakti_app/config.dart';

class UpdateInitiatedDateBox extends StatelessWidget {
  const UpdateInitiatedDateBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateProfileProvider>(
        builder: (context, updateProfilePvr, child) {
      DateTime? selectedDate;
      if (updateProfilePvr.initiationDate.text.isNotEmpty) {
        selectedDate = DateFormat('yyyy-MM-dd')
            .parse(updateProfilePvr.initiationDate.text);
      } else {
        selectedDate = DateTime.now();
      }

      final DateRangePickerController pickerController =
          DateRangePickerController();

      return CustomTitleWidget(
          height: Sizes.s52,
          width: double.infinity,
          title: language(context, appFonts.initiatedDate),
          color: updateProfilePvr.initiatedDateValid == null
              ? appColor(context).appTheme.primary.withOpacity(.20)
              : appColor(context).appTheme.red,
          radius: AppRadius.r8,
          child: TextFieldCommon(
              validator: (value) =>
                  updateProfilePvr.initiatedDateValidator(value),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppRadius.r10)),
                          content: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        language(
                                            context, appFonts.initiatedDate),
                                        style: const TextStyle(
                                            fontSize: Sizes.s18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: Insets.i10),
                                    SfDateRangePicker(
                                        confirmText:
                                            language(context, appFonts.ok),
                                        cancelText:
                                            language(context, appFonts.cancel),
                                        controller: pickerController,
                                        initialSelectedDate: selectedDate,
                                        selectionColor: appColor(context)
                                            .appTheme
                                            .primary
                                            .withOpacity(0.2),
                                        endRangeSelectionColor: Colors.black,
                                        yearCellStyle: DateRangePickerYearCellStyle(
                                            textStyle: const TextStyle(
                                                color: Colors.black),
                                            cellDecoration: const BoxDecoration(
                                                color: Colors.white),
                                            disabledDatesDecoration:
                                                const BoxDecoration(
                                                    color: Colors.white),
                                            disabledDatesTextStyle: const TextStyle(
                                                color: Colors.grey),
                                            leadingDatesDecoration:
                                                const BoxDecoration(
                                                    color: Colors.white),
                                            leadingDatesTextStyle: const TextStyle(
                                                color: Colors.black),
                                            todayCellDecoration: BoxDecoration(
                                                color: appColor(context)
                                                    .appTheme
                                                    .primary
                                                    .withOpacity(0.4)),
                                            todayTextStyle: const TextStyle(color: Colors.white)),
                                        backgroundColor: Colors.white,
                                        monthCellStyle: const DateRangePickerMonthCellStyle(todayTextStyle: TextStyle(color: Colors.black), leadingDatesTextStyle: TextStyle(color: Colors.black), textStyle: TextStyle(color: Colors.black), disabledDatesTextStyle: TextStyle(color: Colors.grey)),
                                        view: DateRangePickerView.month,
                                        monthViewSettings: const DateRangePickerMonthViewSettings(firstDayOfWeek: 6, weekNumberStyle: DateRangePickerWeekNumberStyle(textStyle: TextStyle(color: Colors.black)), viewHeaderStyle: DateRangePickerViewHeaderStyle(textStyle: TextStyle(color: Colors.black))),
                                        headerStyle: const DateRangePickerHeaderStyle(textStyle: TextStyle(color: Colors.black)),
                                        selectionTextStyle: const TextStyle(color: Colors.black),
                                        selectionMode: DateRangePickerSelectionMode.single,
                                        maxDate: DateTime.now(),
                                        showActionButtons: true,
                                        onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                                          if (args.value is DateTime) {
                                            selectedDate = args.value;
                                          }
                                        },
                                        onSubmit: (Object? val) {
                                          if (selectedDate != null) {
                                            String formattedDate =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(selectedDate!);
                                            updateProfilePvr.initiationDate
                                                .text = formattedDate;
                                            updateProfilePvr.notifyListeners();
                                          }
                                          Navigator.of(context).pop();
                                        },
                                        onCancel: () {
                                          Navigator.of(context).pop();
                                        })
                                  ])));
                    });

                Future.delayed(const Duration(milliseconds: 300), () {
                  if (selectedDate != null) {
                    pickerController.displayDate = selectedDate!;
                  }
                });
              },
              readOnly: true,
              hintText: language(context, appFonts.initiatedDate),
              controller: updateProfilePvr.initiationDate,
              prefixIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const HSpace(Sizes.s16),
                    SvgPicture.asset(eSvgAssets.calendar, height: Sizes.s25),
                    const HSpace(Sizes.s12),
                    SvgPicture.asset(eSvgAssets.line,
                        height: Sizes.s24, width: Sizes.s24),
                    const HSpace(Sizes.s20)
                  ]))).paddingSymmetric(vertical: Sizes.s10);
    });
  }
}
