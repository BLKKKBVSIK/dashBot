import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commander/commander.dart';

import 'commands/dart/exec_dart.dart';
import 'commands/flutter/exec_flutter.dart';
import 'misc/config.dart' as config;

void main() {
  var bot = Nyxx(config.token!, options: ClientOptions(shardCount: 1));

  bot.onReady.listen((ReadyEvent e) {
    print('Ready !');
    bot.setPresence(
      PresenceBuilder.of(
        game: Activity.of('${config.prefix}dart | ${config.prefix}flutter',
            type: ActivityType.listening),
      ),
    );
  });

  Commander(bot, prefix: config.prefix)
    ..registerCommand('flutter', execFlutter);
}
