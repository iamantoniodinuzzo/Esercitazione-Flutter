import 'package:freezed_annotation/freezed_annotation.dart';

part '$file_name$_dto.freezed.dart';
part '$file_name$_dto.g.dart';

@freezed 
class $name$Dto with _$$$name$Dto {
	const factory $name$Dto({
	$values$
	}) = _$name$Dto;

	factory $name$Dto.fromJson(Map<String, dynamic> json) => _$$$name$DtoFromJson(json);
}

extension $name$DtoExtenstion on $name$Dto {
	$name$ get toEntity => $name$();
}