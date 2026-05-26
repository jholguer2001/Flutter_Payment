import 'package:flutter/material.dart';
import 'package:payment_flow_00/ui/screens/payment_details_screen.dart';
import 'package:payment_flow_00/ui/screens/payment_method_screen.dart';
import 'package:payment_flow_00/ui/screens/successful_screen.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xff050060)),
        ),
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff34495E),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              color: Colors.white,
            )
          )
        )
      ),
      initialRoute: '/',
      title: 'Flujo de Pago',
      routes: {
        '/': (context) =>  const PaymentMethodScreen(),
        '/payment_details': (context) => const PaymentDetailsScreen(),
        '/payment_successful': (context) => const SuccessfulScreen()
      },
    );
  }
}