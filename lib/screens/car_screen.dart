import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/vehicle_manager.dart';
import 'package:flutter_application_1/models/car.dart';
import 'package:flutter_application_1/models/engine.dart';
import 'package:flutter_application_1/models/enums.dart';

class CarScreen extends StatefulWidget {
  final VehicleManager manager;

  const CarScreen({super.key, required this.manager});

  @override
  State<CarScreen> createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {
  final company = TextEditingController();
  final model = TextEditingController();
  final plate = TextEditingController();
  final length = TextEditingController();
  final width = TextEditingController();
  final color = TextEditingController();
  final chairs = TextEditingController();

  bool leather = false;
  int? editingIndex;

  Future<void> saveCar() async {
    final engine = Engine.full(
      "Engine",
      DateTime.now(),
      "V6",
      2000,
      6,
      FuelType.gasoline,
    );

    final car = Car.full(
      company.text,
      DateTime.now(),
      model.text,
      engine,
      int.parse(plate.text),
      GearType.automatic,
      DateTime.now().millisecondsSinceEpoch,
      int.parse(length.text),
      int.parse(width.text),
      color.text,
      int.parse(chairs.text),
      leather,
    );

    if (editingIndex == null) {
      await widget.manager.addCar(car);
    } else {
      await widget.manager.updateCar(editingIndex!, car);
      editingIndex = null;
    }

    clearFields();
    setState(() {});
  }

  void editCar(int index) {
    final car = widget.manager.cars[index];

    company.text = car.manufactureCompany ?? "";
    model.text = car.model ?? "";
    plate.text = car.plateNum.toString();
    length.text = car.length.toString();
    width.text = car.width.toString();
    color.text = car.color ?? "";
    chairs.text = car.chairNum.toString();
    leather = car.isFurnitureLeather ?? false;

    editingIndex = index;

    setState(() {});
  }

  Future<void> deleteCar(int index) async {
    final car = widget.manager.cars[index];

    await widget.manager.removeCar(car);

    setState(() {});
  }

  void clearFields() {
    company.clear();
    model.clear();
    plate.clear();
    length.clear();
    width.clear();
    color.clear();
    chairs.clear();

    leather = false;
  }

  @override
  Widget build(BuildContext context) {
    final cars = widget.manager.cars;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Car Management",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 15),

          TextField(
            controller: company,
            decoration: const InputDecoration(labelText: "Company"),
          ),

          TextField(
            controller: model,
            decoration: const InputDecoration(labelText: "Model"),
          ),

          TextField(
            controller: plate,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Plate Number"),
          ),

          TextField(
            controller: length,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Length"),
          ),

          TextField(
            controller: width,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Width"),
          ),

          TextField(
            controller: color,
            decoration: const InputDecoration(labelText: "Color"),
          ),

          TextField(
            controller: chairs,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Number of Chairs"),
          ),

          Row(
            children: [
              const Text("Leather Furniture"),
              Checkbox(
                value: leather,
                onChanged: (value) {
                  setState(() {
                    leather = value ?? false;
                  });
                },
              ),
            ],
          ),

          const SizedBox(height: 10),

          ElevatedButton(
            onPressed: saveCar,
            child: Text(editingIndex == null ? "Add Car" : "Update Car"),
          ),

          const SizedBox(height: 25),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cars.length,
            itemBuilder: (context, index) {
              final car = cars[index];

              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: const Icon(
                    Icons.directions_car,
                    color: Colors.blue,
                    size: 32,
                  ),

                  title: Text(
                    "${car.manufactureCompany} - ${car.model}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  subtitle: Text(
                    "Plate: ${car.plateNum} | Color: ${car.color}",
                  ),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.orange),
                        onPressed: () => editCar(index),
                      ),

                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteCar(index),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
