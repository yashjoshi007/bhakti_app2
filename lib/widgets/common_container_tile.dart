import '../config.dart';

class CommonContainerTile extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? paddingArea;

  const CommonContainerTile({super.key, this.child, this.paddingArea});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: paddingArea ?? const EdgeInsets.all(Sizes.s12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.r8),
            color: appColor(context).appTheme.whiteColor,
            boxShadow: [
              BoxShadow(
                  color: appColor(context).appTheme.shadowClr,
                  blurRadius: AppRadius.r16,
                  offset: const Offset(0, 2),
                  spreadRadius: 0)
            ]),
        child: child);
  }
}
