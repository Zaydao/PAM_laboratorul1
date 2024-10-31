import 'package:flutter/material.dart';

void main() {
  runApp(BMICalculator());
}

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[50],
          elevation: 0.0,
        ),
        body: BMICalculatorPage(),
      ),
    );
  }
}

class BMICalculatorPage extends StatefulWidget {
  @override
  _BMICalculatorPageState createState() => _BMICalculatorPageState();
}

enum Gender { male, female }

class _BMICalculatorPageState extends State<BMICalculatorPage> {
  int weight = 70;
  int age = 23;
  double height = 184; // Default height
  double bmi = 0;
  String category = '';
  Gender? selectedGender;

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView( // Acest widget permite scrollul
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome 😎',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'BMI Calculator',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GenderButton(
                  label: "Male",
                  isSelected: selectedGender == Gender.male,
                  onPressed: () {
                    setState(() {
                      selectedGender = Gender.male;
                    });
                  },
                ),
                SizedBox(width: 20),
                GenderButton(
                  label: "Female",
                  isSelected: selectedGender == Gender.female,
                  onPressed: () {
                    setState(() {
                      selectedGender = Gender.female;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InputCard(
                  label: 'Weight',
                  value: weight.toString(),
                  onDecrease: () {
                    setState(() {
                      weight--;
                    });
                  },
                  onIncrease: () {
                    setState(() {
                      weight++;
                    });
                  },
                ),
                InputCard(
                  label: 'Age',
                  value: age.toString(),
                  onDecrease: () {
                    setState(() {
                      age--;
                    });
                  },
                  onIncrease: () {
                    setState(() {
                      age++;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Height',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  height = double.parse(value);
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              bmi == 0 ? '0.0' : bmi.toStringAsFixed(1),
              style: TextStyle(
                  fontSize: 48, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            Text(
              category.isEmpty ? 'Category' : category,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  bmi = calculateBMI();
                  category = getBMICategory(bmi);
                });
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                backgroundColor: Colors.blue,
              ),
              child: Text(
                'Let\'s Go',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double calculateBMI() {
    if (height == 0) return 0;
    return weight / (height / 100 * height / 100);
  }

  String getBMICategory(double bmi) {
    if (bmi < 18.5) return "Underweight";
    else if (bmi < 24.9) return "Normal";
    else if (bmi < 29.9) return "Overweight";
    else return "Obese";
  }
}

class GenderButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  GenderButton({required this.label, required this.isSelected, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.blue,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

class InputCard extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  InputCard(
      {required this.label,
        required this.value,
        required this.onDecrease,
        required this.onIncrease});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            IconButton(
              onPressed: onDecrease,
              icon: Icon(Icons.remove),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: onIncrease,
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
