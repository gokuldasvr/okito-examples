import 'package:flutter/material.dart';
import 'package:http_currency_converter/controller.dart';
import 'package:okito/okito.dart';

class ScreenHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              numberInput,
              verticalGap,
              convertFromCurrencySelect,
              verticalGap,
              convertToCurrencySelect,
              verticalGap,
              convertButton,
              verticalGap,
              result
            ],
          ),
        ),
      ),
    );
  }

  Widget get result => RockitoBuilder<ConverterController>(
        builder: (controller) {
          return controller.convertedRate == null
              ? Text('')
              : ListTile(
                  title: Text('${controller.convertedRate}'),
                  subtitle: Text(
                    'Last Update ${controller.lastUpdated ?? 'Not Available'}',
                  ),
                );
        },
      );

  Widget get verticalGap => SizedBox(height: 20);

  Widget get convertButton => ElevatedButton.icon(
        onPressed: () {
          Okito.use<ConverterController>().convertCurrency();
        },
        icon: Icon(Icons.refresh),
        label: Text('Convert'),
      );

  Widget get numberInput => TextFormField(
        maxLines: 1,
        maxLength: 7,
        onChanged: (value) {
          try {
            Okito.use<ConverterController>().updateAmount(value.toDouble());
          } catch (e) {
            print(e);
          }
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Amount',
          counterText: '',
        ),
      );

  Widget get convertFromCurrencySelect => RockitoBuilder<ConverterController>(
        builder: (controller) {
          return DropdownButtonFormField<String>(
            items: controller.currencyList.map((e) {
              return DropdownMenuItem(
                child: Text(e),
                value: e,
              );
            }).toList(),
            hint: Text('From'),
            onChanged: (value) {
              if (value != null) {
                Okito.use<ConverterController>().updateFrom(value);
              }
            },
          );
        },
      );
  Widget get convertToCurrencySelect => RockitoBuilder<ConverterController>(
        builder: (controller) {
          return DropdownButtonFormField<String>(
            items: controller.currencyList.map((e) {
              return DropdownMenuItem(
                child: Text(e),
                value: e,
              );
            }).toList(),
            hint: Text('To'),
            onChanged: (value) {
              if (value != null) {
                Okito.use<ConverterController>().updateTo(value);
              }
            },
          );
        },
      );
}
