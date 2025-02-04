import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:bhakti_app/common/theme/app_css.dart';
import 'package:bhakti_app/config.dart';
import 'package:flutter_pay_upi/flutter_pay_upi_manager.dart';
import 'package:flutter_pay_upi/model/upi_ios_model.dart';
import 'package:flutter_pay_upi/model/upi_response.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:upi_pay/upi_pay.dart';
import 'package:uuid/uuid.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool isLoading = false; // State to manage loading
  TextEditingController amountController = TextEditingController();
  String selectedCurrency = 'INR'; // Default currency selection
  List<Map<String, dynamic>>? supportUsOptions;
  late Future<List<UpiIosModel>> apps;
  final Uuid uuid = Uuid();


  @override
  void initState() {
    super.initState();
    fetchSupportUsOptions();
    apps = FlutterPayUpiManager.getListOfIosUpiApps();
    apps.then((appList) {
      for (var app in appList) {
        print("App Name: ${app.appName}");
      }
    }).catchError((error) {
      print("Error fetching UPI apps: $error");
    });
  }

  Future<void> fetchSupportUsOptions() async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(minutes: 5),
      ));
      await remoteConfig.fetchAndActivate();

      String supportUsData = remoteConfig.getString('SupportUs');
      List<dynamic> supportUsList = jsonDecode(supportUsData);
      print(supportUsList);
      setState(() {
        supportUsOptions = supportUsList
            .map((item) => Map<String, dynamic>.from(item))
            .toList();
      });
    } catch (e) {
      // Handle errors and display fallback UI
      print("Error fetching SupportUs data: $e");
    }
  }

  Future<void> listAndLaunchApps(String amount) async {
    if (supportUsOptions == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Payment options not loaded yet",
            style: TextStyle(color: appColor(context).appTheme.primary),
          ),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true; // Show loading indicator
    });

    // Fetch UPI details dynamically
    final upiOption = supportUsOptions?.firstWhere(
      (option) =>
          option['type'] == 'UPI' &&
          option['currencies'].contains(selectedCurrency),
    );

    if (upiOption != null) {
      final String upiUrl =
          "upi://pay?pa=${upiOption['account']}&pn=${upiOption['attributes']['pn']}&cu=$selectedCurrency&am=$amount";

      List<String> upiApps = [
        'com.google.android.apps.nbu.paisa.user', // Google Pay
        'net.one97.paytm', // Paytm
        'com.phonepe.app', // PhonePe
      ];

      for (String app in upiApps) {
        final uri = Uri.parse(upiUrl);
        // print("yash- $uri");
        try {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
          setState(() {
            isLoading = false; // Stop loading when app is launched
          });
          return;
        } catch (e) {
          print("App not available: $app");
        }
      }
    }

    setState(() {
      isLoading = false; // Stop loading if no app is found
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "No compatible UPI apps found!",
          style: TextStyle(color: appColor(context).appTheme.primary),
        ),
      ),
    );
  }

  void _launchUpi(String amount) {

    if (supportUsOptions == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Payment options not loaded yet",
            style: TextStyle(color: appColor(context).appTheme.primary),
          ),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true; // Show loading indicator
    });

    // Fetch UPI details dynamically
    final upiOption = supportUsOptions?.firstWhere(
          (option) =>
      option['type'] == 'UPI' &&
          option['currencies'].contains(selectedCurrency),
    );

    if (upiOption != null) {
      print("transaction id =");
      var tn = uuid.v4();
      // print(tn);
      String upiapp = '';

      apps.then((appList) {
        // Check if 'Google Pay' exists in the appList
        var googlePayApp = appList.firstWhere(
              (app) => app.appName == 'Google Pay',
          orElse: () => UpiIosModel(appName: ''), // Return null if not found
        );
        print(googlePayApp);

        // If 'Google Pay' exists, assign it; otherwise, use appList[1].appName
        upiapp = googlePayApp.appName == ''
            ? 'Google Pay'
            : (appList.length > 2 ? appList[2].appName ?? '' : '');

        // Debug print to confirm selection
        print('Selected UPI app: $upiapp');

        if (upiapp.isNotEmpty) {
          FlutterPayUpiManager.startPayment(
            paymentApp: upiapp,
            payeeVpa: upiOption['account'],
            payeeName: upiOption['attributes']['pn'],
            transactionId: tn,
            payeeMerchantCode: '5172',
            description: 'Donation',
            amount: amount,
            response: (UpiResponse response, String? error) {
              if (error != null) {
                print('Error: $error');
              } else {
                print('Success: ${response.transactionID}');
              }
            },
            error: (e) {
              print(e.toString());
            },
          );
        } else {
          print('No valid UPI app found');
        }
      });
    }

    setState(() {
      isLoading = false; // Stop loading if no app is found
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "No compatible UPI apps found!",
          style: TextStyle(color: appColor(context).appTheme.primary),
        ),
      ),
    );
  }

  void _launchPaypal(String amount){
    if (supportUsOptions == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Payment options not loaded yet",
            style: TextStyle(color: appColor(context).appTheme.primary),
          ),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true; // Show loading indicator
    });

    // Fetch UPI details dynamically
    final upiOption = supportUsOptions?.firstWhere(
          (option) =>
      option['type'] == 'PAYPAL' &&
          option['currencies'].contains(selectedCurrency),
    );

    if(upiOption != null) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            PaypalCheckoutView(
              sandboxMode: true,
              clientId: upiOption['attributes']['clientId'],
              secretKey: upiOption['attributes']['secret'],
              transactions: [
                {
                  "amount": {
                    "total": amount,
                    "currency": selectedCurrency,
                    // "details": {
                    //   "subtotal": '100',
                    //   "shipping": '0',
                    //   "shipping_discount": 0
                    // }
                  },
                  "description": "Donation",
                  "item_list": {
                    "items": [
                      {
                        "name": "Sadhana App",
                        "quantity": 1,
                        "price": amount,
                        "currency": selectedCurrency
                      },
                    ],
                  }
                }
              ],
              note: "Contact us for any questions on your order.",
              onSuccess: (Map params) async {
                print("onSuccess: $params");
                Navigator.pop(context);
              },
              onError: (error) {
                print("onError: $error");
                Navigator.pop(context);
              },
              onCancel: () {
                print('cancelled:');
                Navigator.pop(context);
              },
            ),
      ));
    }
    setState(() {
      isLoading = false; // Stop loading if no app is found
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  CommonAppBar(
                    hSpace: Insets.i80,
                    text: language(context, appFonts.supportUs),
                    onTap: () => Navigator.pop(context),
                  ),
                  Center(
                    child: Image.asset(eImageAssets.sadhanaLogo,
                        fit: BoxFit.cover, height: Sizes.s240),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.currency_exchange),
                            SizedBox(width: 10),
                            Text('Choose Currency',
                                style: appCss.dmDenseRegular18.textColor(
                                    appColor(context).appTheme.primary)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'INR',
                                  groupValue: selectedCurrency,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedCurrency = value!;
                                    });
                                  },
                                  fillColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return appColor(context)
                                            .appTheme
                                            .primary; // Selected color
                                      }
                                      return Colors.grey; // Unselected color
                                    },
                                  ),
                                ),
                                Text(
                                  'INR',
                                  style: appCss.dmDenseRegular16.textColor(
                                      appColor(context).appTheme.primary),
                                ),
                              ],
                            ),
                            SizedBox(
                                width:
                                    16.0), // Add spacing between the two options
                            Row(
                              children: [
                                Radio<String>(
                                  value: 'USD',
                                  groupValue: selectedCurrency,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedCurrency = value!;
                                    });
                                  },
                                  fillColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return appColor(context)
                                            .appTheme
                                            .primary; // Selected color
                                      }
                                      return Colors.grey; // Unselected color
                                    },
                                  ),
                                ),
                                Text(
                                  'USD',
                                  style: appCss.dmDenseRegular16.textColor(
                                      appColor(context).appTheme.primary),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextFieldCommon(
                              controller: amountController,
                              hintText: "Amount",
                              errorText: "Enter Valid Amount",
                              keyboardType: TextInputType.numberWithOptions(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  CommonButton(
                    width: 100,
                    bColor: isLoading
                        ? appColor(context).appTheme.primary.withOpacity(0.5)
                        : appColor(context).appTheme.primary,
                    onTap: isLoading
                        ? null
                        : () async {
                            final String amount = amountController.text.trim();
                            if (amount.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Please enter an amount",
                                    style: TextStyle(
                                        color:
                                            appColor(context).appTheme.primary),
                                  ),
                                ),
                              );
                            } else if (double.tryParse(amount) == null ||
                                double.parse(amount) <= 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Please enter a valid amount",
                                    style: TextStyle(
                                        color:
                                            appColor(context).appTheme.primary),
                                  ),
                                ),
                              );
                            } else {
                              if (selectedCurrency == 'INR') {
                                if(Platform.isIOS){
                                  _launchUpi(amount);
                                }else {
                                  await listAndLaunchApps(amount);
                                }
                              } else {
                                _launchPaypal(amount);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "PayPal payment coming soon!",
                                      style: TextStyle(
                                          color: appColor(context)
                                              .appTheme
                                              .primary),
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                    text: language(context, appFonts.donate),
                  ),
                ],
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
