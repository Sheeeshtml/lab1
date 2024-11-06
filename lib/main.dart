import 'package:flutter/material.dart';

void main() {
  runApp(CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CurrencyConverter(),
    );
  }
}

class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  final TextEditingController _amountController = TextEditingController();
  String _fromCurrency = 'MDL'; // Default from currency
  String _toCurrency = 'USD';   // Default to currency
  double _exchangeRate = 17.65; // Static exchange rate for now
  String _result = '';

  // Function to convert currency when the button is pressed
  void _convertCurrency() {
    double amount = double.tryParse(_amountController.text) ?? 0;

    // Simple conversion logic based on exchange rate
    double convertedAmount = (amount / _exchangeRate).toDouble();
    if (_fromCurrency == 'USD') {
      convertedAmount = (amount * _exchangeRate).toDouble();
    }

    setState(() {
      _result = convertedAmount.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Currency Converter',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Amount Input with Currency Dropdown
            _buildCurrencyInput('Amount', _amountController, _fromCurrency),

            // Swap Icon
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: IconButton(
                icon: Icon(Icons.swap_vert, size: 32, color: Colors.blue),
                onPressed: () {
                  setState(() {
                    // Swap the currencies
                    String temp = _fromCurrency;
                    _fromCurrency = _toCurrency;
                    _toCurrency = temp;
                  });
                },
              ),
            ),

            // Converted Amount Display
            _buildCurrencyOutput('Converted Amount', _result, _toCurrency),

            // Convert Button
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertCurrency, // Call the conversion logic when pressed
              child: Text('Convert'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),

            // Display exchange rate
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                '1 USD = $_exchangeRate MDL',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for currency input (amount and currency code)
  Widget _buildCurrencyInput(String label, TextEditingController controller, String currency) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, color: Colors.grey)),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Text(currency, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Spacer(),
              Container(
                width: 100,
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.right, // Aligns input text to the right
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '0.00',
                    hintStyle: TextStyle(color: Colors.black), // Change hint color
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget for converted amount output
  Widget _buildCurrencyOutput(String label, String value, String currency) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, color: Colors.grey)),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Text(currency, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Spacer(),
              Text(
                value.isEmpty ? '0.00' : value,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.right, // Align the converted amount text to the right
              ),
            ],
          ),
        ),
      ],
    );
  }
}
