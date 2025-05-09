import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:in_between/core/routes/app_router.dart';
import 'package:in_between/core/widgets/bank_logo_card.dart';
import 'package:in_between/core/widgets/images.dart';
import 'package:in_between/core/widgets/outlined_button_widget.dart';
import 'package:in_between/core/widgets/textfield_widget.dart';

class CashInOutScreen extends StatelessWidget {
  const CashInOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController accNumberController = TextEditingController();
    TextEditingController accNameController = TextEditingController();
    TextEditingController cashInOutAmount = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            context.go(Routes.homeScreen);
          },
          icon: Icon(Icons.close, color: Colors.white),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePaths.bg.path),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('CASH IN/OUT', style: TextStyle(fontSize: 40)),
              Divider(height: 22, color: Colors.transparent),

              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BankLogoCard(imagePath: ImagePaths.gcash.path),
                  BankLogoCard(imagePath: ImagePaths.banksLogo.path),
                ],
              ),
              Divider(height: 22, color: Colors.transparent),

              TextFieldWidget(
                label: 'Account Number',
                controller: accNumberController,
              ),
              TextFieldWidget(
                label: 'Account Name',
                controller: accNameController,
              ),

              TextFieldWidget(label: 'Amount', controller: cashInOutAmount),
              Divider(height: 40, color: Colors.transparent),
              ButtonWidget(
                label: 'Cash In',
                onPressed: () {
                  print('cash in/out clicked');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
