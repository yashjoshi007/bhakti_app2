import 'package:bhakti_app/config.dart';

class KrishnaSadhakaUrl extends StatefulWidget {
  const KrishnaSadhakaUrl({super.key});

  @override
  State<KrishnaSadhakaUrl> createState() => _KrishnaSadhakaUrlState();
}

class _KrishnaSadhakaUrlState extends State<KrishnaSadhakaUrl> {
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (context, homeScreenPvr, child) {
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..loadRequest(Uri.parse(homeScreenPvr.krishnaSadhaka!.replaceAll(
            '{{bhakti_steps_access_key}}', homeScreenPvr.bhaktiAccessKey!)))
        ..setNavigationDelegate(NavigationDelegate(
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.startsWith(homeScreenPvr.krishnaSadhaka!
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
              title: Text(language(context,appFonts.krishnaSadhaka)),
              backgroundColor: appColor(context).appTheme.primary),
          body: WebViewWidget(controller: controller));
    });
  }
}
