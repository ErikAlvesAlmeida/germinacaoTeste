import 'package:flutter/material.dart';
import 'package:teste_germinacao1/germinacao.dart';
import 'package:teste_germinacao1/database.dart';

class Germinacao extends StatefulWidget {
  const Germinacao({Key? key}) : super(key: key);

  @override
  State<Germinacao> createState() => _GerminacaoState();
}

class _GerminacaoState extends State<Germinacao> {
  TextEditingController _quantidadeGerminada = new TextEditingController();
  TextEditingController _quantidadeTotal = new TextEditingController();
  DatabaseHandler handler = DatabaseHandler();

  double _germinacao = 0.0;
  double _calcGerminacao(double quantidade, double total) {
    setState(() {
      _germinacao = (quantidade / total) * 100;
    });
    return _germinacao;
  }

  void checkInput(String value) async {
    if (value.contains(',')) {
      await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('SementeSuite'),
              content:
                  const Text('Utilize o separador ponto para casas decimais.'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'))
              ],
            );
          });
    }
  }

  void checkIsEmpty() {
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('SementeSuite'),
            content: const Text('Há campos que não foram preenchidos.'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                              color: Colors.amber, style: BorderStyle.solid)),
                      hintText: 'Quantidade de sementes'),
                  controller: _quantidadeGerminada,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                              color: Colors.amber, style: BorderStyle.solid)),
                      hintText: 'Quantidade de dias'),
                  controller: _quantidadeTotal,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: RaisedButton(
            onPressed: () {
              if (_quantidadeGerminada.text.isEmpty ||
                  _quantidadeTotal.text.isEmpty) {
                checkIsEmpty();
              } else {
                Germinacao ger = Germinacao(
                    sementesGerminadas: double.parse(_quantidadeGerminada.text),
                    totalSementes: double.parse(_quantidadeTotal.text),
                    germinacao: _calcGerminacao(
                        double.tryParse(_quantidadeGerminada),
                        double.tryParse(_quantidadeTotal)));
                List<Germinacao> listRep = [ger];
                setState(() {
                  this.handler.insertGerminacao(listRep).then((value) {
                    _quantidadeGerminada.text = '';
                    _quantidadeTotal.text = '';
                    _germinacao = 0;
                  });
                });
              }
            },
            child: const Text("Salvar", style: TextStyle(fontSize: 20)),
            color: Color.fromRGBO(57, 120, 55, 0.4),
            textColor: Colors.white,
            elevation: 5,
          ),
        ),
      ),
    );
  }
}
