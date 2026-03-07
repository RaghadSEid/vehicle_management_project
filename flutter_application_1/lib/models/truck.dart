import 'package:flutter_application_1/models/engine.dart';
import 'package:flutter_application_1/models/enums.dart';
import 'package:flutter_application_1/models/vehicle.dart';

class Truck extends Vehicle {
  double? _freeWeight;
  double? _fullWeight;

  Truck() {}
  Truck.full(
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
    double freeWeight,
    double fullWeight,
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
    _freeWeight = freeWeight;
    _fullWeight = fullWeight;
  }

  double? get freeWeight => _freeWeight;
  double? get fullWeight => _fullWeight;

  set freeWeight(double value) {
    _freeWeight = value;
  }

  set fullWeight(double value) {
    _fullWeight = value;
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
      'freeWeight': freeWeight,
      'fullWeight': fullWeight,
    };
  }

  factory Truck.fromJson(Map<String, dynamic> json) {
    return Truck.full(
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
      json['freeWeight'],
      json['fullWeight'],
    );
  }
}
