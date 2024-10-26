import 'package:flutter/material.dart';

void main() {
  runApp(ConversionApp());
}

class ConversionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Conversion App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ConversionHomePage(),
    );
  }
}

class ConversionHomePage extends StatefulWidget {
  @override
  _ConversionHomePageState createState() => _ConversionHomePageState();
}

class _ConversionHomePageState extends State<ConversionHomePage> {
  final TextEditingController _controller = TextEditingController();
  double _convertedValue = 0.0;

  String _fromUnit = 'Miles';
  String _toUnit = 'Kilometers';

  final Map<String, Map<String, double>> conversionRates = {
    'Miles': {'Kilometers': 1.60934, 'Miles': 1.0},
    'Kilometers': {'Miles': 0.621371, 'Kilometers': 1.0},
    'Pounds': {'Kilograms': 0.453592, 'Pounds': 1.0},
    'Kilograms': {'Pounds': 2.20462, 'Kilograms': 1.0},
  };

  void _convert() {
    double input = double.tryParse(_controller.text) ?? 0.0;
    double rate = conversionRates[_fromUnit]?[_toUnit] ?? 1.0;
    setState(() {
      _convertedValue = input * rate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unit Conversion App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter value',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('From'),
                    DropdownButton<String>(
                      value: _fromUnit,
                      onChanged: (String? newValue) {
                        setState(() {
                          _fromUnit = newValue!;
                        });
                      },
                      items: conversionRates.keys.map((String unit) {
                        return DropdownMenuItem<String>(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('To'),
                    DropdownButton<String>(
                      value: _toUnit,
                      onChanged: (String? newValue) {
                        setState(() {
                          _toUnit = newValue!;
                        });
                      },
                      items: conversionRates.keys.map((String unit) {
                        return DropdownMenuItem<String>(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            Text(
              'Converted Value: $_convertedValue',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
