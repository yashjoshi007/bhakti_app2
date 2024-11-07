import 'package:bhakti_app/config.dart';

class ACBhaktiVedantaUrl extends StatefulWidget {
  const ACBhaktiVedantaUrl({super.key});

  @override
  State<ACBhaktiVedantaUrl> createState() => _ACBhaktiVedantaUrlState();
}

class _ACBhaktiVedantaUrlState extends State<ACBhaktiVedantaUrl> {
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (context, homeScreenPvr, child) {
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..loadRequest(Uri.parse(homeScreenPvr.aCBhaktiVedantaSwami!.replaceAll(
            '{{bhakti_steps_access_key}}', homeScreenPvr.bhaktiAccessKey!)))
        ..setNavigationDelegate(NavigationDelegate(
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.startsWith(homeScreenPvr.aCBhaktiVedantaSwami!
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
              title: Text(language(context, appFonts.aCBhaktiVedantaSwami)),
              backgroundColor: appColor(context).appTheme.primary),
          body: WebViewWidget(controller: controller));
    });
  }
}
