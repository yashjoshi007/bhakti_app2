import 'package:bhakti_app/config.dart';

class MyMinutes extends StatelessWidget {
  final int mins;

  const MyMinutes({super.key, required this.mins});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(mins < 10 ? '0$mins' : mins.toString(),
            style: appCss.dmDenseBold38
                .textColor(appColor(context).appTheme.primary)));
  }
}
