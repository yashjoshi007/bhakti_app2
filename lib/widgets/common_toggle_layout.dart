import 'package:bhakti_app/config.dart';

class CommonToggleLayout extends StatelessWidget {
  final String? text;
  final bool? status;
  final ValueChanged<bool> onToggle;
  final int? index;
  final List? list;
  final bool? isRegulation;

  const CommonToggleLayout(
      {super.key,
      this.status,
      this.text,
      required this.onToggle,
      this.index,
      this.list,
      this.isRegulation = false});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
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
              ]).backgroundColor(appColor(context).appTheme.whiteColor)),
      if (index != list!.length - 1)
        SvgPicture.asset(eSvgAssets.lineRuler).paddingSymmetric(
            vertical: isRegulation == true ? Insets.i10 : Insets.i15)
    ]);
  }
}
