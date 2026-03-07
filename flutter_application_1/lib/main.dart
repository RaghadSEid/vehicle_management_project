import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/vehicle_manager.dart';
import 'package:flutter_application_1/models/car.dart';
import 'package:flutter_application_1/models/engine.dart';
import 'package:flutter_application_1/models/enums.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final manager = VehicleManager();
  await manager.loadData();

  runApp(MyApp(manager: manager));
}

class MyApp extends StatelessWidget {
  final VehicleManager manager;

  const MyApp({super.key, required this.manager});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vehicle Management System',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(manager: manager),
    );
  }
}

class HomePage extends StatefulWidget {
  final VehicleManager manager;

  const HomePage({super.key, required this.manager});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final companyController = TextEditingController();
  final modelController = TextEditingController();
  final plateController = TextEditingController();
  final colorController = TextEditingController();
  final lengthController = TextEditingController();
  final widthController = TextEditingController();

  int? editingIndex;

  Future<void> addOrUpdateCar() async {
    final engine = Engine.full(
      "Engine",
      DateTime.now(),
      "V6",
      2000,
      6,
      FuelType.gasoline,
    );

    final car = Car.full(
      companyController.text,
      DateTime.now(),
      modelController.text,
      engine,
      int.parse(plateController.text),
      GearType.automatic,
      DateTime.now().millisecondsSinceEpoch,
      int.parse(lengthController.text),
      int.parse(widthController.text),
      colorController.text,
      5,
      true,
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

  void clearFields() {
    companyController.clear();
    modelController.clear();
    plateController.clear();
    colorController.clear();
    lengthController.clear();
    widthController.clear();
  }

  void editCar(int index) {
    final car = widget.manager.cars[index];

    companyController.text = car.manufactureCompany ?? "";
    modelController.text = car.model ?? "";
    plateController.text = car.plateNum.toString();
    colorController.text = car.color ?? "";
    lengthController.text = car.length.toString();
    widthController.text = car.width.toString();

    editingIndex = index;
  }

  Future<void> deleteCar(int index) async {
    await widget.manager.removeCar(widget.manager.cars[index]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cars = widget.manager.cars;

    return Scaffold(
      appBar: AppBar(title: const Text("Vehicle Management System")),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Add / Update Car",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            TextField(
              controller: companyController,
              decoration: const InputDecoration(labelText: "Company"),
            ),

            TextField(
              controller: modelController,
              decoration: const InputDecoration(labelText: "Model"),
            ),

            TextField(
              controller: plateController,
              decoration: const InputDecoration(labelText: "Plate Number"),
              keyboardType: TextInputType.number,
            ),

            TextField(
              controller: colorController,
              decoration: const InputDecoration(labelText: "Color"),
            ),

            TextField(
              controller: lengthController,
              decoration: const InputDecoration(labelText: "Length"),
              keyboardType: TextInputType.number,
            ),

            TextField(
              controller: widthController,
              decoration: const InputDecoration(labelText: "Width"),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: addOrUpdateCar,
              child: Text(editingIndex == null ? "Add Car" : "Update Car"),
            ),

            const SizedBox(height: 20),

            const Text(
              "Cars List",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: cars.length,
                itemBuilder: (context, index) {
                  final car = cars[index];

                  return Card(
                    child: ListTile(
                      title: Text("${car.manufactureCompany} - ${car.model}"),
                      subtitle: Text(
                        "Plate: ${car.plateNum} | Color: ${car.color}",
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => editCar(index),
                          ),

                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => deleteCar(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
