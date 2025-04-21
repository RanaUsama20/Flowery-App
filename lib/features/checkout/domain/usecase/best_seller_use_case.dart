
import 'package:injectable/injectable.dart';
import '../repository/checkout_repository.dart';


@injectable
class CheckoutUseCase {
  final CheckoutRepository _checkoutRepository;
  CheckoutUseCase(this._checkoutRepository);


  }