class Restaurante {
  int? _codigorestaurante;
  String? _nomerestaurante;
  double? _latidude;
  double? _longitude;


  Restaurante({
  int? codigorestaurante,
  String? nomerestaurante,
  double? latitude,
  double? longitude)


  }){
_codigorestaurante = codigorestaurante;
_nomerestaurante = nomerestaurante
_latitude = latitude;
_longitude = longitude;

}
int? get codigorestaurante => _codigorestaurante;
String? get nomerestaurante => _nomerestaurante;
double? get latitude => latitude;
double? get longitude => longitude;

