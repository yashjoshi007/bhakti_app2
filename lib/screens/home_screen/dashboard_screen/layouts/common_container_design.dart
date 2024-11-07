import 'package:bhakti_app/config.dart';

class CommonContainerDesign extends StatelessWidget {
  final Widget? child;
  final String? text;

  const CommonContainerDesign({super.key, this.child, this.text});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CommonLeftSideText(text: text),
      const VSpace(Insets.i10),
      Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: appColor(context).appTheme.whiteColor,
              boxShadow: [
                BoxShadow(
                    color: appColor(context).appTheme.shadowClr,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                    spreadRadius: 0)
              ]),
          child: child),
      const VSpace(Insets.i10)
    ]);
  }
}
