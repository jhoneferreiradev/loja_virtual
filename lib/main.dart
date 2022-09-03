import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loja_virtual/screens/base_screen.dart';
import 'package:loja_virtual/screens/login/login_screen.dart';
import 'package:loja_virtual/screens/product/product_screen.dart';
import 'package:loja_virtual/screens/signup/signup_screen.dart';
import 'package:loja_virtual/service/product_service.dart';
import 'package:loja_virtual/service/user_service.dart';
import 'package:provider/provider.dart';
import 'domain/product.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserService(), lazy: false),
        ChangeNotifierProvider(create: (_) => ProductService(), lazy: false),
      ],
      child: MaterialApp(
        title: 'Loja Virtual',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 4, 125, 141),
          scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
          appBarTheme: const AppBarTheme(
            color: Color.fromARGB(255, 4, 125, 141),
            elevation: 0,
          ),
        ),
        initialRoute: BaseScreen.route_name,
        onGenerateRoute: (route) {
          switch (route.name) {
            case LoginScreen.route_name:
              return MaterialPageRoute(builder: (_) => LoginScreen());
            case SignUpScreen.route_name:
              return MaterialPageRoute(builder: (_) => SignUpScreen());
            case ProductScreen.route_name:
              return MaterialPageRoute(builder: (_) => ProductScreen(product: route.arguments as Product));
            case BaseScreen.route_name:
            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}
