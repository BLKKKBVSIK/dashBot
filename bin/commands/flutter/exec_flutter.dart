import 'package:nyxx_commander/commander.dart';
import '../../misc/filter_content.dart';

Future<void> execFlutter(CommandContext ctx, String content) async {
  content = filterContent(content);
}