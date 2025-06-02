import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:in_between/core/cubit/user_cubit.dart';
import 'package:in_between/core/routes/app_router.dart';
import 'package:in_between/core/widgets/bank_logo_card.dart';
import 'package:in_between/core/widgets/images.dart';
import 'package:in_between/core/widgets/outlined_button_widget.dart';
import 'package:in_between/core/widgets/textfield_widget.dart';
import 'package:in_between/features/home/presentation/bloc/home_bloc.dart';
import 'package:in_between/features/wallet/presentation/bloc/wallet_bloc.dart';

class CashInOutScreen extends StatelessWidget {
  final String walletId;
  const CashInOutScreen({super.key, required this.walletId});

  @override
  Widget build(BuildContext context) {
    TextEditingController accNumberController = TextEditingController();
    TextEditingController accNameController = TextEditingController();
    TextEditingController cashInOutAmount = TextEditingController();
    final user = context.watch<UserCubit>().state;
    return BlocListener<WalletBloc, WalletState>(
      listener: (context, state) {
        if (state is WalletDepositSuccess) {
          context.read<HomeBloc>().add(
            HomeFetchUserWallet(userId: user!.userId),
          );
          context.go(Routes.homeScreen);
        } else if (state is WalletDepositFailed) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('An error has occured')));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: IconButton(
                        onPressed: () {
                          context.pop(Routes.homeScreen);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                final amount = cashInOutAmount.text.trim();
                // final accountNumber = accNumberController.text.trim();
                // final accountName = accNameController.text.trim();

                if (amount.isEmpty) {
                  context.read<WalletBloc>().add(IncompleteField());
                }

                final inputCredit = double.tryParse(amount);
                //final userData = user;
                context.read<WalletBloc>().add(
                  DepositWallet(
                    userWalletId: walletId,
                    depositAmount: inputCredit ?? 0.0,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
