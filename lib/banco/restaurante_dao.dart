import 'package:voupedir/banco/tipo_dao.dart';
import 'package:voupedir/banco/usuario_dao.dart';
import 'tipo_dao.dart';
import 'database_helper.dart';
import 'restaurante.dart';
import 'package:voupedir/banco/tipo.dart';


class RestauranteDAO{

  static Future<void> atualizarRestaurante(
      int? cd,
      String? nome,
      String? latitude,
      String? longitude,
      int? tipo
      )async {
    final db = await DatabaseHelper.getDatabase();

    final resultado = db.update('tb_restaurante', {
      'nm_restaurante': nome,
      'latitude_restaurante': latitude,
      'longitude_restaurante': longitude,
      'cd_tipo': tipo,
      },
      where: 'cd_restaurante = ?',
      whereArgs: [cd]
    );
  }

  static Future<Restaurante> listar(int? id) async{
    final db = await DatabaseHelper.getDatabase();
    final resultado = await db.query( 'tb_restaurante',
    where: 'cd_restaurante = ?',
    whereArgs: [id]
    );

    return Restaurante(
      codigorestaurante: resultado.first['cd_restaurante'] as int,
      nomerestaurante: resultado.first['nm_restaurante'] as String,
      latitude: resultado.first['latitude_restaurante'] as String,
      longitude: resultado.first['longitude_restaurante'] as String,
      culinaria: await tipoDAO.listar(resultado.first['cd_tipo'] as int),
    );

  }

  static Future<void> excluir(Restaurante r) async{
    final db = await DatabaseHelper.getDatabase();
    final resultado = await db.delete('tb_restaurante',
        where: 'cd_restaurante = ?',
        whereArgs: [r.codigorestaurante]
    );
  }

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
