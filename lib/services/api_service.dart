import 'dart:developer';
import 'package:bhakti_app/config.dart';
import 'package:bhakti_app/services/api_model.dart';
import 'package:bhakti_app/services/environment.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:bhakti_app/services/error/exceptions.dart';

class ApiServices {
  Dio dio = Dio();

  Future<APIDataClass> getApi(context, String apiName, List params,
      {isToken = false}) async {
    //default data to class
    APIDataClass apiData = APIDataClass(
      message: 'No data',
      isSuccess: false,
      data: '0',
    );
    //Check For Internet
    bool isInternet = await isNetworkConnection();
    if (!isInternet) {
      apiData.message = "No Internet Access";
      apiData.isSuccess = false;
      apiData.data = 0;
      return apiData;
    } else {
      log("URL: $apiName");

      try {
        //dio.options.headers["authtoken"] = authtoken;
        SharedPreferences pref = await SharedPreferences.getInstance();
        String? token = pref.getString(session.accessToken);
        log("token : $token");

        var response = await dio.get(apiName,
            data: params,
            options: Options(headers: isToken ? headersToken(token) : headers));

        if (response.statusCode == 200) {
          //get response
          var responseData = response.data;
          log("$apiName Response: ${response.data}");

          //set data to class
          apiData.message = responseData['StatusText'];
          apiData.isSuccess = true;
          apiData.data = responseData['data'];
          return apiData;
        } else {
          apiData.message = "No Internet Access";
          apiData.isSuccess = false;
          apiData.data = 0;
          return apiData;
        }
      } catch (e) {
        if (e is DioException) {
          if (e.type == DioExceptionType.badResponse) {
            final response = e.response;
            if (response != null && response.data != null) {
              if (response.data['StatusCode'] == 1001) {
                showDialog(
                    context: context,
                    builder: (context) {
                      Navigator.pushReplacementNamed(
                          context, routeName.loginAuthScreen);
                      return AlertDialog(
                          title: Text(
                              language(context, appFonts.yourSessionHasExpired),
                              style: appCss.philosopherBold28.textColor(
                                  appColor(context).appTheme.oneText)),
                          content: Text(
                              language(context, appFonts.pleaseLogInAgain),
                              style: appCss.dmDenseRegular16.textColor(
                                  appColor(context).appTheme.lightText)));
                    });
                return apiData;
              } else {
                apiData.message = response.data['StatusText'];
                apiData.isSuccess = false;
                apiData.data = 0;
                return apiData;
              }
            } else {
              if (response?.data['StatusCode'] == 1001 ||
                  response?.data['StatusCode'] == 1002 ||
                  response?.data['StatusCode'] == 1003 ||
                  response?.data['StatusCode'] == 1004 ||
                  response?.data['StatusCode'] == 1005) {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return PopScope(
                          canPop: false,
                          child: Dialog(
                              insetPadding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.s20),
                              backgroundColor: appColor(context).appTheme.trans,
                              child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(AppRadius.r8),
                                      color: appColor(context)
                                          .appTheme
                                          .whiteColor),
                                  width: double.infinity,
                                  height: Sizes.s150,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                  language(
                                                      context,
                                                      appFonts
                                                          .yourSessionHasExpired),
                                                  style: appCss
                                                      .philosopherBold18
                                                      .textColor(
                                                          appColor(context)
                                                              .appTheme
                                                              .oneText)),
                                              Text(
                                                  language(
                                                      context,
                                                      appFonts
                                                          .pleaseLogInAgain),
                                                  style: appCss.dmDenseRegular16
                                                      .textColor(
                                                          appColor(context)
                                                              .appTheme
                                                              .lightText))
                                            ]),
                                        CommonButton(
                                            width: Sizes.s120,
                                            text: 'Ok',
                                            onTap: () async {
                                              try {
                                                await apiServices
                                                    .getApi(
                                                        context, api.logout, [],
                                                        isToken: true)
                                                    .then((value) async {
                                                  final prefs =
                                                      await SharedPreferences
                                                          .getInstance();

                                                  if (value.isSuccess!) {
                                                    if (await prefs.clear()) {
                                                      await FirebaseAuth
                                                          .instance
                                                          .signOut()
                                                          .then((value) async {
                                                        Navigator
                                                            .pushReplacementNamed(
                                                                context,
                                                                routeName
                                                                    .loginAuthScreen);
                                                      });
                                                    }
                                                  }
                                                });
                                              } catch (e) {
                                                log('error $e');
                                              }
                                            })
                                      ]))));
                    });
                return apiData;
              } else {
                apiData.message = response?.data['StatusText'];
                apiData.isSuccess = false;
                apiData.data = 0;
                return apiData;
              }
            }
          } else {
            final response = e.response;
            if (response != null && response.data != null) {
              final Map responseData =
                  json.decode(response.data as String) as Map;
              if (response.data['StatusCode'] == 1001 ||
                  response.data['StatusCode'] == 1002 ||
                  response.data['StatusCode'] == 1003 ||
                  response.data['StatusCode'] == 1004 ||
                  response.data['StatusCode'] == 1005) {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return PopScope(
                          canPop: false,
                          child: Dialog(
                              insetPadding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.s20),
                              backgroundColor: appColor(context).appTheme.trans,
                              child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(AppRadius.r8),
                                      color: appColor(context)
                                          .appTheme
                                          .whiteColor),
                                  width: double.infinity,
                                  height: Sizes.s150,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                  language(
                                                      context,
                                                      appFonts
                                                          .yourSessionHasExpired),
                                                  style: appCss
                                                      .philosopherBold18
                                                      .textColor(
                                                          appColor(context)
                                                              .appTheme
                                                              .oneText)),
                                              Text(
                                                  language(
                                                      context,
                                                      appFonts
                                                          .pleaseLogInAgain),
                                                  style: appCss.dmDenseRegular16
                                                      .textColor(
                                                          appColor(context)
                                                              .appTheme
                                                              .lightText))
                                            ]),
                                        CommonButton(
                                            width: Sizes.s120,
                                            text: 'Ok',
                                            onTap: () async {
                                              try {
                                                await apiServices
                                                    .getApi(
                                                        context, api.logout, [],
                                                        isToken: true)
                                                    .then((value) async {
                                                  final prefs =
                                                      await SharedPreferences
                                                          .getInstance();

                                                  if (value.isSuccess!) {
                                                    if (await prefs.clear()) {
                                                      await FirebaseAuth
                                                          .instance
                                                          .signOut()
                                                          .then((value) async {
                                                        Navigator
                                                            .pushReplacementNamed(
                                                                context,
                                                                routeName
                                                                    .loginAuthScreen);
                                                      });
                                                    }
                                                  }
                                                });
                                              } catch (e) {
                                                log('error $e');
                                              }
                                            })
                                      ]))));
                    });
                return apiData;
              } else {
                apiData.message = responseData['StatusText'] as String;
                apiData.isSuccess = false;
                apiData.data = 0;
                return apiData;
              }
            } else {
              apiData.message = response!.statusCode.toString();
              apiData.isSuccess = false;
              apiData.data = 0;
              return apiData;
            }
          }
        } else {
          apiData.message = "";
          apiData.isSuccess = false;
          apiData.data = 0;
          return apiData;
        }
      }
    }
  }

  Future<APIDataClass> postApi(context, String apiName, body,
      {isToken = false}) async {
    //default data to class
    APIDataClass apiData = APIDataClass(
      message: 'No data',
      isSuccess: false,
      data: '0',
    );
    //Check For Internet
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      apiData.message = "No Internet Access";
      apiData.isSuccess = false;
      apiData.data = 0;
      return apiData;
    } else {
      log("URL: $apiName");

      //dio.options.headers["authtoken"] = authtoken;
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString(session.accessToken);
      debugPrint("AUTH : $token");
      debugPrint("AUTH : ${headersToken(token)}");
      try {
        final response = await dio.post(
          apiName,
          data: jsonEncode(body),
          options: Options(headers: isToken ? headersToken(token) : headers),
        );
        log("response : $response");
        var responseData = response.data;
        log("response : $response");
        if (response.statusCode == 200) {
          //get response

          if (apiName.contains("ExchangeToken")) {
            log("RESPONSE : ${response.data}");

            //set data to class
            apiData.message = responseData['StatusText'];
            apiData.isSuccess = true;
            apiData.data = responseData['data'] ?? "";
            return apiData;
          } else {
            //set data to class
            log("RESPONSE :2 ${response.data}");
            apiData.message = responseData["StatusText"] ?? "";
            apiData.isSuccess = true;
            apiData.data = responseData["data"];
            return apiData;
          }
        } else {
          log("RESPONJSE 1: ${response.data}");
          apiData.message = responseData["StatusText"];
          apiData.isSuccess = false;
          apiData.data = 0;
          return apiData;
        }
      } catch (e) {
        if (e is DioException) {
          if (e.type == DioExceptionType.badResponse) {
            final response = e.response;
            if (response != null && response.data != null) {
              if (response.data['StatusCode'] == 1001 ||
                  response.data['StatusCode'] == 1002 ||
                  response.data['StatusCode'] == 1003 ||
                  response.data['StatusCode'] == 1004 ||
                  response.data['StatusCode'] == 1005) {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return PopScope(
                          canPop: false,
                          child: Dialog(
                              insetPadding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.s20),
                              backgroundColor: appColor(context).appTheme.trans,
                              child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(AppRadius.r8),
                                      color: appColor(context)
                                          .appTheme
                                          .whiteColor),
                                  width: double.infinity,
                                  height: Sizes.s150,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                  language(
                                                      context,
                                                      appFonts
                                                          .yourSessionHasExpired),
                                                  style: appCss
                                                      .philosopherBold18
                                                      .textColor(
                                                          appColor(context)
                                                              .appTheme
                                                              .oneText)),
                                              Text(
                                                  language(
                                                      context,
                                                      appFonts
                                                          .pleaseLogInAgain),
                                                  style: appCss.dmDenseRegular16
                                                      .textColor(
                                                          appColor(context)
                                                              .appTheme
                                                              .lightText))
                                            ]),
                                        CommonButton(
                                            width: Sizes.s120,
                                            text: 'Ok',
                                            onTap: () async {
                                              try {
                                                await apiServices
                                                    .getApi(
                                                        context, api.logout, [],
                                                        isToken: true)
                                                    .then((value) async {
                                                  final prefs =
                                                      await SharedPreferences
                                                          .getInstance();

                                                  if (value.isSuccess!) {
                                                    if (await prefs.clear()) {
                                                      await FirebaseAuth
                                                          .instance
                                                          .signOut()
                                                          .then((value) async {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return const LoginAuthScreen();
                                                        }));
                                                      });
                                                    }
                                                  }
                                                });
                                              } catch (e) {
                                                log('error $e');
                                              }
                                            })
                                      ]))));
                    });
                return apiData;
              } else {
                apiData.message = response.data['StatusText'];
                apiData.isSuccess = false;
                apiData.data = 0;
                return apiData;
              }
            } else {
              if (response?.data['StatusCode'] == 1001) {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return PopScope(
                          canPop: false,
                          child: Dialog(
                              insetPadding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.s20),
                              backgroundColor: appColor(context).appTheme.trans,
                              child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(AppRadius.r8),
                                      color: appColor(context)
                                          .appTheme
                                          .whiteColor),
                                  width: double.infinity,
                                  height: Sizes.s150,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                  language(
                                                      context,
                                                      appFonts
                                                          .yourSessionHasExpired),
                                                  style: appCss
                                                      .philosopherBold18
                                                      .textColor(
                                                          appColor(context)
                                                              .appTheme
                                                              .oneText)),
                                              Text(
                                                  language(
                                                      context,
                                                      appFonts
                                                          .pleaseLogInAgain),
                                                  style: appCss.dmDenseRegular16
                                                      .textColor(
                                                          appColor(context)
                                                              .appTheme
                                                              .lightText))
                                            ]),
                                        CommonButton(
                                            width: Sizes.s120,
                                            text: 'Ok',
                                            onTap: () async {
                                              try {
                                                await apiServices
                                                    .getApi(
                                                        context, api.logout, [],
                                                        isToken: true)
                                                    .then((value) async {
                                                  final prefs =
                                                      await SharedPreferences
                                                          .getInstance();

                                                  if (value.isSuccess!) {
                                                    if (await prefs.clear()) {
                                                      await FirebaseAuth
                                                          .instance
                                                          .signOut()
                                                          .then((value) async {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return const LoginAuthScreen();
                                                        }));
                                                      });
                                                    }
                                                  }
                                                });
                                              } catch (e) {
                                                log('error $e');
                                              }
                                            })
                                      ]))));
                    });
                return apiData;
              } else {
                apiData.message = response?.data['StatusText'];
                apiData.isSuccess = false;
                apiData.data = 0;
                return apiData;
              }
            }
          } else {
            final response = e.response;
            if (response != null && response.data != null) {
              final Map responseData =
                  json.decode(response.data as String) as Map;
              if (response.data['StatusCode'] == 1001 ||
                  response.data['StatusCode'] == 1002 ||
                  response.data['StatusCode'] == 1003 ||
                  response.data['StatusCode'] == 1004 ||
                  response.data['StatusCode'] == 1005) {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return PopScope(
                          canPop: false,
                          child: Dialog(
                              insetPadding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.s20),
                              backgroundColor: appColor(context).appTheme.trans,
                              child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(AppRadius.r8),
                                      color: appColor(context)
                                          .appTheme
                                          .whiteColor),
                                  width: double.infinity,
                                  height: Sizes.s150,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                  language(
                                                      context,
                                                      appFonts
                                                          .yourSessionHasExpired),
                                                  style: appCss
                                                      .philosopherBold18
                                                      .textColor(
                                                          appColor(context)
                                                              .appTheme
                                                              .oneText)),
                                              Text(
                                                  language(
                                                      context,
                                                      appFonts
                                                          .pleaseLogInAgain),
                                                  style: appCss.dmDenseRegular16
                                                      .textColor(
                                                          appColor(context)
                                                              .appTheme
                                                              .lightText))
                                            ]),
                                        CommonButton(
                                            width: Sizes.s120,
                                            text: 'Ok',
                                            onTap: () async {
                                              try {
                                                await apiServices
                                                    .getApi(
                                                        context, api.logout, [],
                                                        isToken: true)
                                                    .then((value) async {
                                                  final prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  if (value.isSuccess!) {
                                                    if (await prefs.clear()) {
                                                      await FirebaseAuth
                                                          .instance
                                                          .signOut()
                                                          .then((value) async {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return const LoginAuthScreen();
                                                        }));
                                                      });
                                                    }
                                                  }
                                                });
                                              } catch (e) {
                                                log('error $e');
                                              }
                                            })
                                      ]))));
                    });
                return apiData;
              } else {
                apiData.message = responseData['StatusText'] as String;
                apiData.isSuccess = false;
                apiData.data = 0;
                return apiData;
              }
            } else {
              apiData.message = response!.statusCode.toString();
              apiData.isSuccess = false;
              apiData.data = 0;
              return apiData;
            }
          }
        } else {
          apiData.message = "";
          apiData.isSuccess = false;
          apiData.data = 0;
          return apiData;
        }
      }
    }
  }
}

Exception handleErrorResponse(http.Response response) {
  var data = jsonDecode(response.body);

  return RemoteException(
      statusCode: response.statusCode,
      message: data['message'] ?? response.statusCode == 422
          ? 'Validation failed'
          : 'Server exception');
}
