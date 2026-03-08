import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/vehicle_manager.dart';

import 'screens/car_screen.dart';
import 'screens/truck_screen.dart';
import 'screens/motorcycle_screen.dart';

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
      title: "Vehicle Manager",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(manager: manager),
    );
  }
}

class HomePage extends StatelessWidget {
  final VehicleManager manager;

  const HomePage({super.key, required this.manager});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Vehicle Management System"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Cars"),
              Tab(text: "Trucks"),
              Tab(text: "Motorcycles"),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            CarScreen(manager: manager),
            TruckScreen(manager: manager),
            MotorcycleScreen(manager: manager),
          ],
        ),
      ),
    );
  }
}
