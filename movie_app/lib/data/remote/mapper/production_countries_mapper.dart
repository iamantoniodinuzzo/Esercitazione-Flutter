import '../../../domain/model/production_country/production_country.dart';
import '../dto/production_country/production_country_dto.dart';

extension ProductionCountryMapper on ProductionCountryDto {
  ProductionCountry mapToDomain() {
    return ProductionCountry(name: name);
  }
}

extension ProductionCountriesMapper on Iterable<ProductionCountryDto>{
  Iterable<ProductionCountry> mapToDomain(){
    return map((e) => e.mapToDomain());
  }
}
