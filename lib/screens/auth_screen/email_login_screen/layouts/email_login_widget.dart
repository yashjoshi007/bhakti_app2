import 'package:bhakti_app/config.dart';

class EmailLoginWidget {
  Widget commonSocialContainer(context, svgImage) => Container(
      decoration: BoxDecoration(
          color: appColor(context).appTheme.whiteColor,
          borderRadius: BorderRadius.circular(AppRadius.r6),
          boxShadow: [
            BoxShadow(
                color: appColor(context).appTheme.black.withOpacity(.2),
                blurRadius: 12,
                offset: const Offset(0, 4))
          ]),
      height: Sizes.s46,
      width: Sizes.s46,
      alignment: Alignment.center,
      child: SvgPicture.asset(svgImage));

  Widget commonBgDecoration(context, child) => Container(
      height: double.infinity,
      padding: EdgeInsets.only(
          bottom: Insets.i27, top: MediaQuery.of(context).size.height * 0.08),
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage(eImageAssets.splashBg))),
      child: child);

  Widget commonEmailTextField(context, dataPvr,TextEditingController? controller,
          FormFieldValidator<String>? validator) =>
      CustomTitleWidget(
          height: Sizes.s52,
          width: double.infinity,
          title: language(context,appFonts.email),
          color: dataPvr!.emailValid == null
              ? appColor(context).appTheme.primary.withOpacity(.20)
              : appColor(context).appTheme.red,
          radius: AppRadius.r8,
          child: TextFieldCommon(
              validator: validator,
              keyboardType: TextInputType.emailAddress,
              hintText: language(context,appFonts.egMail),
              controller: controller,
              prefixIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const HSpace(Sizes.s20),
                    SvgPicture.asset(eSvgAssets.emailId, height: Sizes.s20),
                    const HSpace(Sizes.s10),
                    SvgPicture.asset(eSvgAssets.line,
                        height: Sizes.s24, width: Sizes.s24),
                    const HSpace(Sizes.s20)
                  ])));

  Widget commonPasswordTextField(context, dataPvr, obscureText, suffixIcon,
          FormFieldValidator<String>? validator,TextEditingController? controller) =>
      CustomTitleWidget(
          height: Sizes.s52,
          width: double.infinity,
          title: language(context,appFonts.password),
          color: dataPvr!.passwordValid == null
              ? appColor(context).appTheme.primary.withOpacity(.20)
              : appColor(context).appTheme.red,
          radius: AppRadius.r8,
          child: TextFieldCommon(
              obscureText: obscureText!,
              suffixIcon: suffixIcon,
              validator: validator,
              keyboardType: TextInputType.emailAddress,
              hintText: language(context,appFonts.egPass),
              controller: controller,
              prefixIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const HSpace(Sizes.s20),
                    SvgPicture.asset(eSvgAssets.lock, height: Sizes.s20),
                    const HSpace(Sizes.s10),
                    SvgPicture.asset(eSvgAssets.line,
                        height: Sizes.s24, width: Sizes.s24),
                    const HSpace(Sizes.s20)
                  ])));

  Widget commonRichText(context, text, text1, GestureTapCallback? onTextTap) =>
      RichText(
          text: TextSpan(
              style: appCss.dmDenseSemiBold14
                  .textColor(appColor(context).appTheme.oneText),
              children: [
            TextSpan(text: text),
            TextSpan(
                text: text1,
                style: appCss.dmDenseSemiBold14
                    .textColor(appColor(context).appTheme.primary),
                recognizer: TapGestureRecognizer()..onTap = onTextTap)
          ])).alignment(Alignment.bottomCenter);
}
