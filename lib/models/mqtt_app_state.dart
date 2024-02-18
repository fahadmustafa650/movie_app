import 'package:get/get.dart';

enum MQTTAppConnectionState {
  connected,
  disconnected,
  connecting,
  connectedSubscribed,
  connectedUnSubscribed
}

class MQTTAppState {
  final _appConnectionState = MQTTAppConnectionState.disconnected.obs;
  String _receivedText = '';
  String _historyText = '';

  void setReceivedText(String text) {
    _receivedText = text;
    _historyText = _historyText + '\n' + _receivedText;
  }

  void setAppConnectionState(MQTTAppConnectionState state) {
    _appConnectionState.value = state;
    print("setAppConnectionState:${state.name}");
  }

  void clearText() {
    _historyText = "";
    _receivedText = "";
  }

  String get getReceivedText => _receivedText;
  String get getHistoryText => _historyText;
  MQTTAppConnectionState get getAppConnectionState => _appConnectionState.value;
}
