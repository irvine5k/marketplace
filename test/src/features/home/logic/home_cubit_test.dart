import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace/src/common/models/customer_model.dart';
import 'package:marketplace/src/features/home/data/home_repository.dart';
import 'package:marketplace/src/features/home/logic/home_cubit.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

Map<String, Object?> createCustomerJson({int balance = 1000000}) => {
      'id': 'cccc3f48-dd2c-43ba-b8de-8945e7ababab',
      'name': 'Jerry Smith',
      'balance': balance,
      'offers': [
        {
          'id': 'offer/portal-gun',
          'price': 5000,
          'product': {
            'id': 'product/portal-gun',
            'name': 'Portal Gun',
            'description':
                'The Portal Gun is a gadget that allows the user(s) to travel between different universes/dimensions/realities.',
            'image':
                'https://vignette.wikia.nocookie.net/rickandmorty/images/5/55/Portal_gun.png/revision/latest/scale-to-width-down/310?cb=20140509065310'
          }
        },
        {
          'id': 'offer/cognition-amplifier',
          'price': 1000000,
          'product': {
            'id': 'product/cognition-amplifier',
            'name': 'Cognition Amplifier',
            'description': 'The cognition amplifier makes Snuffles smart.',
            'image':
                'https://vignette.wikia.nocookie.net/rickandmorty/images/2/27/Cognition_Amplifier.png/revision/latest/scale-to-width-down/180?cb=20140604001816'
          }
        }
      ]
    };

final _customer = CustomerModel.fromJson(createCustomerJson());

void main() {
  late HomeRepository repository;

  setUp(() {
    repository = MockHomeRepository();
  });
  blocTest<HomeCubit, HomeState>(
    'When get customer is successful should emit a HomeState.fetched',
    build: () {
      when(() => repository.getCustomer()).thenAnswer((_) async => _customer);

      return HomeCubit(repository);
    },
    act: (cubit) => cubit.getCustomer(),
    expect: () => [HomeState.loading(), HomeState.fetched(_customer)],
  );

  blocTest<HomeCubit, HomeState>(
    'When get customer fails should emit a HomeState.error',
    build: () {
      when(() => repository.getCustomer()).thenThrow(Exception());

      return HomeCubit(repository);
    },
    act: (cubit) => cubit.getCustomer(),
    expect: () => [HomeState.loading(), HomeState.error()],
  );

  blocTest<HomeCubit, HomeState>(
    'When set customer a HomeState.fetched with a new Customer',
    build: () {
      when(() => repository.getCustomer()).thenAnswer((_) async => _customer);

      return HomeCubit(repository);
    },
    act: (cubit) async {
      await cubit.getCustomer();
      cubit.setCustomer(
        CustomerModel.fromJson(
          createCustomerJson(balance: 90000),
        ),
      );
    },
    expect: () => [
      HomeState.loading(),
      HomeState.fetched(_customer),
      HomeState.fetched(
        CustomerModel.fromJson(
          createCustomerJson(balance: 90000),
        ),
      ),
    ],
  );
}
