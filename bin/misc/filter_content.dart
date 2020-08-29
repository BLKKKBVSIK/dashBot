import 'config.dart' as config;

String filterContent(String content) {
  String filteredContent;
  
  filteredContent = content.substring(config.prefix!.length + 'flutter '.length);
  return filteredContent;
}