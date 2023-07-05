import 'dart:async';
import 'package:flutter/material.dart';

enum ColorEvent { eventBlue, eventGreen }

class ColorBloc {
  Color _color = Colors.blue;

  final _inputEventController = StreamController<ColorEvent>();
  StreamSink<ColorEvent> get inputEventSink => _inputEventController.sink;

  final _outputStateController = StreamController<Color>();
  Stream<Color> get outputStateStream => _outputStateController.stream;

  void _mapEventToState(ColorEvent event) {
    if (event == ColorEvent.eventBlue) {
      _color = Colors.blue;
    } else if (event == ColorEvent.eventGreen) {
      _color = Colors.green;
    } else {
      throw Exception('Wrong Event Type');
    }

    _outputStateController.sink.add(_color);
  }

  ColorBloc() {
    _inputEventController.stream.listen(_mapEventToState);
  }

  void dispose() {
    _inputEventController.close();
    _outputStateController.close();
  }
}
