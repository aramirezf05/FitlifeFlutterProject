import 'package:fitlife/utils/string_constants.dart';
import 'package:flutter/material.dart';
import '../../model/user.dart';
import '../../utils/fitlife_app_bar.dart';
import '../../utils/fitlife_input_textfield.dart';
import '../../utils/number_constants.dart';
import '../login/login_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key, required this.user});

  final User user;

  @override
  State<StatefulWidget> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  String _imcCategory = '';

  @override
  void initState() {
    super.initState();

    _usernameController.text = widget.user.username;
    _nameController.text = widget.user.firstName;
    _surnameController.text = widget.user.lastName;
    _weightController.text = widget.user.weight.toString();
    _heightController.text = widget.user.height.toString();
  }

  void _calculateIMC() {
    final double weight = double.tryParse(_weightController.text) ?? 0;
    final double heightCm = double.tryParse(_heightController.text) ?? 0;
    final double heightM = heightCm / 100;

    if (weight > 0 && heightM > 0) {
      final double imc = weight / (heightM * heightM);
      String category;

      if (imc < 18.5) {
        category = lowWeightCategory;
      } else if (imc < 24.9) {
        category = normalWeightCategory;
      } else if (imc < 29.9) {
        category = overweightCategory;
      } else {
        category = obesityCategory;
      }

      setState(() {
        _imcCategory = "$bmiLabel ${imc.toStringAsFixed(1)} ($category)";
      });
    } else {
      setState(() {
        _imcCategory = invalidValues;
      });
    }
  }

  void _logoutAction() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false,
    );
  }

  void _updateUser() {
    setState(() {
      widget.user.username = _usernameController.text;
      widget.user.firstName = _nameController.text;
      widget.user.lastName = _surnameController.text;
      widget.user.weight = double.tryParse(_weightController.text) ?? 0;
      widget.user.height = double.tryParse(_heightController.text) ?? 0;
    });
    print('User updated: ${widget.user.firstName} ${widget.user.lastName}, Weight: ${widget.user.weight}, Height: ${widget.user.height}');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: FitLifeAppBar(title: accountLabel),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            fitLifeTextField(controller: _usernameController, labelText: usernameTextEdit, context: context),
            SizedBox(height: sizeDouble_16), // This is for padding
            fitLifeTextField(controller: _nameController, labelText: nameTextEdit, context: context),
            SizedBox(height: sizeDouble_16), // This is for padding
            fitLifeTextField(controller: _surnameController, labelText: surnameTextEdit, context: context),
            SizedBox(height: sizeDouble_16), // This is for padding
            fitLifeNumberTextField(controller: _weightController, labelText: weightTextEdit, context: context),
            SizedBox(height: sizeDouble_16), // This is for padding
            fitLifeNumberTextField(controller: _heightController, labelText: heightTextEdit, context: context),
            SizedBox(height: sizeDouble_16), // This is for padding
            ElevatedButton(
              onPressed: _calculateIMC,
              child: Text(calculateButton),
            ),
            SizedBox(height: sizeDouble_16), // This is for padding
            Text(
              _imcCategory,
              style: TextStyle(fontSize: sizeDouble_18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: sizeDouble_8), // This is for padding
            ElevatedButton(
              onPressed: _updateUser,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text("Guardar Cambios", style: TextStyle(color: Colors.white)), // Botón para guardar cambios
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
          height: 60,
          width: screenWidth * 0.7,
          child: FloatingActionButton.extended(
            onPressed: () {
              _logoutAction();
            },
            backgroundColor: Colors.red,
            icon: Icon(Icons.logout_outlined),
            label: Text(logoutLabel),
          )
      ),
    );
  }
}