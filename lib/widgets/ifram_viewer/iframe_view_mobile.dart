import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class IframeViewer extends StatefulWidget {
  const IframeViewer({super.key, required this.link});

  final String link;

  @override
  State<IframeViewer> createState() => _IframeViewerState();
}

class _IframeViewerState extends State<IframeViewer> {
  final WebViewController _controller = WebViewController();

  @override
  void initState() {
    super.initState();
    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    _controller.loadRequest(Uri.parse(widget.link));
    print(widget.link);
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
