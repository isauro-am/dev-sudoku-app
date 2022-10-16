import 'package:flutter/material.dart';

import '../services/drawer.dart';
import '../services/services.dart';

class CustomPageTemplate extends StatefulWidget {
  final String title;
  final String background;
  final Size size;
  final Widget child;
  final bool appBar;
  final Color color;

  const CustomPageTemplate({
    Key? key,
    required this.title,
    required this.background,
    required this.size,
    required this.child,
    required this.appBar,
    required this.color,
  }) : super(key: key);

  @override
  State<CustomPageTemplate> createState() => _CustomPageTemplateState();
}

class _CustomPageTemplateState extends State<CustomPageTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (widget.appBar) ? customAppBar(true, widget.title) : null,
      body: Container(
        color: customColors.menu,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(
                  minWidth: 330, maxWidth: 500, minHeight: 400, maxHeight: 600),
              decoration: BoxDecoration(
                color: widget.color,
                image: DecorationImage(
                  image: AssetImage(widget.background),
                  fit: BoxFit.cover,
                ),
              ),
              height: widget.size.height,
              width: widget.size.width,
              // color: customColors.background,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
