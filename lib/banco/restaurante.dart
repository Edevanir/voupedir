class Restaurante{

  int? _codigorestaurante;
  String? _nomerestaurante;
  double? _latitude;
  double? _longitude;

  Restaurante({
    int? codigorestaurante,
    String? nomerestaurante,
    double? latitude,
    double? longitude,

  }){
    _codigorestaurante = codigorestaurante;
    _nomerestaurante = nomerestaurante;
    _latitude = latitude;
    _longitude = longitude;

  }
  int? get codigorestaurante => _codigorestaurante;
  String? get nomerestaurante => _nomerestaurante;
  double? get latitude => _latitude;
  double? get longitude => _longitude;

  set nomerestaurante (String? nomerestaurante) => _nomerestaurante = nomerestaurante;
  set codigorestaurante(int? codigorestaurante) => _codigorestaurante = codigorestaurante;
  set latitude(double? latitude) => _latitude = latitude;
  set longitude(double? longitude) => _longitude = longitude;
}

