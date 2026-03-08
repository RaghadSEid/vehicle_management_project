import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/vehicle_manager.dart';
import 'package:flutter_application_1/models/motorcycle.dart';
import 'package:flutter_application_1/models/engine.dart';
import 'package:flutter_application_1/models/enums.dart';

class MotorcycleScreen extends StatefulWidget {
  final VehicleManager manager;

  const MotorcycleScreen({super.key, required this.manager});

  @override
  State<MotorcycleScreen> createState() => _MotorcycleScreenState();
}

class _MotorcycleScreenState extends State<MotorcycleScreen> {
  final company = TextEditingController();
  final model = TextEditingController();
  final plate = TextEditingController();
  final tierDiameter = TextEditingController();
  final length = TextEditingController();

  int? editingIndex;

  Future<void> saveMotorcycle() async {
    final engine = Engine.full(
      "Motorcycle Engine",
      DateTime.now(),
      "V2",
      800,
      2,
      FuelType.gasoline,
    );

    final motorcycle = Motorcycle.full(
      company.text,
      DateTime.now(),
      model.text,
      engine,
      int.parse(plate.text),
      GearType.normal,
      DateTime.now().millisecondsSinceEpoch,
      double.parse(tierDiameter.text),
      double.parse(length.text),
    );

    if (editingIndex == null) {
      await widget.manager.addMotorcycle(motorcycle);
    } else {
      await widget.manager.updateMotorcycle(editingIndex!, motorcycle);
      editingIndex = null;
    }

    clearFields();
    setState(() {});
  }

  void editMotorcycle(int index) {
    final m = widget.manager.motorcycles[index];

    company.text = m.manufactureCompany ?? "";
    model.text = m.model ?? "";
    plate.text = m.plateNum.toString();
    tierDiameter.text = m.tierDiameter.toString();
    length.text = m.length.toString();

    editingIndex = index;

    setState(() {});
  }

  Future<void> deleteMotorcycle(int index) async {
    final m = widget.manager.motorcycles[index];

    await widget.manager.removeMotorcycle(m);

    setState(() {});
  }

  void clearFields() {
    company.clear();
    model.clear();
    plate.clear();
    tierDiameter.clear();
    length.clear();
  }

  @override
  Widget build(BuildContext context) {
    final motorcycles = widget.manager.motorcycles;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Motorcycle Management",
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
            controller: tierDiameter,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Tier Diameter"),
          ),

          TextField(
            controller: length,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Length"),
          ),

          const SizedBox(height: 10),

          ElevatedButton(
            onPressed: saveMotorcycle,
            child: Text(
              editingIndex == null ? "Add Motorcycle" : "Update Motorcycle",
            ),
          ),

          const SizedBox(height: 25),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: motorcycles.length,
            itemBuilder: (context, index) {
              final m = motorcycles[index];

              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: const Icon(
                    Icons.two_wheeler,
                    color: Colors.purple,
                    size: 32,
                  ),

                  title: Text(
                    "${m.manufactureCompany} - ${m.model}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  subtitle: Text("Plate: ${m.plateNum}"),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.orange),
                        onPressed: () => editMotorcycle(index),
                      ),

                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteMotorcycle(index),
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
