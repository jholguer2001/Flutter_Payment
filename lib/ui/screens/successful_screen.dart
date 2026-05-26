import 'package:flutter/material.dart';
import 'package:payment_flow_00/ui/screens/payment_details_screen.dart';

class SuccessfulScreen extends StatelessWidget {
  const SuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 300,
            decoration: const BoxDecoration(
              color: Color(0XFF34495E),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60),
              ),
            ),
            child: Center(child: Image.asset('assets/woman.png', height: 200)),
          ),
          const SizedBox(height: 30),
          Image.asset('assets/done.png', height: 60),
          const SizedBox(height: 30),

          const Text(
            'Gracias por su compra',
            style: TextStyle(
              color: Color(0Xff000000),
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),

          const Text(
            'Su orden será entregada en \n 2-4 días laborables',
            style: TextStyle(
              color: Color(0Xff000000),
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),

      floatingActionButton: ElevatedButton(
        onPressed: () {
          _doNothing(context);
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: const Text('CONTINUAR COMPRANDO'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

void _doNothing(BuildContext context) {}

class MyArguments {
  String name = '';
  String cardNumber = '';
  String expiryDate = '';
  String cvvCode = '';
  bool savedCard = false;

  MyArguments({
    required this.name,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvvCode,
    required this.savedCard,
  });

  @override
  String toString() {
    return 'MyArguments: {"$name, $cardNumber, $expiryDate, $cvvCode, $savedCard}';
  }
}
