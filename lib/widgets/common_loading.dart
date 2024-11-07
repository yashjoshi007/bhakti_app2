import '../config.dart';

class CommonLoading extends StatelessWidget {
  const CommonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Material(
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.r60)),
            child: Padding(
                padding: const EdgeInsets.all(Sizes.s8),
                child: SizedBox(
                    height: Sizes.s20,
                    width: Sizes.s20,
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            appColor(context).appTheme.primary),
                        strokeWidth: Sizes.s3)))));
  }
}
