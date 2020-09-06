import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

class RegisterData {
  final String name;
  final String password;

  RegisterData({
    @required this.name,
    @required this.password,
  });

  @override
  String toString() {
    return '$runtimeType($name, $password)';
  }

  bool operator ==(Object other) {
    if (other is RegisterData) {
      return name == other.name && password == other.password;
    }
    return false;
  }

  int get hashCode => hash2(name, password);
}
