import 'package:flutter/material.dart';

class EventMarkerProvider {
  Icon _currentEventIcon = Icon(Icons.add_circle_outline, size: 75);
  bool _isEventActive = false;
  String _currentEventName = "";

  static final EventMarkerProvider _instance = EventMarkerProvider._internal();

  factory EventMarkerProvider() {
    return _instance;
  }

  EventMarkerProvider._internal() {
  }

  void setCurrentEventName(String name) {
    _currentEventName = name;
  }

  void setCurrentImage(Icon icon) {
    _currentEventIcon = icon;
  }

  void activeEvent() {
    _isEventActive = true;
  }

  void inactiveEvent() {
    _isEventActive = false;
  }

  Icon get currentEventIcon => _currentEventIcon;
  bool get isEventActive => _isEventActive;
  String get currentEventName => _currentEventName;
}