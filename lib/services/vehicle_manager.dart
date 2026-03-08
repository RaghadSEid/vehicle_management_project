import 'package:flutter_application_1/models/car.dart';
import 'package:flutter_application_1/models/motorcycle.dart';
import 'package:flutter_application_1/models/truck.dart';
import 'package:flutter_application_1/services/storage_service.dart';

class VehicleManager {
  final StorageService storage = StorageService();

  List<Car> cars = [];
  List<Motorcycle> motorcycles = [];
  List<Truck> trucks = [];

  Future<void> addCar(Car newCar) async {
    cars.add(newCar);
    await saveData();
  }

  Future<void> addTruck(Truck newTruck) async {
    trucks.add(newTruck);
    await saveData();
  }

  Future<void> addMotorcycle(Motorcycle newMotorcycle) async {
    motorcycles.add(newMotorcycle);
    await saveData();
  }

  Future<void> removeCar(Car car) async {
    cars.remove(car);
    await saveData();
  }

  Future<void> removeTruck(Truck truck) async {
    trucks.remove(truck);
    await saveData();
  }

  Future<void> removeMotorcycle(Motorcycle motorcycle) async {
    motorcycles.remove(motorcycle);
    await saveData();
  }

  Future<void> insertCar(int i, Car car) async {
    cars.insert(i, car);
    await saveData();
  }

  Future<void> insertTruck(int i, Truck truck) async {
    trucks.insert(i, truck);
    await saveData();
  }

  Future<void> insertMotorcycle(int i, Motorcycle motorcycle) async {
    motorcycles.insert(i, motorcycle);
    await saveData();
  }

  Future<void> updateCar(int i, Car updateCar) async {
    cars[i] = updateCar;
    await saveData();
  }

  Future<void> updateTruck(int i, Truck updateTruck) async {
    trucks[i] = updateTruck;
    await saveData();
  }

  Future<void> updateMotorcycle(int i, Motorcycle updateMotorcycle) async {
    motorcycles[i] = updateMotorcycle;
    await saveData();
  }

  List<Car> searchCarByManufactureCompany(String manufactureCompany) {
    List<Car> result = [];
    for (var car in cars) {
      if (car.manufactureCompany == manufactureCompany) result.add(car);
    }
    return result;
  }

  List<Truck> searchTruckByManufactureCompany(String manufactureCompany) {
    List<Truck> result = [];
    for (var truck in trucks) {
      if (truck.manufactureCompany == manufactureCompany) result.add(truck);
    }
    return result;
  }

  List<Motorcycle> searchMotorcycleByManufactureCompany(
    String manufactureCompany,
  ) {
    List<Motorcycle> result = [];
    for (var motorcycle in motorcycles) {
      if (motorcycle.manufactureCompany == manufactureCompany)
        result.add(motorcycle);
    }
    return result;
  }

  List<Car> searchCarByManufactureDate(DateTime manufactureDate) {
    List<Car> result = [];
    for (var car in cars) {
      if (car.manufactureDate == manufactureDate) result.add(car);
    }
    return result;
  }

  List<Truck> searchTruckByManufactureDate(DateTime manufactureDate) {
    List<Truck> result = [];
    for (var truck in trucks) {
      if (truck.manufactureDate == manufactureDate) result.add(truck);
    }
    return result;
  }

  List<Motorcycle> searchMotorcycleByManufactureDate(DateTime manufactureDate) {
    List<Motorcycle> result = [];
    for (var motorcycle in motorcycles) {
      if (motorcycle.manufactureDate == manufactureDate) result.add(motorcycle);
    }
    return result;
  }

  List<Car> searchCarByPlateNumber(int plateNumber) {
    List<Car> result = [];
    for (var car in cars) {
      if (car.plateNum == plateNumber) result.add(car);
    }
    return result;
  }

  List<Truck> searchTruckByPlateNumber(int plateNumber) {
    List<Truck> result = [];
    for (var truck in trucks) {
      if (truck.plateNum == plateNumber) result.add(truck);
    }
    return result;
  }

  List<Motorcycle> searchMotorcycleByPlateNumber(int plateNumber) {
    List<Motorcycle> result = [];
    for (var motorcycle in motorcycles) {
      if (motorcycle.plateNum == plateNumber) result.add(motorcycle);
    }
    return result;
  }

  void printCar(Car car) {
    print('Manufacture Company: ${car.manufactureCompany}');
    print('Manufacture Date: ${car.manufactureDate}');
    print('Model: ${car.model}');
    print('Plate Number: ${car.plateNum}');
    print('Body Serial Number: ${car.bodySerialNum}');
    print('Length: ${car.length}');
    print('Width: ${car.width}');
    print('Color: ${car.color}');
    print('Chair Number: ${car.chairNum}');
    print('Leather Furniture: ${car.isFurnitureLeather}');
  }

  void printTruck(Truck truck) {
    print('Manufacture Company: ${truck.manufactureCompany}');
    print('Manufacture Date: ${truck.manufactureDate}');
    print('Model: ${truck.model}');
    print('Plate Number: ${truck.plateNum}');
    print('Body Serial Number: ${truck.bodySerialNum}');
    print('Length: ${truck.length}');
    print('Width: ${truck.width}');
    print('Color: ${truck.color}');
    print('Free Weight: ${truck.freeWeight}');
    print('Full Weight: ${truck.fullWeight}');
  }

  void printMotorcycle(Motorcycle motorcycle) {
    print('Manufacture Company: ${motorcycle.manufactureCompany}');
    print('Manufacture Date: ${motorcycle.manufactureDate}');
    print('Model: ${motorcycle.model}');
    print('Plate Number: ${motorcycle.plateNum}');
    print('Body Serial Number: ${motorcycle.bodySerialNum}');
    print('Tier Diameter: ${motorcycle.tierDiameter}');
    print('Length: ${motorcycle.length}');
  }

  void printAll() {
    print('Cars : ');
    for (var car in cars) {
      printCar(car);
      print('----------------------');
    }

    print('Trucks : ');
    for (var truck in trucks) {
      printTruck(truck);
      print('----------------------');
    }

    print('Motorcycles : ');
    for (var motorcycle in motorcycles) {
      printMotorcycle(motorcycle);
      print('----------------------');
    }
  }

  Future<void> loadData() async {
    cars = List<Car>.from(
      await storage.loadList("cars", (e) => Car.fromJson(e)),
    );

    trucks = List<Truck>.from(
      await storage.loadList("trucks", (e) => Truck.fromJson(e)),
    );

    motorcycles = List<Motorcycle>.from(
      await storage.loadList("motorcycles", (e) => Motorcycle.fromJson(e)),
    );
  }

  Future<void> saveData() async {
    await storage.saveList("cars", cars);
    await storage.saveList("trucks", trucks);
    await storage.saveList("motorcycles", motorcycles);
  }
}
