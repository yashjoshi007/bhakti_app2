import 'package:bhakti_app/config.dart';

class BhaktiStepsUrl extends StatefulWidget {
  const BhaktiStepsUrl({super.key});

  @override
  State<BhaktiStepsUrl> createState() => _BhaktiStepsUrlState();
}

class _BhaktiStepsUrlState extends State<BhaktiStepsUrl> {
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (context, homeScreenPvr, child) {
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..loadRequest(Uri.parse(homeScreenPvr.bhaktiSteps!.replaceAll(
            '{{bhakti_steps_access_key}}', homeScreenPvr.bhaktiAccessKey!)))
        ..setNavigationDelegate(NavigationDelegate(
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.startsWith(homeScreenPvr.bhaktiSteps!.replaceAll(
                  '{{bhakti_steps_access_key}}',
                  homeScreenPvr.bhaktiAccessKey!))) {
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
            onPageFinished: (url) {},
            onUrlChange: (change) {}));
      return Scaffold(
          appBar: AppBar(
              title: Text(language(context, appFonts.bhaktiSteps)),
              backgroundColor: appColor(context).appTheme.primary),
          body: WebViewWidget(controller: controller));
    });
  }
}
