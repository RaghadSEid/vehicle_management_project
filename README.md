# Vehicle Management System

## Project Description

Vehicle Management System is a Flutter application designed to manage different types of vehicles such as Cars, Trucks, and Motorcycles.
The application allows users to add, edit, delete, and display vehicle information using object-oriented programming principles.

The system organizes vehicles into separate models and provides simple user interfaces for managing each vehicle type.

---

## Features

* Add new vehicles (Car, Truck, Motorcycle)
* Edit vehicle information
* Delete vehicles
* Display vehicles in organized lists
* Simple user interface for vehicle management
* Data handling using JSON serialization

---

## OOP Concepts Used

This project applies several Object-Oriented Programming concepts:

**Encapsulation**
Vehicle properties and behaviors are grouped inside classes.

**Inheritance**
Specialized vehicle types such as Car, Truck, and Motorcycle extend the base Automobile class.

**Abstraction**
Common vehicle attributes are defined in the Automobile class and reused by subclasses.

**Composition**
The Engine class is used inside vehicles to represent engine information.

---

## Project Structure

```
lib
 ├── models
 │    ├── automobile.dart
 │    ├── car.dart
 │    ├── truck.dart
 │    ├── motorcycle.dart
 │    ├── engine.dart
 │    └── enums.dart
 │
 ├── services
 │    ├── storage_service.dart
 │    └── vehicle_manager.dart
 │
 ├── screens
 │    ├── car_screen.dart
 │    ├── truck_screen.dart
 │    └── motorcycle_screen.dart
 │
 └── main.dart
```

---

## Main Classes

**Automobile**
Base class that contains general vehicle information such as company, model, plate number, gear type, and engine.

**Car**
Represents a car and adds additional properties such as color, number of seats, and leather interior.

**Truck**
Represents trucks and includes truck-specific attributes.

**Motorcycle**
Represents motorcycles and contains motorcycle-related attributes.

**Engine**
Represents engine specifications like engine type, horsepower, cylinders, and fuel type.

**VehicleManager**
Responsible for adding, updating, removing, and storing vehicles.

---

## How to Run the Project

1. Install Flutter
2. Clone the repository
3. Run the following commands:

```
flutter pub get
flutter run
```

---

## Technologies Used

* Flutter
* Dart
* Object Oriented Programming (OOP)

---

## Author

Vehicle Management System – Flutter OOP Project
