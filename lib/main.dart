import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String title = 'Call Android Code';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData.dark().copyWith(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              minimumSize: const Size.fromHeight(52),
              textStyle: const TextStyle(fontSize: 20),
            ),
          ),
        ),
        home: const MainPage(),
      );
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const batteryChannel = MethodChannel('kentaShimizu.com/battery');

  String batteryLevel = 'Waiting...';

  Future getBatteryLevel() async {
    final arguments = {'name': 'Sarah Abs'};
    final String newBatteryLevel =
        await batteryChannel.invokeMethod('getBatteryLevel', arguments);
    setState(() => batteryLevel = newBatteryLevel);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                batteryLevel,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 30, color: Colors.blue),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: getBatteryLevel,
                child: const Text('Get Battery Level'),
              ),
            ],
          ),
        ),
      );
}
