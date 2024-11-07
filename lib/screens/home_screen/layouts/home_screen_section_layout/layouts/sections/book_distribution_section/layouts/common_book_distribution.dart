import 'package:bhakti_app/config.dart';

class CommonBookDistribution extends StatelessWidget {
  final String? textTwo;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const CommonBookDistribution(
      {super.key, this.textTwo, this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Expanded(
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      color: appColor(context).appTheme.shadowClr,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                      spreadRadius: 0)
                ],
                color: appColor(context).appTheme.whiteColor),
            height: Sizes.s86,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SvgPicture.asset(eSvgAssets.bookDistribution,
                            width: screenWidth <= 350.0 ? 35 : null),
                        Container(
                            height: 35,
                            width: 40,
                            alignment: Alignment.centerRight,
                            child: TextField(
                                onChanged: onChanged,
                                textAlign: TextAlign.right,
                                controller: controller,
                                maxLength: 3,
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                                style: appCss.dmDenseMedium16.copyWith(
                                    color: appColor(context).appTheme.primary,
                                    overflow: TextOverflow.clip),
                                decoration: InputDecoration(
                                    hintText: '00',
                                    hintStyle: appCss.dmDenseMedium16.textColor(
                                        appColor(context).appTheme.emptyTxtClr),
                                    border: InputBorder.none,
                                    counterText: '')))
                      ]).paddingSymmetric(horizontal: Insets.i5),
                  Text(textTwo!,
                          overflow: TextOverflow.ellipsis,
                          style: appCss.dmDenseMedium12
                              .textColor(appColor(context).appTheme.lightText))
                      .paddingOnly(left: 8)
                ])));
  }
}
