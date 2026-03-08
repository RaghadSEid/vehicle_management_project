import 'package:flutter_application_1/models/engine.dart';
import 'package:flutter_application_1/models/enums.dart';
import 'package:flutter_application_1/models/vehicle.dart';

class Car extends Vehicle {
  int? _chairNum;
  bool? _isFurnitureLeather;

  Car() {}
  Car.full(
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
    int chairNum,
    bool isFurnitureLeather,
  ) : super.full(
        manufactureCompany,
        manufactureDate,
        model,
        engine,
        plateNum,
        gearType,
        bodySerialNum,
        length,
        width,
        color,
      ) {
    _chairNum = chairNum;
    _isFurnitureLeather = isFurnitureLeather;
  }
  int? get chairNum => _chairNum;
  bool? get isFurnitureLeather => _isFurnitureLeather;

  set chairNum(int? value) {
    _chairNum = value;
  }

  set isFurnitureLeather(bool? value) {
    _isFurnitureLeather = value;
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
      'chairNum': chairNum,
      'isFurnitureLeather': isFurnitureLeather,
    };
  }

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car.full(
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
      json['chairNum'],
      json['isFurnitureLeather'],
    );
  }
}
