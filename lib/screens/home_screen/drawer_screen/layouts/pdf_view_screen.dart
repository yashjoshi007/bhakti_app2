import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:bhakti_app/config.dart';

class PdfViewerScreen extends StatelessWidget {
  final String filePath;
  final String fileName;

  const PdfViewerScreen(
      {super.key, required this.fileName, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: SvgPicture.asset(eSvgAssets.arrowLeft,
                    colorFilter: ColorFilter.mode(
                        appColor(context).appTheme.whiteBg, BlendMode.srcIn))
                .marginSymmetric(vertical: 15)
                .inkWell(onTap: () => Navigator.pop(context)),
            title: Text(fileName, style: appCss.dmDenseBlack16),
            backgroundColor: appColor(context).appTheme.primary),
        body: PDFView(filePath: filePath));
  }
}
