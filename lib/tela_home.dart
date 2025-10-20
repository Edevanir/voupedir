import 'package:flutter/material.dart';
import 'package:voupedir/banco/restaurante.dart';
import 'package:voupedir/banco/restaurante_dao.dart';
import 'package:voupedir/banco/tela_cad_restaurante.dart';
import 'package:voupedir/tela_edit_restaurante.dart';

class TelaHome extends StatefulWidget {
  TelaHome({super.key});

  @override
  State<TelaHome> createState() => TelaHomeState();
}

class TelaHomeState extends State<TelaHome>{
  List<Restaurante> restaurantes = [];

  @override
  void initState(){
    super.initState();
    carregaRestaurantes();
  }
  Future <void> carregaRestaurantes() async{
    final lista = await RestauranteDAO.listarTodos();
    setState((){
      restaurantes = lista;
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title: const Text("Lista de Restaurantes"),
        actions: [
          IconButton(onPressed: () async{
            final t = await Navigator.push(context, MaterialPageRoute(builder: (contest) => TelaCadRestaurante()));
           if(t == false || t == null){
             setState((){
               carregaRestaurantes();
             });
           }
    },
             icon: Icon(Icons.add)
          )
        ],
      ),
      body: Padding(padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: restaurantes.length,
          itemBuilder: (context, index) {
            final r = restaurantes[index];
            {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(r.nomerestaurante ?? 'Sem nome'),
                  subtitle: Text('ID: ${r.codigorestaurante}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () async{
                            TelaEditRestaurante.restaurante = await RestauranteDAO.listar(r.codigorestaurante);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => TelaEditRestaurante()));
                          },
                          icon: Icon(Icons.edit, color: Colors.blue)
                      ), IconButton(
                          onPressed: () {
                            showDialog(
                            context: context,
                            builder: (BuildContext context) =>

                            AlertDialog(
                              title: Text("Confirmar ação"),
                              content: Text("Deseja realmente excluir?"),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      RestauranteDAO.excluir(r);
                                      setState(() {
                                        carregaRestaurantes();
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text("sim")
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("não")
                                )
                              ],
                                )
                            );
                            //Codigo para EXCLUIR Restaurante
                          },
                          icon: Icon(Icons.delete, color: Colors.red)
                      ),
                    ],
                  ),
                ),
              );
            }
          }

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          Navigator.push(context, MaterialPageRoute(builder: (context) => TelaCadRestaurante()));
        },
        child: Icon(Icons.add),
      ),
    );
  }




}