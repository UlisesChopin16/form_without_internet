enum  TipoSucursalType {
  // chica
  // mediana,
  // cadem,
  // grande,
  // grandeT;
  chica(value: 'Chica'),
  mediana(value: 'Mediana'),
  cadem(value: 'Cadem'),
  grande(value: 'Grande'),
  grandeT(value: 'Grande T');

  final String value;

  const TipoSucursalType({
    required this.value,
  });

  static TipoSucursalType getType(String? value) {
    switch (value) {
      case 'Chica':
        return TipoSucursalType.chica;
      case 'Mediana':
        return TipoSucursalType.mediana;
      case 'Cadem':
        return TipoSucursalType.cadem;
      case 'Grande':
        return TipoSucursalType.grande;
      case 'Grande T':
        return TipoSucursalType.grandeT;
      default:
        return TipoSucursalType.chica;
    }
  }
}
