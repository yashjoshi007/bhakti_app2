import 'package:bhakti_app/config.dart';

class CommonWheelSlider extends StatelessWidget {
  final int? totalCount;
  final int? minCount;
  final int? initValue;
  final int? currentIndex;
  final int? interval;
  final Function(dynamic)? onValueChanged;

  const CommonWheelSlider({
    super.key,
    this.totalCount,
    this.minCount,
    this.initValue,
    this.currentIndex,
    this.onValueChanged,
    this.interval,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
              height: Sizes.s60,
              child: WheelChooser.integer(
                  horizontal: true,
                  listWidth: Sizes.s350,
                  itemSize: Sizes.s50,
                  perspective: 0.002,
                  initValue: initValue!,
                  unSelectTextStyle: TextStyle(
                      fontSize: 12, color: appColor(context).appTheme.black54),
                  selectTextStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: appColor(context).appTheme.primary),
                  magnification: 1,
                  onValueChanged: onValueChanged!,
                  step: interval!,
                  squeeze: 0.9,
                  isInfinite: false,
                  maxValue: totalCount!,
                  minValue: minCount!)),
          SvgPicture.asset(eSvgAssets.horizontalPointer)
        ]));
  }
}
