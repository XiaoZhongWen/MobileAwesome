import 'package:assassin_flutter_module/channels/application_configuration_channel.dart';
import 'package:assassin_flutter_module/pages/me/models/account.dart';

class ShareActionProvider {
  ShareActionProvider({this.publisherId});

  final String publisherId;

  bool isPublisher() {
    Account account = ApplicationConfigurationChannel.shared.fetchAccountSync();
    if (account != null && account.username == publisherId) {
      return true;
    } else {
      return false;
    }
  }
}