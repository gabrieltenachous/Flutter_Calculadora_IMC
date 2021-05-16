import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _txtPeso = TextEditingController();
  TextEditingController _txtAltura = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _text = "Informe seus dados";
  void resetForm() {
    setState(() {
      _txtPeso.clear();
      _txtAltura.clear();
      setState(() {
        _text = "Informe seus dados";
        _formKey = GlobalKey<FormState>();
      });
    });
  }

  void calculate() {
    setState(() {
      double peso = double.parse(_txtPeso.text);
      double altura = double.parse(_txtAltura.text) / 100;
      double imc = peso / (altura * altura);
      _text = "Voce tem: ${imc.toStringAsPrecision(4)} de IMC";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          "Calculadora de IMC",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
            ),
            onPressed: resetForm,
          )
        ],
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Icon(
                  Icons.person_outline,
                  size: 150,
                  color: Colors.green,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira seu Peso!";
                    }
                  },
                  keyboardType: TextInputType.number,
                  controller: _txtPeso,
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(
                      color: Colors.green,
                      fontSize: 25,
                    ),
                    fillColor: Colors.green,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira sua Altura!";
                    }
                  },
                  controller: _txtAltura,
                  decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(
                      color: Colors.green,
                      fontSize: 25,
                    ),
                    fillColor: Colors.green,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  height: 50,
                  width: 400,
                  child: RaisedButton(
                    color: Colors.green,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        calculate();
                      }
                    },
                    child: Text(
                      'Calcular',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                "$_text",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
