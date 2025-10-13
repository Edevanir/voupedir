import 'package:voupedir/banco/usuario_dao.dart';

import 'database_helper.dart';
import 'restaurante.dart';
import 'tipo.dart';


class RestauranteDAO{

  static Future<List<Restaurante>>listarTodos()async{
    final db = await DatabaseHelper.getDatabase();
    final resultado = await db.query('tb_restaurante',
    where: 'cd_usuario =?',
      whereArgs: [UsuarioDAO.usuarioLogado.codigo]
    );

    return resultado.map((mapa){
      return Restaurante(
          codigorestaurante: mapa['cd_restaurante'] as int,
          nomerestaurante: mapa['nm_restaurante'] as String
       );
     }).toList();
   }

  static Future<int>cadastrarRestaurante(
      String? nomeRestaurante,
      String? latitude,
      String? longitude,
      int? tipo

      )async{
    final db = await DatabaseHelper.getDatabase();
    final dadosRestaurante = {
      'cd_tipo': tipo,
      'nm_restaurante': nomeRestaurante,
      'latitude_restaurante': latitude,
      'cd_usuario': UsuarioDAO.usuarioLogado.codigo
    };
    try{
      final idRestaurante = await db.insert('tb_restaurante', dadosRestaurante);
      return idRestaurante;
    }catch(e){
      print("Erro ao cadastrar restaurante: $e");
      return -1;
    }
  }

}
