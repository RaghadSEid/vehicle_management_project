import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/vehicle_manager.dart';
import 'package:flutter_application_1/models/truck.dart';
import 'package:flutter_application_1/models/engine.dart';
import 'package:flutter_application_1/models/enums.dart';

class TruckScreen extends StatefulWidget {
  final VehicleManager manager;

  const TruckScreen({super.key, required this.manager});

  @override
  State<TruckScreen> createState() => _TruckScreenState();
}

class _TruckScreenState extends State<TruckScreen> {
  final company = TextEditingController();
  final model = TextEditingController();
  final plate = TextEditingController();
  final length = TextEditingController();
  final width = TextEditingController();
  final color = TextEditingController();
  final freeWeight = TextEditingController();
  final fullWeight = TextEditingController();

  int? editingIndex;

  Future<void> saveTruck() async {
    final engine = Engine.full(
      "Truck Engine",
      DateTime.now(),
      "V8",
      5000,
      8,
      FuelType.diesel,
    );

    final truck = Truck.full(
      company.text,
      DateTime.now(),
      model.text,
      engine,
      int.parse(plate.text),
      GearType.normal,
      DateTime.now().millisecondsSinceEpoch,
      int.parse(length.text),
      int.parse(width.text),
      color.text,
      double.parse(freeWeight.text),
      double.parse(fullWeight.text),
    );

    if (editingIndex == null) {
      await widget.manager.addTruck(truck);
    } else {
      await widget.manager.updateTruck(editingIndex!, truck);
      editingIndex = null;
    }

    clearFields();
    setState(() {});
  }

  void editTruck(int index) {
    final truck = widget.manager.trucks[index];

    company.text = truck.manufactureCompany ?? "";
    model.text = truck.model ?? "";
    plate.text = truck.plateNum.toString();
    length.text = truck.length.toString();
    width.text = truck.width.toString();
    color.text = truck.color ?? "";
    freeWeight.text = truck.freeWeight.toString();
    fullWeight.text = truck.fullWeight.toString();

    editingIndex = index;

    setState(() {});
  }

  Future<void> deleteTruck(int index) async {
    final truck = widget.manager.trucks[index];

    await widget.manager.removeTruck(truck);

    setState(() {});
  }

  void clearFields() {
    company.clear();
    model.clear();
    plate.clear();
    length.clear();
    width.clear();
    color.clear();
    freeWeight.clear();
    fullWeight.clear();
  }

  @override
  Widget build(BuildContext context) {
    final trucks = widget.manager.trucks;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Truck Management",
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
            controller: freeWeight,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Free Weight"),
          ),

          TextField(
            controller: fullWeight,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Full Weight"),
          ),

          const SizedBox(height: 10),

          ElevatedButton(
            onPressed: saveTruck,
            child: Text(editingIndex == null ? "Add Truck" : "Update Truck"),
          ),

          const SizedBox(height: 25),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: trucks.length,
            itemBuilder: (context, index) {
              final truck = trucks[index];

              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: const Icon(
                    Icons.local_shipping,
                    color: Colors.green,
                    size: 32,
                  ),

                  title: Text(
                    "${truck.manufactureCompany} - ${truck.model}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  subtitle: Text(
                    "Plate: ${truck.plateNum} | Color: ${truck.color}",
                  ),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.orange),
                        onPressed: () => editTruck(index),
                      ),

                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteTruck(index),
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
