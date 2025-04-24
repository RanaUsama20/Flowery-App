import 'package:flowery_app/core/network/common/api_result.dart';
import 'package:flowery_app/features/address/data/model/address_request_model.dart';
import 'package:flowery_app/features/address/domain/respository/address_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditAddressUseCase {
  final AddressRepository _addressRepository;
  EditAddressUseCase(this._addressRepository);
  Future<Result<String>> call(String id, AddressRequestModel addressRequest) =>
      _addressRepository.editAddress(id, addressRequest);
}
