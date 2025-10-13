import 'package:voupedir/banco/database_helper.dart';

import 'tipo.dart';
class tipoDAO{

  static Future<List<Tipo>> listarTipos() async{

    final db = await DatabaseHelper.getDatabase();
        final resultado = await db.query('tb_tipo');

    return resultado.map((mapa){
      return Tipo(
          codigodotipo: mapa['cd_tipo'] as int,
          nomedotipoderestaurante: mapa['nm_tipo'] as String
      );
    }).toList();

  }

}