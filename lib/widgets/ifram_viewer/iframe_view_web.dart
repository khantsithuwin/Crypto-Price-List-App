import 'package:flutter/material.dart';
import 'dart:ui_web' as ui;
import 'dart:html';

class IframeViewer extends StatefulWidget {
  const IframeViewer({super.key, required this.link});

  final String link;

  @override
  State<IframeViewer> createState() => _IframeViewerState();
}

class _IframeViewerState extends State<IframeViewer> {
  final IFrameElement _iFrameElement = IFrameElement();

  @override
  void initState() {
    super.initState();
    _iFrameElement.style.height = "100%";
    _iFrameElement.style.width = "100%";
    _iFrameElement.src = widget.link;
    _iFrameElement.style.border = "none";
    ui.platformViewRegistry.registerViewFactory(
      widget.link,
      (_) => _iFrameElement,
    );
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: widget.link);
  }
}
