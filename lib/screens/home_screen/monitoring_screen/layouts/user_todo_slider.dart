import 'package:bhakti_app/config.dart';

class CommonPopInkwell extends StatelessWidget {
  final GestureTapCallback? onTap;

  final int? index, selectedIndex;
  final String? text;

  const CommonPopInkwell(
      {super.key, this.onTap, this.index, this.text, this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(Sizes.s4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(index == 0 ? 7 : 0),
                  topRight: Radius.circular(index == 7 ? 7 : 0),
                  bottomLeft: Radius.circular(index == 0 ? 7 : 0),
                  bottomRight: Radius.circular(index == 7 ? 7 : 0)),
                color: appColor(context).appTheme.whiteColor),
            child: Container(padding: const EdgeInsets.all(Sizes.s5),
                alignment: Alignment.center,
                height: 42,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: index == selectedIndex
                        ? appColor(context).appTheme.primary
                        : appColor(context).appTheme.whiteColor),
                child: Text(text!,
                    style: TextStyle(
                        color: index == selectedIndex
                            ? appColor(context).appTheme.whiteColor
                            : appColor(context).appTheme.lightText)))));
  }
}
