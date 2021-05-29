import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketplace/src/common/models/customer_model.dart';
import 'package:marketplace/src/features/home/data/home_repository.dart';
import 'package:marketplace/src/features/home/logic/home_cubit.dart';

import '../../../mocks.dart';

final _customer =
    CustomerModel.fromJson(Mocks.createCustomerJsonWithCustomBalance());

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
          Mocks.createCustomerJsonWithCustomBalance(balance: 90000),
        ),
      );
    },
    expect: () => [
      HomeState.loading(),
      HomeState.fetched(_customer),
      HomeState.fetched(
        CustomerModel.fromJson(
          Mocks.createCustomerJsonWithCustomBalance(balance: 90000),
        ),
      ),
    ],
  );
}
