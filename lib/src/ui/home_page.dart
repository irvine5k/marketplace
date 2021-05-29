import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql/client.dart';
import 'package:marketplace/src/data/models/customer_model.dart';
import 'package:marketplace/src/data/models/offer_model.dart';
import 'package:marketplace/src/data/repositories/customer_repository.dart';
import 'package:marketplace/src/data/repositories/purchase_repository.dart';
import 'package:marketplace/src/logic/customer_cubit.dart';
import 'package:marketplace/src/ui/product_details_page.dart';
import 'package:marketplace/src/utils/utils.dart';
import 'package:provider/provider.dart';

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
  Widget build(BuildContext context) => Material(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
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
                  return _HomeBodyWidget(
                    customer: customer,
                    onUpdateCustomer: cubit.setCustomer,
                  );
                }

                return Container();
              },
            ),
          ),
        ),
      );

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }
}

class _HomeBodyWidget extends StatelessWidget {
  final CustomerModel customer;
  final void Function(CustomerModel?) onUpdateCustomer;

  const _HomeBodyWidget({
    Key? key,
    required this.customer,
    required this.onUpdateCustomer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          _BalanceWidget(customer.balance),
          const SizedBox(height: 20),
          _OffersWidget(
            customer.offers,
            onNavigateToProductDetails: (offer) => _onNavigateToDetailsPage(
              context,
              offer: offer,
            ),
          ),
        ],
      );

  Future<void> _onNavigateToDetailsPage(
    BuildContext context, {
    required OfferModel offer,
  }) async {
    final updatedCustomer = await Navigator.push<CustomerModel>(
      context,
      MaterialPageRoute(
        builder: (context) => OfferDetailsPage(
          offer: offer,
          balance: customer.balance,
          purchaseRepository: GraphQLPurchaseRepository(
            Provider.of<GraphQLClient>(context),
          ),
        ),
      ),
    );

    onUpdateCustomer(updatedCustomer);
  }
}

class _BalanceWidget extends StatelessWidget {
  const _BalanceWidget(
    this.balance, {
    Key? key,
  }) : super(key: key);

  final int balance;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Utils.formatToMonetaryValueFromInteger(balance),
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 5),
            Text(
              'Total Balance',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Theme.of(context).accentColor,
                  ),
            ),
          ],
        ),
      );
}

class _OffersWidget extends StatelessWidget {
  final List<OfferModel> offers;
  final void Function(OfferModel)? onNavigateToProductDetails;

  const _OffersWidget(
    this.offers, {
    Key? key,
    this.onNavigateToProductDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(
            'Offers',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: offers.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  leading: Image.network(offers[index].product.image),
                  title: Text(
                    offers[index].product.name,
                  ),
                  subtitle: Text(
                    Utils.formatToMonetaryValueFromInteger(
                      offers[index].price,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_right_alt),
                  onTap: () => onNavigateToProductDetails?.call(offers[index]),
                ),
              ),
            ),
          )
        ],
      );
}
