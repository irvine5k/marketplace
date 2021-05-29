import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql/client.dart';
import 'package:marketplace/src/data/repositories/customer_repository.dart';
import 'package:marketplace/src/logic/customer_cubit.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CustomerCubit cubit = CustomerCubit(
    CustomerRepository(
      Provider.of<GraphQLClient>(context, listen: false),
    ),
  );

  @override
  void initState() {
    super.initState();
    cubit.getCustomer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerCubit, CustomerState>(
      bloc: cubit,
      builder: (context, state) {
        return Container();
      },
    );
  }
}
