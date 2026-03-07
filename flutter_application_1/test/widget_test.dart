import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/services/vehicle_manager.dart';

void main() {
  testWidgets('App loads', (WidgetTester tester) async {
    final manager = VehicleManager();

    await tester.pumpWidget(MyApp(manager: manager));

    expect(find.text('Vehicle Management System Ready'), findsOneWidget);
  });
}
