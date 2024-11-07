import 'package:bhakti_app/config.dart';

class AppbarCalendarDialog extends StatelessWidget {
  final Widget? child;

  const AppbarCalendarDialog(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
            dialogTheme: DialogTheme(
                shape: RoundedRectangleBorder(side: const BorderSide(),
                    borderRadius: BorderRadius.circular(AppRadius.r10))),
            colorScheme: ColorScheme.light(
                primary: appColor(context).appTheme.primary,
                onSurface: appColor(context).appTheme.black,
                error: appColor(context).appTheme.red),
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    textStyle: TextStyle(
                        color: appColor(context).appTheme.whiteColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                    foregroundColor: appColor(context).appTheme.whiteColor,
                    backgroundColor: appColor(context).appTheme.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.r10))))),
        child: child!);
  }
}
