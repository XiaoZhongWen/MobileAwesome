import 'package:assassin_flutter_module/channels/application_configuration_channel.dart';
import 'package:assassin_flutter_module/pages/me/models/account.dart';

class ShareActionProvider {
  int _index;
  ShareActionProvider(int index, {this.publisherId}) {
    _index = index;
  }

  final String publisherId;

  int get index => _index;

  bool isPublisher() {
    Account account = ApplicationConfigurationChannel.shared.fetchAccountSync();
    if (account != null && account.username == publisherId) {
      return true;
    } else {
      return false;
    }
  }
}