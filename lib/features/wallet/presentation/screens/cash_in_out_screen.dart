import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_between/core/cubit/user_cubit.dart';
import 'package:in_between/features/wallet/presentation/widgets/bank_logo_card.dart';
import 'package:in_between/core/widgets/images.dart';
import 'package:in_between/core/widgets/outlined_button_widget.dart';
import 'package:in_between/core/widgets/textfield_widget.dart';
import 'package:in_between/features/wallet/presentation/bloc/wallet_bloc.dart';

class CashInOutScreen extends StatelessWidget {
  const CashInOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController accNumberController = TextEditingController();
    TextEditingController accNameController = TextEditingController();
    TextEditingController cashInOutAmount = TextEditingController();
    final user = context.watch<UserCubit>().state;
    return BlocListener<WalletBloc, WalletState>(
      listener: (context, state) {
        if (state is CashInSuccess) {
          context.read<UserCubit>().setUser(state.credit);
        } else if (state is CashInFail) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Please fill in all fields!')));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
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
              isDigitOnly: true,
            ),
            TextFieldWidget(
              label: 'Account Name',
              controller: accNameController,
              isDigitOnly: false,
            ),

            TextFieldWidget(
              label: 'Amount',
              controller: cashInOutAmount,
              isDigitOnly: true,
            ),
            Divider(height: 40, color: Colors.transparent),
            ButtonWidget(
              label: 'Cash In',
              onPressed: () {
                print('cash in clicked');
                final amount = cashInOutAmount.text.trim();
                final accountNumber = accNumberController.text.trim();
                final accountName = accNameController.text.trim();

                if (amount.isEmpty ||
                    accountName.isEmpty ||
                    accountNumber.isEmpty) {
                  context.read<WalletBloc>().add(IncompleteField());
                }

                final inputCredit = double.tryParse(amount);
                final userData = user;
                context.read<WalletBloc>().add(CashIn(userData!, inputCredit!));
              },
            ),
          ],
        ),
      ),
    );
  }
}
