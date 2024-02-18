import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/constants/app_const.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/strings.dart';
import 'package:movie_app/controllers/mqtt_manager_controller.dart';
import 'package:movie_app/models/mqtt_app_state.dart';

class MqttScreen extends StatefulWidget {
  const MqttScreen({super.key});

  @override
  State<MqttScreen> createState() => _MqttScreenState();
}

class _MqttScreenState extends State<MqttScreen> {
  final _mqttManagerController = Get.put(MQTTManagerController());
  final _textScrollcontroller = ScrollController();
  final _messageTextController = TextEditingController();

  final _topicTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_textScrollcontroller.hasClients) {
      _textScrollcontroller
          .jumpTo(_textScrollcontroller.position.maxScrollExtent);
    }
    final buttonStyle =
        ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green));
    const textStyle = TextStyle(color: MyColors.whiteColor);
    return SafeArea(
      child: Scaffold(
          appBar: _appBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildConnectBtn(buttonStyle, textStyle),
                    const SizedBox(
                      height: 20.0,
                    ),
                    _buildTopicField(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Obx(
                      () => ElevatedButton(
                          onPressed: () {
                            _subscribeTopic();
                          },
                          style: buttonStyle,
                          child: Center(
                              child: Text(
                            _mqttManagerController
                                        .currentState.getAppConnectionState ==
                                    MQTTAppConnectionState.connectedSubscribed
                                ? MyStrings.unSub
                                : MyStrings.subToTopic,
                            style: textStyle,
                          ))),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: _messageTextController,
                      minLines: 3,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: MyStrings.enterMsg,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                      ),
                      onChanged: (value) {},
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    _publishMsgBtn(buttonStyle, textStyle),
                    Obx(
                      () => _buildScrollableTextWith(
                          _mqttManagerController.currentState.getHistoryText),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  //----------------------------------------------------------------------------
  ElevatedButton _publishMsgBtn(ButtonStyle buttonStyle, TextStyle textStyle) {
    return ElevatedButton(
        onPressed: _mqttManagerController.currentState.getAppConnectionState ==
                MQTTAppConnectionState.connectedSubscribed
            ? () {
                _publishMessage(_messageTextController.text);
              }
            : null,
        style: buttonStyle,
        child: Center(
            child: Text(
          MyStrings.pubMsg,
          style: textStyle,
        )));
  }

  //----------------------------------------------------------------------------
  ElevatedButton _buildConnectBtn(
      ButtonStyle buttonStyle, TextStyle textStyle) {
    return ElevatedButton(
        onPressed: _configureAndConnect,
        style: buttonStyle,
        child: Center(
            child: Obx(
          () => Text(
            _mqttManagerController.currentState.getAppConnectionState ==
                    MQTTAppConnectionState.connected
                ? MyStrings.connected
                : MyStrings.connMqttBroker,
            style: textStyle,
          ),
        )));
  }

  //---------------------------------------------------------------
  void _publishMessage(String text) {
    String osPrefix = 'Flutter';

    final String message = '$osPrefix says: $text';
    _mqttManagerController.publish(message);
    _messageTextController.clear();
    setState(() {});
  }

  //---------------------------------------------------------------
  void _subscribeTopic() {
    final connState = _mqttManagerController.currentState.getAppConnectionState;

    if (connState == MQTTAppConnectionState.connectedSubscribed ||
        connState == MQTTAppConnectionState.connectedUnSubscribed ||
        connState == MQTTAppConnectionState.connected) {
      _handleSubscribePress(connState);
    } else {}
  }

  //---------------------------------------------------------------
  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      title: const Text("MQTT",
          style: TextStyle(
            color: MyColors.blackColor,
            fontSize: 25.0,
          )),
    );
  }

  //---------------------------------------------------------------
  void _handleSubscribePress(MQTTAppConnectionState state) {
    if (state == MQTTAppConnectionState.connectedSubscribed) {
      _mqttManagerController.unSubscribeFromCurrentTopic();
    } else {
      String enteredText = _topicTextController.text;
      if (enteredText.isNotEmpty) {
        _mqttManagerController.subScribeTo(_topicTextController.text);
      } else {
        // _showDialog("Please enter a topic.");
      }
    }
  }

  //--------------------------------------------------------
  TextFormField _buildTopicField() {
    return TextFormField(
      controller: _topicTextController,
      decoration: InputDecoration(
        hintText: MyStrings.enterTopic,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
      onChanged: (value) {},
    );
  }

  //--------------------------------------------------------
  void _configureAndConnect() {
    if (_mqttManagerController.currentState.getAppConnectionState ==
        MQTTAppConnectionState.connected) {
      return;
    }
    String osPrefix = 'Flutter_User';

    _mqttManagerController.initializeMQTTClient(
        host: AppConsts.kMqttHostName, identifier: osPrefix);
    _mqttManagerController.connect();
  }

  //--------------------------------------------------------
  Widget _buildScrollableTextWith(String text) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: const EdgeInsets.only(left: 10.0, right: 5.0),
        width: 400,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black12,
        ),
        child: SingleChildScrollView(
          controller: _textScrollcontroller,
          child: Text(text),
        ),
      ),
    );
  }
}
