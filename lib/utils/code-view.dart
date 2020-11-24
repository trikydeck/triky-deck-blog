import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/dracula.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_highlight/themes/googlecode.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:markdown/markdown.dart' as m;

class SourceCodeView extends StatefulWidget {
  final String url;
  SourceCodeView({Key key, this.url}) : super(key: key);
  @override
  _SourceCodeViewState createState() => _SourceCodeViewState();
}

class _SourceCodeViewState extends State<SourceCodeView> {
  @override
  void initState() {
    load();
    super.initState();
  }

  String md = '';

  @override
  Widget build(BuildContext context) {
    return md.isEmpty
        ? LinearProgressIndicator()
        : HighlightView(
            md,
            language: 'dart',
            theme: googlecodeTheme,
            padding: EdgeInsets.all(12),
            textStyle: GoogleFonts.firaCode(),
          );
  }

  void load() async {
    try {
      var res = await http.read(widget.url);
      setState(() {
        md = res;
      });
    } catch (e) {
      setState(() {
        md = e.toString();
      });
    }
  }
}
