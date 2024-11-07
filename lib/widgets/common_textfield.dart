import '../config.dart';

class CommonTextField extends StatelessWidget {
  final String? hintText, errorText;
  final TextEditingController? controller;
  final bool? readOnly;
  final double? height;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon, prefixIcon;
  final Color? fillColor;
  final bool obscureText;
  final double? vertical;
  final InputBorder? border;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final int? maxLength, minLines, maxLines;
  final String? counterText;
  final GestureTapCallback? onTap;
  final Widget? prefix;

  const CommonTextField(
      {super.key,
      this.hintText,
      this.controller,
      this.readOnly = false,
      this.errorText,
      this.validator,
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
      this.maxLength,
      this.minLines,
      this.maxLines,
      this.counterText,
      this.height,
      this.prefix});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height ?? Sizes.s40,
        decoration: BoxDecoration(
            border: Border.all(
                color: appColor(context).appTheme.primary.withOpacity(0.20)),
            borderRadius: BorderRadius.circular(AppRadius.r8)),
        child: TextFormField(
            cursorColor: appColor(context).appTheme.primary,
            showCursor: true,
            maxLines: maxLines ?? 1,
            style: appCss.dmDenseExtraBold16
                .textColor(appColor(context).appTheme.lightText),
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
                filled: true,
                fillColor: appColor(context).appTheme.textFieldClr,
                counterText: '',
                errorMaxLines: 1,
                errorStyle: TextStyle(
                    fontSize: 0, color: appColor(context).appTheme.trans),
                disabledBorder: const OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppRadius.r8)),
                    borderSide: BorderSide.none),
                focusedBorder: const OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppRadius.r8)),
                    borderSide: BorderSide.none),
                enabledBorder: const OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppRadius.r8)),
                    borderSide: BorderSide.none),
                border: const OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppRadius.r8)),
                    borderSide: BorderSide.none),
                suffixIcon: suffixIcon,
                prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [prefixIcon ?? const SizedBox()]),
                contentPadding: EdgeInsets.symmetric(
                    vertical: vertical ?? Sizes.s17, horizontal: Sizes.s15),
                hintText: hintText,
                hintStyle: appCss.dmDenseMedium14
                    .textColor(appColor(context).appTheme.lightText),
                labelStyle:
                    appCss.dmDenseRegular14.textColor(appColor(context).appTheme.lightText))));
  }
}
