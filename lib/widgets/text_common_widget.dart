import 'package:bhakti_app/config.dart';

class TextFieldCommon extends StatelessWidget {
  final String? hintText, errorText;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final Widget? suffixIcon, prefixIcon;
  final Color? fillColor;
  final bool obscureText;
  final double? vertical;
  final InputBorder? border;

  // final String? errorText;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final int? maxLength, minLines, maxLines;
  final String? counterText;
  final GestureTapCallback? onTap;
  final bool? readOnly;

  const TextFieldCommon({
    super.key,
    this.hintText,
    this.errorText,
    this.validator,
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.border,
    this.obscureText = false,
    this.fillColor,
    this.vertical,
    this.keyboardType,
    this.focusNode,
    this.onChanged,
    this.onTap,
    this.readOnly,
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.counterText,
  });

  @override
  Widget build(BuildContext context) {
// Text field common
    return TextFormField(
        cursorColor: appColor(context).appTheme.primary,
        showCursor: true,
        maxLines: maxLines ?? 1,
        style: appCss.dmDenseExtraBold16.textColor(const Color(0xff767676)),
        focusNode: focusNode,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        onTap: onTap,
        readOnly: readOnly ?? false,
        controller: controller,
        onChanged: onChanged,
        minLines: minLines,
        maxLength: maxLength,
        decoration: InputDecoration(
            counterText: '',
            errorMaxLines: 1,
            errorStyle:
                TextStyle(fontSize: 0, color: appColor(context).appTheme.primary),
            disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(AppRadius.r8)),
                borderSide: BorderSide.none),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(AppRadius.r8)),
                borderSide: BorderSide.none),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(AppRadius.r8)),
                borderSide: BorderSide.none),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(AppRadius.r8)),
                borderSide: BorderSide.none),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            contentPadding: EdgeInsets.symmetric(
                vertical: vertical ?? Sizes.s17, horizontal: Sizes.s15),
            hintText: hintText,
            hintStyle: appCss.dmDenseMedium14
                .textColor(appColor(context).appTheme.lightText),
            labelStyle: appCss.dmDenseRegular14
                .textColor(appColor(context).appTheme.lightText)));
  }
}
