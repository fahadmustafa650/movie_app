import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/models/mqtt_app_state.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTManagerController extends GetxController {
  // Private instance of client
  final _currentState = MQTTAppState().obs;
  MqttServerClient? _client;
  late String _identifier;
  String? _host;
  String _topic = "";

  void initializeMQTTClient({
    required String host,
    required String identifier,
  }) {
    // Save the values
    // TODO: If already connected throw error
    // TODO: Remove forced unwrap usage and assertion
    _identifier = identifier;
    _host = host;
    _client = MqttServerClient(_host!, _identifier);
    _client!.port = 1883;
    _client!.keepAlivePeriod = 20;
    _client!.onDisconnected = onDisconnected;
    _client!.secure = false;
    _client!.logging(on: true);

    /// Add the successful connection callback
    _client!.onConnected = onConnected;
    _client!.onSubscribed = onSubscribed;
    _client!.onUnsubscribed = onUnsubscribed;

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier(_identifier)
        .withWillTopic(
            'willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        //.authenticateAs(username, password)// Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    print('EXAMPLE::Mosquitto client connecting....');
    _client!.connectionMessage = connMess;
  }

  String? get host => _host;
  MQTTAppState get currentState => _currentState.value;
  // Connect to the host
  void connect() async {
    assert(_client != null);
    try {
      // print('EXAMPLE::Mosquitto start client connecting....');
      _currentState.value
          .setAppConnectionState(MQTTAppConnectionState.connecting);
      // updateState();
      await _client!.connect();
    } on Exception catch (e) {
      // print('EXAMPLE::client exception - $e');
      disconnect();
    }
  }

  void disconnect() {
    print('Disconnected');
    _client!.disconnect();
  }

  void publish(String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);
    _client!.publishMessage(_topic, MqttQos.exactlyOnce, builder.payload!);
  }

  /// The subscribed callback
  void onSubscribed(String topic) {
    print('EXAMPLE::Subscription confirmed for topic $topic');
    _currentState.value
        .setAppConnectionState(MQTTAppConnectionState.connectedSubscribed);
    updateState();
  }

  void onUnsubscribed(String? topic) {
    print('EXAMPLE::onUnsubscribed confirmed for topic $topic');
    _currentState.value.clearText();
    _currentState.value
        .setAppConnectionState(MQTTAppConnectionState.connectedUnSubscribed);
    updateState();
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    print('onDisconnected client callback - Client disconnection');
    if (_client!.connectionStatus!.returnCode ==
        MqttConnectReturnCode.noneSpecified) {
      print('onDisconnected callback is solicited, this is correct');
    }
    _currentState.value.clearText();
    _currentState.value
        .setAppConnectionState(MQTTAppConnectionState.disconnected);
    updateState();
  }

  /// The successful connect callback
  void onConnected() {
    _currentState.value.setAppConnectionState(MQTTAppConnectionState.connected);
    updateState();
    print('EXAMPLE::Mosquitto client connected....');
    _client!.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      final String pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message!);
      _currentState.value.setReceivedText(pt);
      updateState();
      print(
          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      print('');
    });
    print(
        'EXAMPLE::OnConnected client callback - Client connection was sucessful');
  }

  void subScribeTo(String topic) {
    // Save topic for future use
    _topic = topic;
    final sub = _client!.subscribe(topic, MqttQos.atLeastOnce);
    if (kDebugMode) {
      print("subScribeTo:${sub!.messageIdentifier}");
    }
  }

  /// Unsubscribe from a topic
  void unSubscribe(String topic) {
    _client!.unsubscribe(topic);
  }

  /// Unsubscribe from a topic
  void unSubscribeFromCurrentTopic() {
    _client!.unsubscribe(_topic);
  }

  void updateState() {
    //controller.add(_currentState);
    update();
  }
}
