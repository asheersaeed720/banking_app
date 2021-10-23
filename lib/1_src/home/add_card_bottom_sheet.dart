import 'dart:developer';

import 'package:banking_app/1_src/home/bank_card_model.dart';
import 'package:banking_app/1_src/home/home_controller.dart';
import 'package:banking_app/utils/display_toast_message.dart';
import 'package:banking_app/utils/input_decoration.dart';
import 'package:banking_app/widgets/custom_async_btn.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

void showAddCardBottomModelSheet() {
  final _homeController = Get.put(HomeController());
  final _formKey = GlobalKey<FormState>();
  final context = Get.context;
  String selectedBank = 'Meezan Bank Limited';
  String selectedCardType = 'Silver';
  String selectedExpiryDate = '';
  log('screenSize: ${MediaQuery.of(context!).size.height}');
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Image.asset('assets/icons/debit_cards.png', width: 42),
                const SizedBox(width: 10.0),
                Text(
                  'Add your card',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            DropdownSearch<String>(
              mode: Mode.MENU,
              items: BankCardModel.banksList.map((e) => e.bankName).toList(),
              // popupItemDisabled: (String s) => s.startsWith('I'),
              onChanged: (value) {
                selectedBank = '$value';
              },
              selectedItem: "Meezan Bank Limited",
            ),
            const SizedBox(height: 10.0),
            DropdownSearch<String>(
              mode: Mode.MENU,
              items: const ["Silver", "Gold", 'Platinum'],
              // popupItemDisabled: (String s) => s.startsWith('I'),
              onChanged: (value) {
                selectedCardType = '$value';
              },
              selectedItem: "Silver",
            ),
            const SizedBox(height: 12.0),
            DateTimeField(
              format: DateFormat.yMMMEd(),
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime(2100),
                );
              },
              onChanged: (value) {
                selectedExpiryDate = '$value';
              },
              decoration: buildTextFieldInputDecoration(
                context,
                labelText: 'Select expiry date',
                preffixIcon: const Icon(Icons.date_range),
              ),
            ),
            const SizedBox(height: 12.0),
            CustomAsyncBtn(
              btntxt: 'Add',
              borderRadius: 6.0,
              onPress: () async {
                if (selectedBank.isNotEmpty &&
                    selectedCardType.isNotEmpty &&
                    selectedExpiryDate.isNotEmpty) {
                  await _homeController.addUserCard(
                    bankName: selectedBank,
                    cardType: selectedCardType,
                    expiryDate: selectedExpiryDate,
                  );
                } else {
                  displayToastMessage('Field missing');
                }
              },
            ),
          ],
        ),
      ),
    ),
  );
}
