import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/src/data/repositories/customer_repository.dart';
import 'package:marketplace/src/logic/customer_cubit.dart';
import 'package:marketplace/src/ui/product_details_page.dart';
import 'package:marketplace/src/utils/utils.dart';

class HomePage extends StatefulWidget {
  final CustomerRepository repository;

  const HomePage({
    Key? key,
    required this.repository,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CustomerCubit cubit = CustomerCubit(widget.repository);

  @override
  void initState() {
    super.initState();
    cubit.getCustomer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: BlocBuilder<CustomerCubit, CustomerState>(
            bloc: cubit,
            builder: (context, state) {
              if (state.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.customer != null) {
                final customer = state.customer!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Utils.formatToMonetaryValueFromInteger(
                              customer.balance,
                            ),
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Total Balance',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Theme.of(context).accentColor,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Offers',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: customer.offers.length,
                        itemBuilder: (context, index) => Card(
                          child: ListTile(
                            leading: Image.network(
                                customer.offers[index].product.image),
                            title: Text(
                              customer.offers[index].product.name,
                            ),
                            subtitle: Text(
                              Utils.formatToMonetaryValueFromInteger(
                                customer.offers[index].price,
                              ),
                            ),
                            trailing: Icon(Icons.arrow_right_alt),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OfferDetailsPage(
                                    offer: customer.offers[index],
                                    balance: customer.balance,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}
