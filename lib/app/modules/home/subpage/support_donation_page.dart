import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:chaldea/generated/l10n.dart';
import 'package:chaldea/packages/logger.dart';
import 'package:chaldea/packages/split_route/split_route.dart';
import 'package:chaldea/utils/constants.dart';
import 'package:chaldea/utils/extension.dart';
import 'package:chaldea/widgets/markdown_page.dart';

class SupportDonationPage extends StatelessWidget {
  SupportDonationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(S.current.support_chaldea, maxLines: 1),
        titleSpacing: 0,
        actions: [
          IconButton(
            onPressed: () {
              launch('$kProjectDocRoot/donation.html');
            },
            icon: const FaIcon(FontAwesomeIcons.github),
            tooltip: 'Github',
          )
        ],
      ),
      body: FutureBuilder<String?>(
        future: MarkdownHelpPage.loadHelpAsset(
            asset: 'support.md', lapse: kSplitRouteDuration),
        builder: (context, snapshot) {
          return Markdown(
            data: snapshot.data ?? '',
            selectable: true,
            imageBuilder: imageBuilder,
            onTapLink: onTapLink,
          );
        },
      ),
    );
  }

  void onTapLink(String text, String? href, String title) async {
    if (href?.isNotEmpty != true) return;
    try {
      await launch(href!);
    } catch (e) {
      logger.e('Markdown link: cannot launch "$href", '
          'text="$text", title="$title"');
      EasyLoading.showError('Cannot launch url:\n$href');
    }
  }

  Widget imageBuilder(Uri uri, String? title, String? alt) {
    if (uri.scheme == 'http' || uri.scheme == 'https') {
      return Image.network(uri.toString(), width: 200);
    } else if (uri.scheme == 'resource') {
      return Image.asset(uri.toString().substring(9).trimCharLeft('/'),
          width: 200);
    } else {
      throw UnimplementedError('Uri $uri not supported');
    }
  }
}
