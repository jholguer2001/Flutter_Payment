import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:payment_flow_00/ui/components/payment_type.dart';


class PaymentMethodScreen extends StatefulWidget{
  const PaymentMethodScreen({super.key});

  @override
  State<StatefulWidget> createState() {

    return _PaymentMethodState();
  }
}

class _PaymentMethodState extends State<PaymentMethodScreen>{

  PaymentMethod paymentSelected = PaymentMethod.creditCard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){},
          ),
          ),

        body: Padding(

          /* padding: const EdgeInsets.all(45.0), */
          padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
          child:  Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              const Text('Método de pago',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff1A1A1A)
              ),
              ),

              const Text('Seleccione uno de los métoddos de pago', 
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff6C738A)
              ),
              ),

              const SizedBox(height: 20,),

              PaymentMethodWidget(
                icon: const Icon(
                  FontAwesomeIcons.creditCard,
                  color: Color(0xffCCB375),
                ),
                title: 'Tarjeta de crédito',
                subTitle: 'Pague con Mastercard o Visa',
                value: PaymentMethod.creditCard,
                selectedValue: paymentSelected,
                paymentCallBack: onPaymentChange,
              ),

              PaymentMethodWidget(
                icon: const Icon(
                  FontAwesomeIcons.buildingColumns,
                  color: Color(0xff00A7D9),
                ),
                title: 'Transferencia bancaria',
                subTitle: 'Pague directo desde su cuenta',
                value: PaymentMethod.bank,
                selectedValue: paymentSelected,
                paymentCallBack: onPaymentChange,
              ),

              PaymentMethodWidget(
                icon: const Icon(
                  FontAwesomeIcons.paypal,
                  color: Color(0xff0D47A1),
                ),
                title: 'Paypal',
                subTitle: 'La forma más rápida y segura de enviar dinero',
                value: PaymentMethod.paypal,
                selectedValue: paymentSelected,
                paymentCallBack: onPaymentChange
              ),

              PaymentMethodWidget(
                icon: const Icon(
                  FontAwesomeIcons.bitcoin,
                  color: Color(0xff000000),
                ),
                title: 'Billetera de Bitcoin',
                subTitle: 'Enviar la cantidad a nuestra billetera Bitcoin',
                value: PaymentMethod.bitcoin,
                selectedValue: paymentSelected,
                paymentCallBack: onPaymentChange,
              ),

            ],
          ),
        ),

      floatingActionButton: ElevatedButton(
        onPressed: () =>
          showDetails(context), 
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25)
        ),
      ),
      child: const Text(
        'SIGUIENTE'
      )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
  }

  void onPaymentChange(PaymentMethod value){
  setState(() {});
  paymentSelected = value;
}
}

void showDetails(BuildContext context) =>
  Navigator.pushNamed(context, '/payment_details');


enum PaymentMethod{
  creditCard,
  bank,
  paypal,
  bitcoin
}

typedef PaymentCallBack = Function(PaymentMethod value);

class PaymentMethodWidget extends StatelessWidget{

  final Widget icon;

  final String title;
  final String subTitle;
  final PaymentMethod value;
  final PaymentMethod selectedValue;
  final PaymentCallBack paymentCallBack;

  const PaymentMethodWidget(
    {super.key, 
    required this.title, 
    required this.subTitle, 
    required this.value, 
    required this.selectedValue, 
    required this.paymentCallBack, 
    required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),

      child: InkWell(
        onTap: _onTap,
        child: Row(
          children: <Widget> [
      
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: getWidgetState(),


              
            ),
      
            Expanded(
              child: Container(
              padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xffFBFBFB),
                  borderRadius: BorderRadius.circular(25)
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    icon,
                    Expanded(
                      child: Column(
                        children: <Widget> [
      
                          Text(
                            title,
                            style: const TextStyle(
                              color: Color(0xff000000),
                              fontSize: 13
                              ),
                              ),
      
                          Text(
                            subTitle,
                            style: const TextStyle(
                              color: Color(0xff6C738A),
                              fontSize: 10
                            ),
                            )
                        ],
                      ),
                    )
                  ],
                ),
      
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getWidgetState(){
    //Si el icono esta seleccionado
    if(value == selectedValue){
      return (const Icon(
        FontAwesomeIcons.solidCircleCheck,
        color: Colors.green,
        size: 21,
      ));
    }else{
      return Container(
        margin: const EdgeInsets.only(left: 1),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey, width: 2)),
      height: 20,
      width: 20,
      );
    }
  }

  void _onTap(){
    paymentCallBack(value);
  }
}

