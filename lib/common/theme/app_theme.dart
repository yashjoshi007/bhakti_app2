import 'package:flutter/material.dart';

enum ThemeType {
  light,
  dark,
}

class AppTheme {
  static ThemeType defaultTheme = ThemeType.light;

  //Theme Colors
  bool isDark;
  Color primary;
  Color darkText;
  Color lightText;
  Color oneText;
  Color twoText;
  Color threeText;
  Color whiteBg;
  Color whiteContainer;
  Color stroke;
  Color fieldCardBg;
  Color trans;
  Color black;
  Color rulesClr;
  Color containerClr;
  Color containerClr1;
  Color shadowClr;
  Color green;
  Color blue;
  Color online;
  Color red;
  Color phoneClr;
  Color googleClr;
  Color googleTxtClr;
  Color fbClr;
  Color emailClr;
  Color whiteColor;
  Color bottomText;
  Color myDocumentColor;
  Color processColor;
  Color containColor;
  Color textFieldClr;
  Color emptyTxtClr;
  Color redContainer;
  Color chantingClr;
  Color splashTxtClr;
  Color black54;
  Color black26;
  Color profileClr;
  Color profileClr1;
  Color emptyClr;

  /// Default constructor
  AppTheme({
    required this.isDark,
    required this.primary,
    required this.darkText,
    required this.lightText,
    required this.oneText,
    required this.twoText,
    required this.threeText,
    required this.whiteBg,
    required this.whiteContainer,
    required this.stroke,
    required this.fieldCardBg,
    required this.trans,
    required this.black,
    required this.black54,
    required this.black26,
    required this.rulesClr,
    required this.containerClr,
    required this.containerClr1,
    required this.shadowClr,
    required this.online,
    required this.red,
    required this.blue,
    required this.redContainer,
    required this.phoneClr,
    required this.googleClr,
    required this.googleTxtClr,
    required this.fbClr,
    required this.emailClr,
    required this.myDocumentColor,
    required this.processColor,
    required this.green,
    required this.emptyTxtClr,
    required this.whiteColor,
    required this.bottomText,
    required this.containColor,
    required this.splashTxtClr,
    required this.profileClr,
    required this.profileClr1,
    required this.textFieldClr,
    required this.chantingClr,
    required this.emptyClr,
  });

  /// fromType factory constructor
  factory AppTheme.fromType(ThemeType t) {
    switch (t) {
      case ThemeType.light:
        return AppTheme(
            isDark: false,
            primary: const Color(0xff541F5C),
            containColor: const Color(0xffC9B7CB),
            myDocumentColor: const Color(0xff9E9E9E),
            processColor: const Color(0xffEDEDED),
            darkText: const Color(0xff00162E),
            bottomText: const Color(0xffA48AA9),
            textFieldClr: const Color(0x0FC35DD2),
            lightText: const Color(0xff767676),
            profileClr: const Color(0xff83006E),
            profileClr1: const Color(0xff0060AD),
            oneText: const Color(0xff2D2D2D),
            chantingClr: const Color(0xff414141),
            twoText: const Color(0xff3d3d3d),
            threeText: const Color(0xff868686),
            whiteBg: const Color(0xffFFFFFF),
            whiteContainer: const Color(0x0F000000),
            stroke: const Color(0xffE5E8EA),
            fieldCardBg: const Color(0xffF5F6F7),
            whiteColor: const Color(0xffFFFFFF),
            trans: Colors.transparent,
            black: const Color(0xff000000),
            black54: Colors.black54,
            black26: Colors.black26,
            rulesClr: const Color(0xff3A3A3A),
            containerClr: const Color(0xffEEE9EF),
            containerClr1: const Color(0xffFCF6FD),
            shadowClr: const Color(0x1E929292),
            green: Colors.green,
            online: Colors.green,
            red: const Color(0xffFF4B4B),
            blue: Colors.blue,
            phoneClr: const Color(0xff43C4A5),
            googleClr: const Color(0xffEBF2FA),
            fbClr: const Color(0xff0084FF),
            emailClr: const Color(0xffD0011B),
            googleTxtClr: const Color(0xff707477),
            emptyTxtClr: const Color(0xffE7E7E7),
            splashTxtClr: const Color(0xff3d3d3d),
            redContainer: const Color(0xffFD3939),
            emptyClr: const Color(0xffE2E2E3));

      case ThemeType.dark:
        return AppTheme(
            chantingClr: const Color(0xff414141),
            isDark: true,
            processColor: const Color(0xffEDEDED),
            myDocumentColor: const Color(0xff9E9E9E),
            primary: const Color(0xff5465FF),
            darkText: const Color(0xffF1F1F1),
            lightText: const Color(0xff767676),
            profileClr: const Color(0xff83006E),
            profileClr1: const Color(0xff0060AD),
            oneText: const Color(0xff808B97),
            twoText: const Color(0xff3d3d3d),
            threeText: const Color(0xff3d3d3d),
            whiteBg: const Color(0xff1A1C28),
            whiteContainer: const Color(0x0F000000),
            stroke: const Color(0xff3A3D48),
            fieldCardBg: const Color(0xff262935),
            whiteColor: const Color(0xffFFFFFF),
            trans: Colors.transparent,
            black: const Color(0xff000000),
            black54: const Color(0x8a000000),
            black26: Colors.black26,
            rulesClr: const Color(0xff3A3A3A),
            containerClr: const Color(0xffEEE9EF),
            containerClr1: const Color(0xffFCF6FD),
            shadowClr: const Color(0x1E929292),
            green: Colors.green,
            online: Colors.green,
            red: const Color(0xffFF4B4B),
            blue: Colors.blue,
            phoneClr: const Color(0xff43C4A5),
            googleClr: const Color(0xffEBF2FA),
            fbClr: const Color(0xff0084FF),
            emailClr: const Color(0xffD0011B),
            googleTxtClr: const Color(0xff707477),
            bottomText: const Color(0xffA48AA9),
            containColor: const Color(0xff929292),
            textFieldClr: const Color(0x0FC35DD2),
            emptyTxtClr: const Color(0xffE7E7E7),
            splashTxtClr: const Color(0xff3d3d3d),
            redContainer: const Color(0xffFD3939),
            emptyClr: const Color(0xffE2E2E3));
    }
  }

  ThemeData get themeData {
    var t = ThemeData.from(
      textTheme: (isDark ? ThemeData.dark() : ThemeData.light()).textTheme,
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: primary,
        secondary: primary,
        surface: whiteBg,
        onSurface: whiteBg,
        onError: Colors.red,
        onPrimary: primary,
        tertiary: whiteBg,
        onInverseSurface: whiteBg,
        tertiaryContainer: whiteBg,
        surfaceTint: whiteBg,
        background: whiteBg,
        onBackground: whiteBg,
        onSecondary: primary,
        error: Colors.red,
      ),
    );
    return t.copyWith(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: Colors.transparent, cursorColor: primary),
      buttonTheme: ButtonThemeData(buttonColor: primary),
      highlightColor: primary,
    );
  }
}
