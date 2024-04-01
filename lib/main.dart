import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_texi_app/utils/routes/route_names.dart';
import 'package:new_texi_app/view-models/dashboard_view_model.dart';

import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'utils/routes/route.dart';
import 'view-models/firebase_auth_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirebaseAuthViewModel()),
       
        ChangeNotifierProvider(create: (_) => DashboardViewMode()),
      ],
      child: const MaterialApp(
        title: 'Texi App',
        // theme: MyThemes.lightTheme(),
        // home: const LoginView(),
        debugShowCheckedModeBanner: false,
        initialRoute: RouteNames.splash,
        onGenerateRoute: Routes.onGenerateRoutes,
      ),
    );
  }
}
