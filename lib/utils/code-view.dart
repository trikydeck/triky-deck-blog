import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:triky_deck/utils/constants.dart';
import 'package:triky_deck/utils/syntax-highlighter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/services.dart' show rootBundle;

class SourceCodeView extends StatefulWidget {
  final int id;
  SourceCodeView({Key key, this.id}) : super(key: key);
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
    return Center(
      child: Div(
        colM: 8,
        colL: 6,
        colS: 11,
        child: md.isEmpty
            ? LinearProgressIndicator(
                backgroundColor: Get.theme.primaryColor,
              )
            : MarkdownBody(
                data: md,
                shrinkWrap: true,
                onTapLink: (text, url, title) {
                  launch(url, webOnlyWindowName: '_blank');
                },
                styleSheet: MarkdownStyleSheet(
                  code: GoogleFonts.firaCode(
                    fontSize: 16,
                    color: Colors.pink[300],
                  ),
                  codeblockAlign: WrapAlignment.center,
                  a: GoogleFonts.sourceSansPro(
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                  ),
                  codeblockPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  codeblockDecoration: BoxDecoration(
                    color: Get.isDarkMode ? Colors.grey[800] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  blockquotePadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  blockquoteDecoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? Colors.lightBlue[800]
                        : Colors.lightBlue[300],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  blockSpacing: 15,
                  blockquote: GoogleFonts.ubuntu(fontSize: 16),
                  h1: GoogleFonts.cabin(letterSpacing: 1.5),
                  h2: GoogleFonts.cabin(letterSpacing: 1.5),
                  h3: GoogleFonts.cabin(letterSpacing: 1.5),
                  h4: GoogleFonts.cabin(letterSpacing: 1.5),
                  h5: GoogleFonts.cabin(letterSpacing: 1.5),
                  h6: GoogleFonts.cabin(letterSpacing: 1.5),
                  p: GoogleFonts.sourceSansPro(fontSize: 16),
                  listBullet: GoogleFonts.lato(),
                ),
                imageBuilder: (uri, s, ss) => Center(
                  child: Div(
                    colS: 11,
                    colM: 8,
                    colL: 6,
                    child: CachedNetworkImage(
                      imageUrl: uri.toString(),
                      fit: BoxFit.contain,
                      imageBuilder: (_, img) {
                        return Card(
                          elevation: 4,
                          child: InkWell(
                            onTap: () {
                              Get.to(_ImagePreviewer(preview: uri));
                            },
                            child: Hero(
                              tag: 'preview',
                              child: Image(image: img),
                            ),
                          ),
                        );
                      },
                      placeholder: (_, s) => SpinKitPulse(
                        itemBuilder: (c, i) {
                          return CircleAvatar(
                            backgroundImage: AssetImage(
                              trikyImg,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                syntaxHighlighter: DartSyntaxHighlighter(Get.isDarkMode
                    ? SyntaxHighlighterStyle.darkThemeStyle()
                    : null),
              ),
      ),
    );
  }

  void load() async {
    try {
      // var res = await rootBundle.loadString('lib/decks/1/readme.md');

      var res = await http.read(
          "https://raw.githubusercontent.com/trikydeck/triky-deck-blog/master/lib/decks/${widget.id}/readme.md");
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

class _ImagePreviewer extends StatelessWidget {
  final Uri preview;

  const _ImagePreviewer({Key key, this.preview}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'preview',
      child: Material(
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: preview.toString(),
              fit: BoxFit.contain,
              imageBuilder: (_, img) {
                return PhotoView(
                  imageProvider: img,
                );
              },
              placeholder: (_, s) => SpinKitPulse(
                itemBuilder: (c, i) {
                  return CircleAvatar(
                    backgroundImage: AssetImage(
                      trikyImg,
                    ),
                  );
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.close),
              color: Colors.white,
              onPressed: Get.back,
            )
          ],
        ),
      ),
    );
  }
}
