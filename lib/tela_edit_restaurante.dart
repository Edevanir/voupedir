import 'package:flutter/material.dart';
import 'package:voupedir/banco/restaurante.dart';
import 'package:voupedir/banco/restaurante_dao.dart';
import 'package:voupedir/banco/tipo.dart';
import 'package:voupedir/banco/tipo_dao.dart';

class TelaEditRestaurante extends StatefulWidget{
static Restaurante restaurante = Restaurante();

  @override
  State<StatefulWidget> createState() {
    return TelaEditRestauranteState();
  }
}
class TelaEditRestauranteState extends State<TelaEditRestaurante>{

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController cdController = TextEditingController();
  int? codigo = TelaEditRestaurante.restaurante.codigorestaurante as int;
  String? culinariaSelecionada;

  List<Tipo> tiposCulinaria =[];
  int? tipoCulinaria;

  void initState(){
    super.initState();
    carregarTipos();
    nomeController.text = TelaEditRestaurante.restaurante.nomerestaurante!;
    latitudeController.text = TelaEditRestaurante.restaurante.latitude.toString()!;
    longitudeController.text = TelaEditRestaurante.restaurante.longitude.toString()!;
    tipoCulinaria = TelaEditRestaurante.restaurante.culinaria?.codigodotipo;
    culinariaSelecionada = TelaEditRestaurante.restaurante.culinaria?.nomedotipoderestaurante!;
    cdController.text = codigo.toString();
  }

  Future<void>carregarTipos()async{
    final lista = await tipoDAO.listarTipos();
    setState(() {
      tiposCulinaria = lista;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Atualizar Restaurante')),
      body: Padding(padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Informações do Restaurante"),
            SizedBox(height:30),
            Text('CÓDIGO'),
            TextFormField(
                decoration: const InputDecoration(hintText: 'Código'),
                controller: cdController,
                validator: (String? value){},
                enabled: false,

            ),
            Text("Tipo de Comida"),
            DropdownButtonFormField<String>(
                value: culinariaSelecionada,
                items:tiposCulinaria.map((tipo) {
                  return DropdownMenuItem<String>(
                    value: tipo.nomedotipoderestaurante,
                    child: Text("${tipo.nomedotipoderestaurante}"),
                  );
                }).toList(),

                onChanged: (String? novaCulinaria){
                  setState(() {
                    culinariaSelecionada = novaCulinaria;
                    Tipo tipoSelecionado = tiposCulinaria.firstWhere(
                          (tipo) => tipo.nomedotipoderestaurante == novaCulinaria,
                    );
                    tipoCulinaria = tipoSelecionado.codigodotipo;
                  });
                }
            ),

            TextFormField(
              decoration: const InputDecoration(hintText: 'Nome do Restaurante'),
              validator: (String? value) {},
              controller: nomeController,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Latitude'),
              validator: (String? value) {},
              controller: latitudeController,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Longitude'),
              validator: (String? value) {},
              controller: longitudeController,
            ),
            SizedBox(height: 50),

            ElevatedButton(
                onPressed: () async {
                  final sucesso = await RestauranteDAO.cadastrarRestaurante(
                      nomeController.text,
                      latitudeController.text,
                      longitudeController.text,
                      tipoCulinaria
                  );

                  String msg = 'ERRO: restaurante não cadastrado.';
                  Color corFundo = Colors.red;
                  if(sucesso > 0) {
                    //sucesso é o ID do restaurante cadastradao, que sera maior que 0(zero)
                    msg = '"${nomeController.text}"cadastrado! ID: $sucesso';
                    corFundo = Colors.green;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(msg),
                        backgroundColor: corFundo,
                        duration: Duration(seconds: 5),
                      )
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.save),
                    Text("Cadastrar")
                  ],
                )

            )
          ],
        ),
      ),
    );
  }
}
