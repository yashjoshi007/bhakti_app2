import 'package:bhakti_app/config.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final String icon;
  final int? maxLength;
  final String hintText;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;

  const CustomTextFieldWidget({
    super.key,
    required this.title,
    this.controller,
    required this.icon,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTitleWidget(
        height: Sizes.s52,
        width: double.infinity,
        title: title,
        color: const Color(0xff541F5C).withOpacity(0.20),
        radius: 8,
        child: TextFieldCommon(
            maxLength: maxLength,
            hintText: hintText,
            onChanged: onChanged,
            keyboardType: keyboardType,
            controller: controller,
            prefixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const HSpace(Insets.i20),
                  SvgPicture.asset(icon, height: Sizes.s20),
                  const HSpace(Insets.i10),
                  SvgPicture.asset(eSvgAssets.line,
                      height: Sizes.s24, width: Sizes.s24),
                  const HSpace(Insets.i20)
                ]))).paddingSymmetric(vertical: Sizes.s10);
  }
}
