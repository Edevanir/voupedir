class Tipo{

int? _codigodotipo;
String? _nomedotipoderestaurante;

Tipo({ int? codigodotipo,  String? nomedotipoderestaurante})
{
  _codigodotipo = codigodotipo;
  _nomedotipoderestaurante = nomedotipoderestaurante;

}
int? get codigodotipo => _codigodotipo;
String? get nomedotipoderestaurante => _nomedotipoderestaurante;

set nomedotipoderestaurante(String? nomedotipo) =>_nomedotipoderestaurante = nomedotipoderestaurante;
set codigodotipo(int? codigodotipo) => _codigodotipo = codigodotipo;
}