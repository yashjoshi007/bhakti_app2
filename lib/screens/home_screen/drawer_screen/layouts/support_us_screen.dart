import 'package:bhakti_app/screens/home_screen/update_profile/layouts/update_name_text_form_field.dart';
import 'package:bhakti_app/screens/path_list.dart';
import 'package:flutter_pay_upi/flutter_pay_upi_manager.dart';
import 'package:flutter_pay_upi/model/upi_ios_model.dart';
import 'package:bhakti_app/config.dart';
import 'package:flutter_pay_upi/model/upi_response.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

class SupportUsScreen extends StatefulWidget {
  const SupportUsScreen({super.key});

  @override
  State<SupportUsScreen> createState() => _SupportUsScreenState();
}

class _SupportUsScreenState extends State<SupportUsScreen> {
  final String upiUrl =
      "upi://pay?pa=pateljeel9537@okicici&pn=JEEL PATEL&am=10&cu=INR";

  TextEditingController amountController = TextEditingController();

  void _launchUpi() {
    FlutterPayUpiManager.startPayment(
        paymentApp: 'Google Pay',
        payeeVpa: 'pateljeel9537-1@okicici',
        payeeName: 'JEEL PATEL',
        transactionId: '',
        payeeMerchantCode: '',
        description: 'testing',
        amount: amountController.text,
        response: (UpiResponse response, String? error) {
          if (error != null) {
            // Handle error
            print('Error: $error');
          } else {
            // Handle success
            print('Success: ${response.transactionID}');
          }
        },
        error: (e) {
          // TODO: add your exception logic here
          print(e.toString());
        });
  }

  void _launchPayPal() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckoutView(
        sandboxMode: true,
        clientId: "YOUR CLIENT ID",
        secretKey: "YOUR SECRET KEY",
        transactions: [
          {
            "amount": {
              "total": amountController.text,
              "currency": "USD",
              // "details": {
              //   "subtotal": '100',
              //   "shipping": '0',
              //   "shipping_discount": 0
              // }
            },
            "description": "The payment transaction description.",
            "item_list": {
              "items": [
                {
                  "name": "Sadhana App",
                  "quantity": 1,
                  "price": amountController.text,
                  "currency": "USD"
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

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (context, homeScreenPvr, child) {
      return Stack(children: [
        Scaffold(
            body: RefreshIndicator(
                onRefresh: () => homeScreenPvr.refreshData(context),
                child: CommonBgWidget().commonBgImage(SingleChildScrollView(
                    child: Column(children: [
                  CommonAppBar(
                      hSpace: Insets.i80,
                      text: language(context, appFonts.supportUs),
                      onTap: () => Navigator.pop(context)),
                  Center(
                    child: Image.asset(eImageAssets.sadhanaLogo,
                        fit: BoxFit.cover, height: Sizes.s240),
                  ),
                  const VSpace(Sizes.s40),
                  Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CustomTitleWidget(
                          height: Sizes.s52,
                          width: double.infinity,
                          title: "Amount",
                          color: appColor(context)
                              .appTheme
                              .primary
                              .withOpacity(.20),
                          radius: AppRadius.r8,
                          child: TextFieldCommon(
                            hintText: "INR / USD",
                            errorText: "Enter Valid Amount",
                            controller: amountController,
                          ))),
                  ElevatedButton(
                    //upi://pay?pa=CongregationDevelopmentMinistry@icici&pn=Congregation Development Ministry&tr=ATC8101880342&cu=INR&mc=5172
                    onPressed: _launchUpi,
                    child: const Text('Donate via GPay'),
                  ),
                  const VSpace(Sizes.s20),
                  ElevatedButton(
                    onPressed: _launchPayPal,
                    child: Text('Donate via PayPal'),
                  ),
                ]))))),
        if (homeScreenPvr.isLoading) const CommonLoading()
      ]);
    });
  }
}
