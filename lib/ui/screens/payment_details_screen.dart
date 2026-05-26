import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:payment_flow_00/ui/screens/successful_screen.dart';

class PaymentDetailsScreen extends StatefulWidget {
  const PaymentDetailsScreen({super.key});

  @override
  State<PaymentDetailsScreen> createState(){
    return _PaymentDetailsScreenState();
  }
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  final formKey = GlobalKey<FormState>();

  String name='';
  String cardNumber = '';
  String expiryDate = '';
  String cvvCode = '';
  bool savedCard = false;

  late FocusNode cardNumberFocus;
  late FocusNode expiryDateFocus;
  late FocusNode cvvCodeFocus;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: ListView(
            children: [
              const Text('Detalles de pago',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  const Icon(FontAwesomeIcons.locationDot),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0XFF34495E),
                    ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Icon(FontAwesomeIcons.creditCard),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0XFF707070),
                      ),
                    ),
                  ),
                    const SizedBox(width: 15,),
                    //const Icon(FontAwesomeIcons.check),
                    Image.asset('assets/check_mark.png')
                ],
              ),
              Image.asset('assets/card_persons.png', height: 125,),
              const SizedBox(height: 15,),
              const Text('Ingrese los datos de su trajeta de crédito',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 15,
                color: Color(0XFF6C738A)
              ),),
              const SizedBox(height: 15),
              TextFormField(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
                decoration: CustomInputDecoration('Nombre'),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Ingrese el Nombre';
                  }
                  return null;
                },
                onSaved: (value){
                  name = value!;
                },
                onEditingComplete: () => requestFocus(cardNumberFocus),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 10,),
              TextFormField(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
                decoration: CustomInputDecoration('Número de tarjeta'),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Ingrese el número de tarjeta';
                  }
                  return null;
                },
                onSaved: (value){
                  cardNumber = value!;
                },
                inputFormatters: <TextInputFormatter>[
                  MaskTextInputFormatter(mask: '####-####-####')
                ],
                keyboardType: TextInputType.number,
                focusNode: cardNumberFocus,
                textInputAction: TextInputAction.next,
                onEditingComplete: () => requestFocus(expiryDateFocus),
              ),
              const SizedBox(height: 10,),
              Row(children: [
                Expanded(
                  flex:3,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                    inputFormatters: <TextInputFormatter>[
                      MaskTextInputFormatter(mask: '##/##')
                    ],
                    keyboardType: TextInputType.datetime,
                    decoration: CustomInputDecoration('Fecha de expiración'),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Ingrese la fecha de expiración';
                      }
                      return null;
                    },
                    onSaved: (value){
                      expiryDate = value!;
                    },
                    focusNode: expiryDateFocus,
                    onEditingComplete: () => requestFocus(cvvCodeFocus),
                    ),
                  ),
                  const Expanded(child: SizedBox(width: 20)),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3)
                    ],
                    keyboardType: TextInputType.number,
                    decoration: CustomInputDecoration('cvv'),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Ingrese el código cvv';
                      }
                      return null;
                    },
                    onSaved: (value){
                      expiryDate = value!;
                    },
                    focusNode: cvvCodeFocus,
                    ),
                  ),
              ],
              ),
              const SizedBox(
                height: 10,
                ),
              InkWell(
                onTap: (){
                  setState(() {
                    savedCard = !savedCard;
                  });
                },
                child: Row(
                  children: [
                    Checkbox(value: savedCard, onChanged: ((value){
                      setState(() {
                        savedCard = value!;
                      });
                    })),
                    const Expanded(child: Text('Guardar esa tarjeta para futuras compras?'))
                  ], 
                ),
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                onPressed: (){
                  return showSuccessful(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  )
                ), 
              child: const Text('CONFIRMAR PAGO')
              )
            ],
          ),
        )
        ),
    );
  }

@override
  void initState() {
    super.initState();
    
    cardNumberFocus = FocusNode();
    expiryDateFocus = FocusNode();
    cvvCodeFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    cardNumberFocus.dispose();
    expiryDateFocus.dispose();
    cvvCodeFocus.dispose();
  }

  void requestFocus(FocusNode focusNode){
    FocusScope.of(context).requestFocus(focusNode);
  }
  
  void showSuccessful(BuildContext context){
  if(formKey.currentState!.validate()){
    formKey.currentState?.save();

    MyArguments myArguments = MyArguments(
      name: name, 
      cardNumber: cardNumber, 
      expiryDate: expiryDate, 
      cvvCode: cvvCode, 
      savedCard: savedCard);

      Navigator.pushNamedAndRemoveUntil(context, '/payment_successful', 
      ModalRoute.withName('/payment_successful'), arguments: myArguments);
    }
  }
}

class CustomInputDecoration extends InputDecoration {
  final String inputText;
  CustomInputDecoration(this.inputText)
  : super(
    fillColor: const Color(0XFFF5F5F5),
    filled: true,
    hintText: inputText,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.all(10),
  );

}