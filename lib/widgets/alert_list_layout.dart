import 'package:bhakti_app/config.dart';

class CommonAlertList extends StatelessWidget {
  final String? text;
  final bool? status;
  final ValueChanged<bool> onToggle;

  const CommonAlertList(
      {super.key, this.status, this.text, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onToggle(!status!);
        },
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text!,
                  style: appCss.dmDenseMedium16
                      .textColor(appColor(context).appTheme.rulesClr)),
              FlutterSwitch(
                  width: Sizes.s41,
                  height: Sizes.s23,
                  padding: Sizes.s3,
                  toggleSize: Sizes.s17,
                  value: status!,
                  activeColor: appColor(context).appTheme.primary,
                  inactiveColor: appColor(context).appTheme.lightText,
                  borderRadius: AppRadius.r40,
                  onToggle: onToggle)
            ]));
  }
}
