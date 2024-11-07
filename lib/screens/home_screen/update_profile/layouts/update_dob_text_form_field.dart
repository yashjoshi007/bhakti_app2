import 'package:bhakti_app/config.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class UpdateDateOfBirthBox extends StatelessWidget {
  const UpdateDateOfBirthBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateProfileProvider>(
        builder: (context, updateProfilePvr, child) {
      DateTime? selectedDate;
      if (updateProfilePvr.dob.text.isNotEmpty) {
        selectedDate =
            DateFormat('yyyy-MM-dd').parse(updateProfilePvr.dob.text);
      } else {
        selectedDate = DateTime.now();
      }

      final DateRangePickerController pickerController =
          DateRangePickerController();

      return CustomTitleWidget(
          height: Sizes.s52,
          color: updateProfilePvr.dateValid == null
              ? appColor(context).appTheme.primary.withOpacity(.20)
              : appColor(context).appTheme.red,
          width: double.infinity,
          title: language(context, appFonts.dateOfBirth),
          radius: AppRadius.r8,
          child: TextFieldCommon(
              hintText: language(context, appFonts.dateOfBirth),
              validator: (value) => updateProfilePvr.dobValidator(value),
              readOnly: true,
              controller: updateProfilePvr.dob,
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(AppRadius.r10))),
                          content: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        language(context, appFonts.dateOfBirth),
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
                                        initialSelectedDate: selectedDate,
                                        controller: pickerController,
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
                                        monthCellStyle: const DateRangePickerMonthCellStyle(
                                            todayTextStyle: TextStyle(color: Colors.black),
                                            leadingDatesTextStyle: TextStyle(color: Colors.black),
                                            textStyle: TextStyle(
                                              color: Colors.black,
                                            ),
                                            disabledDatesTextStyle: TextStyle(color: Colors.grey)),
                                        view: DateRangePickerView.month,
                                        monthViewSettings: const DateRangePickerMonthViewSettings(
                                            firstDayOfWeek: 6,
                                            weekNumberStyle: DateRangePickerWeekNumberStyle(
                                              textStyle: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            viewHeaderStyle: DateRangePickerViewHeaderStyle(textStyle: TextStyle(color: Colors.black))),
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
                                            updateProfilePvr.dob.text =
                                                formattedDate;
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
              prefixIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const HSpace(Insets.i20),
                    SvgPicture.asset(eSvgAssets.cake, height: Sizes.s20),
                    const HSpace(Insets.i10),
                    SvgPicture.asset(eSvgAssets.line,
                        height: Sizes.s24, width: Sizes.s24),
                    const HSpace(Insets.i20)
                  ]))).paddingSymmetric(vertical: Sizes.s10);
    });
  }
}
