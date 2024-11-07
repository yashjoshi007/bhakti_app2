import 'package:bhakti_app/config.dart';
part 'scale.dart';

FontWeight thin = FontWeight.w100;
FontWeight extraLight = FontWeight.w200;
FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.normal;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;
FontWeight extraThickBold = FontWeight.bold;

//raleway font

TextStyle philosopherFont({double? fontSize, fontWeight}) =>
    GoogleFonts.philosopher(fontSize: fontSize, fontWeight: fontWeight);

//dmDense font
 TextStyle dmDense({double? fontsize, fontWeight}) =>
     GoogleFonts.dmSans(fontSize: fontsize, fontWeight: fontWeight);

class AppCss {

//Text Style dmDense extra bold
  TextStyle dmDenseExtraBold70 = dmDense( fontWeight: extraBold,fontsize:FontSizes.f70);
  TextStyle dmDenseExtraBold65 = dmDense( fontWeight:extraBold ,fontsize:FontSizes.f65);
  TextStyle dmDenseExtraBold60 = dmDense( fontWeight: extraBold,fontsize:FontSizes.f60);
  TextStyle dmDenseExtraBold40 = dmDense( fontWeight: extraBold,fontsize:FontSizes.f40);
  TextStyle dmDenseExtraBold20 = dmDense( fontWeight: extraBold,fontsize:FontSizes.f20);
  TextStyle dmDenseExtraBold25 = dmDense( fontWeight:extraBold ,fontsize:FontSizes.f25);
  TextStyle dmDenseExtraBold30 = dmDense( fontWeight: extraBold,fontsize:FontSizes.f30);

  //Text Style dmDense bold
  TextStyle dmDenseBlack28 = dmDense(fontWeight: black,fontsize:FontSizes.f28);
  TextStyle dmDenseBlack24 = dmDense(fontWeight: black,fontsize:FontSizes.f24);
  TextStyle dmDenseBlack20 = dmDense(fontWeight: black,fontsize:FontSizes.f20);
  TextStyle dmDenseBlack18 = dmDense(fontWeight: black,fontsize:FontSizes.f18);
  TextStyle dmDenseBlack16 = dmDense(fontWeight: black,fontsize:FontSizes.f16);
  TextStyle dmDenseBlack12 = dmDense(fontWeight: black,fontsize:FontSizes.f12);
  TextStyle dmDenseBlack14 = dmDense(fontWeight: black,fontsize:FontSizes.f14);


  //Text Style dmDense bold
  TextStyle dmDenseExtraBold22 = dmDense(fontWeight: extraBold,fontsize:FontSizes.f22);
  TextStyle dmDenseExtraBold18 = dmDense(fontWeight: extraBold,fontsize:FontSizes.f18);
  TextStyle dmDenseExtraBold16 = dmDense(fontWeight: extraBold,fontsize:FontSizes.f16);
  TextStyle dmDenseExtraBold14 = dmDense(fontWeight: extraBold,fontsize:FontSizes.f14);
  TextStyle dmDenseExtraBold12 = dmDense(fontWeight: extraBold,fontsize:FontSizes.f12);

  //Text Style semi dmDense bold
  TextStyle dmDenseBold50 = dmDense(fontWeight: bold,fontsize:FontSizes.f50);
  TextStyle dmDenseBold38 = dmDense(fontWeight: bold,fontsize:FontSizes.f38);
  TextStyle dmDenseBold35 = dmDense(fontWeight: bold,fontsize:FontSizes.f35);
  TextStyle dmDenseBold24 = dmDense(fontWeight: bold,fontsize:FontSizes.f24);
  TextStyle dmDenseBold20 = dmDense(fontWeight: bold,fontsize:FontSizes.f20);
  TextStyle dmDenseBold18 = dmDense(fontWeight: bold,fontsize:FontSizes.f18);
  TextStyle dmDenseBold16 = dmDense(fontWeight: bold,fontsize:FontSizes.f16);
  TextStyle dmDenseBold15 = dmDense(fontWeight: bold,fontsize:FontSizes.f15);
  TextStyle dmDenseBold17 = dmDense(fontWeight: bold,fontsize:FontSizes.f17);
  TextStyle dmDenseBold14 = dmDense(fontWeight: bold,fontsize:FontSizes.f14);
  TextStyle dmDenseBold12 = dmDense(fontWeight: bold,fontsize:FontSizes.f12);
  TextStyle dmDenseBold10 = dmDense(fontWeight: bold,fontsize:FontSizes.f10);

  TextStyle dmDenseSemiBold24= dmDense(fontWeight: semiBold,fontsize:FontSizes.f24);
  TextStyle dmDenseSemiBold22= dmDense(fontWeight: semiBold,fontsize:FontSizes.f22);
  TextStyle dmDenseSemiBold20= dmDense(fontWeight: semiBold,fontsize:FontSizes.f20);
  TextStyle dmDenseSemiBold18= dmDense(fontWeight: semiBold,fontsize:FontSizes.f18);
  TextStyle dmDenseSemiBold16= dmDense(fontWeight: semiBold,fontsize:FontSizes.f16);
  TextStyle dmDenseSemiBold15= dmDense(fontWeight: semiBold,fontsize:FontSizes.f15);
  TextStyle dmDenseSemiBold13= dmDense(fontWeight: semiBold,fontsize:FontSizes.f13);
  TextStyle dmDenseSemiBold14= dmDense(fontWeight: semiBold,fontsize:FontSizes.f14);
  TextStyle dmDenseSemiBold12= dmDense(fontWeight: semiBold,fontsize:FontSizes.f12);
  TextStyle dmDenseSemiBold10= dmDense(fontWeight: semiBold,fontsize:FontSizes.f10);


  //Text Style dmDense medium
  TextStyle dmDenseMedium28 = dmDense(fontWeight: medium,fontsize:FontSizes.f28);
  TextStyle dmDenseMedium22 = dmDense(fontWeight: medium,fontsize:FontSizes.f22);
  TextStyle dmDenseMedium21 = dmDense(fontWeight: medium,fontsize:FontSizes.f21);
  TextStyle dmDenseMedium20 = dmDense(fontWeight: medium,fontsize:FontSizes.f20);
  TextStyle dmDenseMedium18 = dmDense(fontWeight: medium,fontsize:FontSizes.f18);
  TextStyle dmDenseMedium17 = dmDense(fontWeight: medium,fontsize:FontSizes.f17);
  TextStyle dmDenseMedium16 = dmDense(fontWeight: medium,fontsize:FontSizes.f16);
  TextStyle dmDenseMedium15 = dmDense(fontWeight: medium,fontsize:FontSizes.f15);
  TextStyle dmDenseMedium14 = dmDense(fontWeight: medium,fontsize:FontSizes.f14);
  TextStyle dmDenseMedium13 = dmDense(fontWeight: medium,fontsize:FontSizes.f13);
  TextStyle dmDenseMedium12 = dmDense(fontWeight: medium,fontsize:FontSizes.f12);
  TextStyle dmDenseMedium11 = dmDense(fontWeight: medium,fontsize:FontSizes.f11);
  TextStyle dmDenseMedium10 = dmDense(fontWeight: medium,fontsize:FontSizes.f10);

  //Text Style dmDense regular
  TextStyle dmDenseRegular18 = dmDense(fontWeight: regular,fontsize:FontSizes.f18);
  TextStyle dmDenseRegular16 = dmDense(fontWeight: regular,fontsize:FontSizes.f16);
  TextStyle dmDenseRegular14 = dmDense(fontWeight: regular,fontsize:FontSizes.f14);
  TextStyle dmDenseRegular13 = dmDense(fontWeight: regular,fontsize:FontSizes.f13);
  TextStyle dmDenseRegular12 = dmDense(fontWeight: regular,fontsize:FontSizes.f12);
  TextStyle dmDenseRegular11 = dmDense(fontWeight: regular,fontsize:FontSizes.f11);


  TextStyle dmDenseLight16 = dmDense(fontWeight: light,fontsize:FontSizes.f16);
  TextStyle dmDenseLight14 = dmDense(fontWeight: light,fontsize:FontSizes.f14);
  TextStyle dmDenseLight12 = dmDense(fontWeight: light,fontsize:FontSizes.f12);

  TextStyle philosopherBold70 = philosopherFont( fontWeight: bold,fontSize:FontSizes.f70);
  TextStyle philosopherBold65 = philosopherFont( fontWeight:bold ,fontSize:FontSizes.f65);
  TextStyle philosopherBold60 = philosopherFont( fontWeight: bold,fontSize:FontSizes.f60);
  TextStyle philosopherBold40 = philosopherFont( fontWeight:bold ,fontSize:FontSizes.f40);
  TextStyle philosopherBold38 = philosopherFont( fontWeight:bold ,fontSize:FontSizes.f38);
  TextStyle philosopherBold25 = philosopherFont( fontWeight:bold ,fontSize:FontSizes.f25);
  TextStyle philosopherBold26 = philosopherFont( fontWeight:bold ,fontSize:FontSizes.f26);
  TextStyle philosopherBold27 = philosopherFont( fontWeight:bold ,fontSize:FontSizes.f27);
  TextStyle philosopherBold28 = philosopherFont( fontWeight:bold ,fontSize:FontSizes.f28);
  TextStyle philosopherBold18 = philosopherFont( fontWeight:bold ,fontSize:FontSizes.f18);

  TextStyle philosopherSemiBold45 = philosopherFont(fontWeight: semiBold,fontSize:FontSizes.f45);
  TextStyle philosopherSemiBold26 = philosopherFont(fontWeight: semiBold,fontSize:FontSizes.f26);
  TextStyle philosopherSemiBold23 = philosopherFont(fontWeight: medium,fontSize:FontSizes.f23);
  TextStyle philosopherSemiBold18 = philosopherFont(fontWeight: medium,fontSize:FontSizes.f18);

}
