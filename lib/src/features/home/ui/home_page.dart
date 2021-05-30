import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql/client.dart';
import 'package:marketplace/src/common/models/customer_model.dart';
import 'package:marketplace/src/common/models/offer_model.dart';
import 'package:marketplace/src/common/utils/utils.dart';
import 'package:marketplace/src/common/widgets/error_widget.dart';
import 'package:marketplace/src/common/widgets/rounded_button_widget.dart';
import 'package:marketplace/src/common/widgets/rounded_card_widget.dart';
import 'package:marketplace/src/common/widgets/rounded_tile_widget.dart';
import 'package:marketplace/src/features/home/data/home_repository.dart';
import 'package:marketplace/src/features/offer/data/offer_repository.dart';
import 'package:marketplace/src/features/home/logic/home_cubit.dart';
import 'package:marketplace/src/features/offer/ui/offer_page.dart';
import 'package:marketplace/src/common/constants/theme.dart';
import 'package:provider/provider.dart';

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
              } else if (state.hasError) {
                return CustomErrorWidget(onRetry: cubit.getCustomer);
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
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _UserHeaderWidget(name: customer.name),
            const SizedBox(height: 40),
            _BalanceWidget(customer.balance),
            const SizedBox(height: 20),
            Expanded(
              child: _OffersWidget(
                customer.offers,
                onNavigateToOfferPage: (offer) => _onNavigateToOfferPage(
                  context,
                  offer: offer,
                ),
              ),
            ),
          ],
        ),
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

class _UserHeaderWidget extends StatelessWidget {
  final String name;

  const _UserHeaderWidget({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        children: [
          CachedNetworkImage(
            imageUrl:
                'https://i1.sndcdn.com/artworks-000342907488-4512j6-t500x500.jpg',
            imageBuilder: (context, imageProvider) => CircleAvatar(
              backgroundImage: imageProvider,
            ),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, dynamic _) => Icon(Icons.error),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            'Hi, $name',
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: DesignTokens.fontMD,
            ),
          ),
        ],
      );
}

class _BalanceWidget extends StatelessWidget {
  const _BalanceWidget(
    this.balance, {
    Key? key,
  }) : super(key: key);

  final int balance;

  @override
  Widget build(BuildContext context) => RoundedCardWidget.withSolidColor(
        color: AppColors.lightGreen,
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
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _OfferTileWidget(
                  offers[index],
                  onTap: () => onNavigateToOfferPage?.call(offers[index]),
                ),
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
  Widget build(BuildContext context) => RoundedTileWidget(
        title: offer.product.name,
        description: Utils.formatToMonetaryValueFromInteger(
          offer.price,
        ),
        trailing: RoundedButtonWidget.light(
          label: 'More',
          onTap: onTap,
        ),
        onTap: onTap,
      );
}
