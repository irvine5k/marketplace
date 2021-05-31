import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/src/common/models/customer_model.dart';
import 'package:marketplace/src/common/models/offer_model.dart';
import 'package:marketplace/src/common/models/product_model.dart';
import 'package:marketplace/src/common/resources/messages.dart';
import 'package:marketplace/src/common/utils/utils.dart';
import 'package:marketplace/src/features/offer/data/offer_repository.dart';
import 'package:marketplace/src/features/offer/logic/offer_cubit.dart';
import 'package:marketplace/src/common/constants/theme.dart';

class OfferPage extends StatefulWidget {
  final OfferModel offer;
  final int balance;
  final OfferRepository purchaseRepository;

  const OfferPage({
    Key? key,
    required this.offer,
    required this.balance,
    required this.purchaseRepository,
  }) : super(key: key);

  @override
  _OfferPageState createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  late OfferCubit purchaseCubit = OfferCubit(widget.purchaseRepository);

  @override
  Widget build(BuildContext context) {
    final _appBar = PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: _AppBar(
        title: widget.offer.product.name,
      ),
    );

    return BlocConsumer<OfferCubit, OfferState>(
      bloc: purchaseCubit,
      listener: blocListener,
      builder: (context, state) => Scaffold(
        backgroundColor: AppColors.black,
        appBar: _appBar,
        body: SafeArea(
          child: _ProductDetailsBodyWidget(widget.offer.product),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.lightBlue,
          onPressed: () => purchaseCubit.purchase(widget.offer.id),
          label: state.isLoading
              ? CircularProgressIndicator(
                  color: AppColors.black,
                )
              : Text(
                  AppMessages.buyNow(
                    Utils.formatToMonetaryValueFromInteger(widget.offer.price),
                  ),
                  style: TextStyle(
                    color: AppColors.black,
                  ),
                ),
        ),
      ),
    );
  }

  void blocListener(BuildContext context, OfferState state) {
    if (state.hasError) {
      Utils.showCustomDialog(
        context,
        title: AppMessages.error,
        description: AppMessages.serverError,
        onPressed: () => Navigator.pop(context),
      );
    }

    if (state.purchaseResponse != null) {
      final purchaseResponse = state.purchaseResponse!;

      if (purchaseResponse.success) {
        Utils.showCustomDialog(
          context,
          title: AppMessages.success,
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop<CustomerModel>(
              context,
              purchaseResponse.customer,
            );
          },
          buttonLabel: AppMessages.backToHome,
        );
      } else {
        Utils.showCustomDialog(
          context,
          title: AppMessages.error,
          description: purchaseResponse.errorMessage,
          onPressed: () => Navigator.pop(context),
        );
      }
    }
  }

  @override
  void dispose() {
    purchaseCubit.close();
    super.dispose();
  }
}

class _AppBar extends StatelessWidget {
  final String title;

  const _AppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          elevation: 1,
          backgroundColor: AppColors.black,
          iconTheme: IconThemeData(
            color: AppColors.white,
          ),
          title: Text(
            AppMessages.offerPageAppBarTitle,
            style: TextStyle(
              color: AppColors.white,
            ),
          ),
        ),
      );
}

class _ProductDetailsBodyWidget extends StatelessWidget {
  final ProductModel product;

  const _ProductDetailsBodyWidget(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              CachedNetworkImage(
                imageUrl: product.image,
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  backgroundImage: imageProvider,
                  radius: 90,
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, dynamic _) => Icon(Icons.error),
              ),
              const SizedBox(height: 30),
              _ProductInfoWidget(product: product),
            ],
          ),
        ),
      );
}

class _ProductInfoWidget extends StatelessWidget {
  final ProductModel product;

  const _ProductInfoWidget({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: DesignTokens.fontLG,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              product.description,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      );
}
