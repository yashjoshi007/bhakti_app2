
import '../../config.dart';

class MyHours extends StatelessWidget {
  final int hours;

  const MyHours({super.key, required this.hours});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(hours.toString(),
            style: appCss.dmDenseBold38
                .textColor(appColor(context).appTheme.primary)));
  }
}
