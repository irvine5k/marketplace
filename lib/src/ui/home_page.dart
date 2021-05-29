import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql/client.dart';
import 'package:marketplace/src/data/models/customer_model.dart';
import 'package:marketplace/src/data/models/offer_model.dart';
import 'package:marketplace/src/data/repositories/customer_repository.dart';
import 'package:marketplace/src/data/repositories/purchase_repository.dart';
import 'package:marketplace/src/logic/customer_cubit.dart';
import 'package:marketplace/src/ui/offer_details_page.dart';
import 'package:marketplace/src/utils/utils.dart';
import 'package:marketplace/theme.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
        color: AppColors.purple,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _BalanceWidget(customer.balance),
              CircleAvatar(
                backgroundColor: AppColors.grey,
                child: Text('KG'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _OffersWidget(
              customer.offers,
              onNavigateToProductDetails: (offer) => _onNavigateToDetailsPage(
                context,
                offer: offer,
              ),
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
        padding: const EdgeInsets.symmetric(vertical: DesignTokens.sizeM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Utils.formatToMonetaryValueFromInteger(balance),
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: DesignTokens.fontXXL,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Total Balance',
              style: TextStyle(
                color: AppColors.white.withOpacity(0.8),
                fontSize: DesignTokens.fontSM,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Offers',
            style: TextStyle(
              fontSize: DesignTokens.fontXL,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: offers.length,
              itemBuilder: (context, index) => _OfferTileWidget(
                offers[index],
                onTap: () => onNavigateToProductDetails?.call(offers[index]),
              ),
            ),
          )
        ],
      );
}

class _OfferTileWidget extends StatelessWidget {
  final OfferModel offer;
  final VoidCallback onTap;

  const _OfferTileWidget(
    this.offer, {
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          leading: CachedNetworkImage(
            imageUrl: offer.product.image,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, dynamic _) => Icon(Icons.error),
          ),
          title: Text(
            offer.product.name,
          ),
          subtitle: Text(
            Utils.formatToMonetaryValueFromInteger(
              offer.price,
            ),
          ),
          trailing: Icon(
            Icons.arrow_right_alt,
            color: AppColors.purple,
          ),
          onTap: onTap,
        ),
      );
}
