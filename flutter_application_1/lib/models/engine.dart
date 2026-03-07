import 'enums.dart';

class Engine {
  String? _manufacture;
  DateTime? _manufactureDate;
  String? _model;
  int? _capacity;
  int? _cylinders;
  FuelType? _fuelType;

  Engine() {}

  Engine.full(
    String manufacture,
    DateTime manufactureDate,
    String model,
    int capacity,
    int cylinders,
    FuelType fuelType,
  ) {
    _manufacture = manufacture;
    _manufactureDate = manufactureDate;
    _model = model;
    _capacity = capacity;
    _cylinders = cylinders;
    _fuelType = fuelType;
  }

  String? get manufacture => _manufacture;
  DateTime? get manufactureDate => _manufactureDate;
  String? get model => _model;
  int? get capacity => _capacity;
  int? get cylinders => _cylinders;
  FuelType? get fuelType => _fuelType;

  set manufacture(String? value) {
    _manufacture = value;
  }

  set manufactureDate(DateTime? value) {
    _manufactureDate = value;
  }

  set model(String? value) {
    _model = value;
  }

  set capacity(int? value) {
    _capacity = value;
  }

  set cylinders(int? value) {
    _cylinders = value;
  }

  set fuelType(FuelType? value) {
    _fuelType = value;
  }

  Map<String, dynamic> toJson() {
    return {
      'manufacture': _manufacture,
      'manufactureDate': _manufactureDate.toString(),
      'model': _model,
      'capacity': _capacity,
      'cylinders': _cylinders,
      'fuelType': _fuelType.toString(),
    };
  }

  factory Engine.fromJson(Map<String, dynamic> json) {
    return Engine.full(
      json['manufacture'],
      DateTime.parse(json['manufactureDate']),
      json['model'],
      json['capacity'],
      json['cylinders'],
      json['fuelType'] == 'FuelType.diesel'
          ? FuelType.diesel
          : FuelType.gasoline,
    );
  }
}
