import 'enums.dart';
import 'engine.dart';

class Automobile {
  String? _manufactureCompany;
  DateTime? _manufactureDate;
  String? _model;
  Engine? _engine;
  int? _plateNum;
  GearType? _gearType;
  int? _bodySerialNum;

  Automobile() {}

  Automobile.full(
    String manufactureCompany,
    DateTime manufactureDate,
    String model,
    Engine engine,
    int plateNum,
    GearType gearType,
    int bodySerialNum,
  ) {
    _manufactureCompany = manufactureCompany;
    _manufactureDate = manufactureDate;
    _model = model;
    _engine = engine;
    _plateNum = plateNum;
    _gearType = gearType;
    _bodySerialNum = bodySerialNum;
  }

  String? get manufactureCompany => _manufactureCompany;
  DateTime? get manufactureDate => _manufactureDate;
  String? get model => _model;
  Engine? get engine => _engine;
  int? get plateNum => _plateNum;
  GearType? get gearType => _gearType;
  int? get bodySerialNum => _bodySerialNum;

  set manufactureCompany(String? value) {
    _manufactureCompany = value;
  }

  set manufactureDate(DateTime? value) {
    _manufactureDate = value;
  }

  set model(String? value) {
    _model = value;
  }

  set engine(Engine? value) {
    _engine = value;
  }

  set plateNum(int? value) {
    _plateNum = value;
  }

  set gearType(GearType? value) {
    _gearType = value;
  }

  set bodySerialNum(int? value) {
    _bodySerialNum = value;
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
    };
  }

  factory Automobile.fromJson(Map<String, dynamic> json) {
    return Automobile.full(
      json['manufactureCompany'],
      DateTime.parse(json['manufactureDate']),
      json['model'],
      Engine.fromJson(json['engine']),
      json['plateNum'],
      json['gearType'] == 'GearType.normal'
          ? GearType.normal
          : GearType.automatic,
      json['bodySerialNum'],
    );
  }
}
