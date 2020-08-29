import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commander/commander.dart';
import '../../misc/filter_content.dart';
import 'dart:convert' as convert;
import '../../misc/post_gist.dart';

Future<void> execFlutter(CommandContext ctx, String content) async {
  final stopwatch = Stopwatch()..start();
  final footer = EmbedFooterBuilder()..text = 'Exec time: pending...';
  final embed = EmbedBuilder()
    ..title = 'Result'
    ..color = DiscordColor.flutterBlue
    ..addField(
        name: 'Render - Flutter',
        content: 'Your code is being processed\nPlease wait...',
        inline: true)
    ..footer = footer;

  content = filterContent(content);

  final message = await ctx.reply(embed: embed);

  final response = await postGist(content);
  if (response.statusCode == 201) {
    final res = convert.jsonDecode(response.body);

    final footer = EmbedFooterBuilder()
      ..text = 'Exec time: ${stopwatch.elapsedMilliseconds} ms';
    embed..url = 'https://dartpad.dartlang.org/${res['id']}';
    embed
      ..replaceField(
          name: 'Render - Flutter',
          content:
              'Your render is available by clicking on the link or at this address\nhttps://dartpad.dartlang.org/${res['id']}',
          inline: true);
    embed..footer = footer;

    await message.edit(embed: embed);
  } else {
     final footer = EmbedFooterBuilder()
      ..text = 'Exec time: Failed.';
    embed..url = 'https://www.githubstatus.com/';
    embed
      ..color = DiscordColor.red
      ..replaceField(
          name: 'Render - Flutter',
          content:
              'Failed to call Github REST Api (v3) on endpoint:\nhttps://api.github.com/gists',
          inline: true);
    embed..footer = footer;
  }
}
