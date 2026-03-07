import 'package:flutter_application_1/models/automobile.dart';
import 'package:flutter_application_1/models/engine.dart';
import 'package:flutter_application_1/models/enums.dart';

class Motorcycle extends Automobile {
  double? _tierDiameter;
  double? _length;

  Motorcycle() {}
  Motorcycle.full(
    String manufactureCompany,
    DateTime manufactureDate,
    String model,
    Engine engine,
    int plateNum,
    GearType gearType,
    int bodySerialNum,
    double tierDiameter,
    double length,
  ) : super.full(
        manufactureCompany,
        manufactureDate,
        model,
        engine,
        plateNum,
        gearType,
        bodySerialNum,
      ) {
    _tierDiameter = tierDiameter;
    _length = length;
  }

  double? get tierDiameter => _tierDiameter;
  double? get length => _length;

  set tierDiameter(double? value) {
    _tierDiameter = value;
  }

  set length(double? value) {
    _length = value;
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
      'tierDiameter': tierDiameter,
      'length': length,
    };
  }

  factory Motorcycle.fromJson(Map<String, dynamic> json) {
    return Motorcycle.full(
      json['manufactureCompany'],
      DateTime.parse(json['manufactureDate']),
      json['model'],
      Engine.fromJson(json['engine']),
      json['plateNum'],
      json['gearType'] == 'GearType.normal'
          ? GearType.normal
          : GearType.automatic,
      json['bodySerialNum'],
      json['tierDiameter'],
      json['length'],
    );
  }
}
