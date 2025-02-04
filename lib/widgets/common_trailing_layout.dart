import '../config.dart';

class CommonTrailingLayout extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String? svg;

  const CommonTrailingLayout({super.key, this.svg, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
            padding: const EdgeInsets.all(Sizes.s6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.r6),
                boxShadow: [
                  BoxShadow(
                      color: appColor(context).appTheme.shadowClr,
                      blurRadius: AppRadius.r16,
                      offset: const Offset(0, 4),
                      spreadRadius: 0)
                ],
                color: appColor(context).appTheme.whiteColor),
            width: Sizes.s34,
            height: Sizes.s35,
            child: SvgPicture.asset(svg!))
        .inkWell(onTap: onTap);
  }
}
