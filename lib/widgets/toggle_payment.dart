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
  const TogglePayment({super.key, required this.onPaymentChange});

  final void Function(bool isPaypal, String paypalName) onPaymentChange;

  @override
  State<TogglePayment> createState() => _TogglePaymentState();
}

class _TogglePaymentState extends State<TogglePayment> {
  Set<PaymentMethod> _segmentedButtonSelection = <PaymentMethod>{
    PaymentMethod.cash
  };
  bool isPaypal = false;
  TextEditingController paypalNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SegmentedButton<PaymentMethod>(
          multiSelectionEnabled: false,
          emptySelectionAllowed: false,
          showSelectedIcon: false,
          selected: _segmentedButtonSelection,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.green;
                }
                return AppColors.lightGray;
              },
            ),
          ),
          onSelectionChanged: (Set<PaymentMethod> newSelection) {
            setState(() {
              _segmentedButtonSelection = newSelection;
              isPaypal = _segmentedButtonSelection.contains(PaymentMethod.paypal);
              widget.onPaymentChange(isPaypal, paypalNameController.text);
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
        if (isPaypal)
          MyTextField(
            controller: paypalNameController,
            text: 'Paypal Name',
            isPassword: false,
            onChange: (value) {
              widget.onPaymentChange(isPaypal, value);
            },
          ),
      ],
    );
  }
}
