import 'package:bhakti_app/config.dart';

class AccessKeyContainer extends StatelessWidget {
  final String? svgImage;

  const AccessKeyContainer({super.key, this.svgImage});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Sizes.s40,
        padding: const EdgeInsets.all(Sizes.s8),
        width: Sizes.s40,
        decoration: BoxDecoration(
            color: appColor(context).appTheme.textFieldClr,
            border: Border.all(
                color: appColor(context).appTheme.primary.withOpacity(0.20)),
            borderRadius: BorderRadius.circular(8)),
        child: SvgPicture.asset(svgImage!));
  }
}
