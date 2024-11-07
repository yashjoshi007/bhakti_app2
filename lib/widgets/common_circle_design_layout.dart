import 'package:bhakti_app/config.dart';

class CommonCircleDesign extends StatelessWidget {
  final double? height, width;

  const CommonCircleDesign(
      {super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                width: 0.5, color: appColor(context).appTheme.containerClr)));
  }
}
