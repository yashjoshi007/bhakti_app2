import 'package:bhakti_app/config.dart';

class CommonAssociationSection extends StatelessWidget {
  final Widget? child;

  const CommonAssociationSection({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: appColor(context).appTheme.shadowClr,
                  blurRadius: 8,
                  offset: const Offset(0, 4))
            ],
            color: appColor(context).appTheme.whiteColor),
        height: Sizes.s86,
        width: Sizes.s126,
        child: child!);
  }
}
