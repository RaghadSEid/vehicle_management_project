import 'package:flutter_application_1/models/automobile.dart';
import 'package:flutter_application_1/models/engine.dart';
import 'package:flutter_application_1/models/enums.dart';

class Vehicle extends Automobile {
  int? _length;
  int? _width;
  String? _color;

  Vehicle() {}
  Vehicle.full(
    String manufactureCompany,
    DateTime manufactureDate,
    String model,
    Engine engine,
    int plateNum,
    GearType gearType,
    int bodySerialNum,
    int length,
    int width,
    String color,
  ) : super.full(
        manufactureCompany,
        manufactureDate,
        model,
        engine,
        plateNum,
        gearType,
        bodySerialNum,
      ) {
    _length = length;
    _width = width;
    _color = color;
  }

  int? get length => _length;
  int? get width => _width;
  String? get color => _color;

  set length(int? value) {
    _length = value;
  }

  set width(int? value) {
    _width = value;
  }

  set color(String? value) {
    _color = value;
  }

  Map<String, dynamic> toJson() {
    return {
      'manufactureCompany': manufactureCompany,
      'manufactureDate': manufactureDate.toString(),
      'model': model,
      'engine': engine?.toJson(),
      'plateNum': plateNum,
      'gearType': gearType.toString(),
      'bodySerialNum': bodySerialNum,
      'length': length,
      'width': width,
      'color': color,
    };
  }

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle.full(
      json['manufactureCompany'],
      DateTime.parse(json['manufactureDate']),
      json['model'],
      Engine.fromJson(json['engine']),
      json['plateNum'],
      json['gearType'] == 'GearType.normal'
          ? GearType.normal
          : GearType.automatic,
      json['bodySerialNum'],
      json['length'],
      json['width'],
      json['color'],
    );
  }
}
