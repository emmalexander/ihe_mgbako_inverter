import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ihe_mgbako_inverter/provider/hive_provider.dart';
import 'package:ihe_mgbako_inverter/provider/ui_provider.dart';
import 'package:ihe_mgbako_inverter/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'model/database_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize hive
  await Hive.initFlutter();
  //register the generated hive adapter class
  Hive.registerAdapter(DatabaseModelAdapter());
  //open a hive box
  await Hive.openBox<DatabaseModel>('database');

  runApp(const MyApp());
}
//

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UIProvider(),
        ),
        ChangeNotifierProvider(create: (context) => HiveProvider())
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        designSize: const Size(392, 781),
        builder: (context, index) => MaterialApp(
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            );
          },
          routes: AppRoutes.routes,
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
        ),
      ),
    );
  }
}
