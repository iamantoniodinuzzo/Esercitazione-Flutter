import 'package:movie_app/data/remote/dto/production_company/production_company_dto.dart';
import 'package:movie_app/domain/model/production_company/production_company.dart';

extension ProductionCompanyMapper on ProductionCompanyDto {
  ProductionCompany mapToDomain() {
    return ProductionCompany(
        id: id, logoPath: logoPath, name: name, originCountry: originCountry);
  }
}

extension ProductionCompaniesMapper on Iterable<ProductionCompanyDto> {
  Iterable<ProductionCompany> mapToDomain() {
    return map((productionCompanyDto) => productionCompanyDto.mapToDomain());
  }
}
