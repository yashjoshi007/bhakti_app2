import 'package:bhakti_app/config.dart';

class RegulationsWebView extends StatefulWidget {
  const RegulationsWebView({super.key});

  @override
  State<RegulationsWebView> createState() => _RegulationsWebViewState();
}

class _RegulationsWebViewState extends State<RegulationsWebView> {
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (context, homeScreenPvr, child) {
          controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..loadRequest(Uri.parse(homeScreenPvr.regulationsHelpURL!.replaceAll(
            '{{bhakti_steps_access_key}}', homeScreenPvr.bhaktiAccessKey!)))
        ..setNavigationDelegate(NavigationDelegate(
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.startsWith(homeScreenPvr.regulationsHelpURL!
                  .replaceAll('{{bhakti_steps_access_key}}',
                      homeScreenPvr.bhaktiAccessKey!))) {
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
            onPageFinished: (url) {},
            onUrlChange: (change) {}));
      return Scaffold(
          appBar: AppBar(
              title: const Text('Regulations Help'),
              backgroundColor: appColor(context).appTheme.primary),
          body: WebViewWidget(controller: controller));
    });
  }
}
