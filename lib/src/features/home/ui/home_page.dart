import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql/client.dart';
import 'package:marketplace/src/common/models/customer_model.dart';
import 'package:marketplace/src/common/models/offer_model.dart';
import 'package:marketplace/src/common/utils/utils.dart';
import 'package:marketplace/src/common/widgets/rounded_button_widget.dart';
import 'package:marketplace/src/features/home/data/home_repository.dart';
import 'package:marketplace/src/features/offer/data/offer_repository.dart';
import 'package:marketplace/src/features/home/logic/home_cubit.dart';
import 'package:marketplace/src/features/offer/ui/offer_page.dart';
import 'package:marketplace/src/common/constants/theme.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  final HomeRepository repository;

  const HomePage({
    Key? key,
    required this.repository,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeCubit cubit = HomeCubit(widget.repository);

  @override
  void initState() {
    super.initState();
    cubit.getCustomer();
  }

  @override
  Widget build(BuildContext context) => Material(
        color: AppColors.black,
        child: SafeArea(
          child: BlocBuilder<HomeCubit, HomeState>(
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
          Card(
            color: Colors.black,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
            margin: EdgeInsets.zero,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xff444241),
                        backgroundImage: NetworkImage(
                          'https://i1.sndcdn.com/artworks-000342907488-4512j6-t500x500.jpg',
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Hi, ${customer.name}',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: DesignTokens.fontMD,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  _BalanceWidget(customer.balance),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: _OffersWidget(
                customer.offers,
                onNavigateToOfferPage: (offer) => _onNavigateToOfferPage(
                  context,
                  offer: offer,
                ),
              ),
            ),
          ),
        ],
      );

  Future<void> _onNavigateToOfferPage(
    BuildContext context, {
    required OfferModel offer,
  }) async {
    final updatedCustomer = await Navigator.push<CustomerModel>(
      context,
      MaterialPageRoute(
        builder: (context) => OfferPage(
          offer: offer,
          balance: customer.balance,
          purchaseRepository: GraphQLOfferRepository(
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
  Widget build(BuildContext context) => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Color(0xfff5fe88),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.money_rounded,
                size: 30,
              ),
              const SizedBox(height: 20),
              Text(
                'Total Balance',
                style: TextStyle(
                  color: AppColors.black.withOpacity(0.5),
                  fontSize: DesignTokens.fontSM,
                ),
              ),
              Text(
                Utils.formatToMonetaryValueFromInteger(balance),
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: DesignTokens.fontXXL,
                ),
              ),
            ],
          ),
        ),
      );
}

class _OffersWidget extends StatelessWidget {
  final List<OfferModel> offers;
  final void Function(OfferModel)? onNavigateToOfferPage;

  const _OffersWidget(
    this.offers, {
    Key? key,
    this.onNavigateToOfferPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Offers',
            style: TextStyle(
              fontSize: DesignTokens.fontLG,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: offers.length,
              itemBuilder: (context, index) => _OfferTileWidget(
                offers[index],
                onTap: () => onNavigateToOfferPage?.call(offers[index]),
              ),
            ),
          ),
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
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            stops: [0, 0.8],
            colors: [
              Colors.grey.shade900.withOpacity(0.8),
              Colors.black,
            ],
          ),
        ),
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(
            offer.product.name,
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            Utils.formatToMonetaryValueFromInteger(
              offer.price,
            ),
            style: TextStyle(
              color: AppColors.grey.withOpacity(0.6),
            ),
          ),
          trailing: RoundedButtonWidget(
            label: 'More',
            onTap: onTap,
          ),
          onTap: onTap,
        ),
      );
}
