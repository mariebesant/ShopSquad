import 'package:flutter/material.dart';
import 'package:shopsquad/theme/colors.dart';
import 'package:shopsquad/theme/sizes.dart';
import 'package:shopsquad/widgets/my_textfield.dart';

enum PaymentMethod { cash, paypal }

const List<(PaymentMethod, String)> paymentOptions = <(PaymentMethod, String)>[
  (PaymentMethod.cash, 'Bargeld'),
  (PaymentMethod.paypal, 'Paypal'),
];

class TogglePayment extends StatefulWidget {
  const TogglePayment({super.key});

  @override
  State<TogglePayment> createState() => _TogglePaymentState();
}

class _TogglePaymentState extends State<TogglePayment> {
  Set<PaymentMethod> _segmentedButtonSelection = <PaymentMethod>{
    PaymentMethod.cash
  };
  bool isPaypal = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SegmentedButton<PaymentMethod>(
          multiSelectionEnabled: false,
          emptySelectionAllowed: false,
          showSelectedIcon: false,
          selected: _segmentedButtonSelection,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return AppColors.green; // Die Farbe für ausgewählte Zustände
                }
                return AppColors
                    .lightGray; // Die Farbe für alle anderen (nicht ausgewählten) Zustände
              },
            ),
          ),
          onSelectionChanged: (Set<PaymentMethod> newSelection) {
            setState(() {
              _segmentedButtonSelection = newSelection;
              isPaypal =
                  _segmentedButtonSelection.contains(PaymentMethod.paypal);
            });
          },
          segments: paymentOptions.map<ButtonSegment<PaymentMethod>>(
              ((PaymentMethod, String) payment) {
            return ButtonSegment<PaymentMethod>(
                value: payment.$1, label: Text(payment.$2));
          }).toList(),
        ),
        const SizedBox(height: AppSizes.s0_5),
        Text(
          'Zahlungsart',
          style: TextStyle(color: AppColors.green, fontSize: AppSizes.s0_75),
        ),
        const SizedBox(height: AppSizes.s1),
        isPaypal ? const MyTextField(text: 'Paypal Name', isPassword: false,) : Container(),
      ],
    );
  }
}
