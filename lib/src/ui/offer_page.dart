import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/src/data/models/customer_model.dart';
import 'package:marketplace/src/data/models/offer_model.dart';
import 'package:marketplace/src/data/models/product_model.dart';
import 'package:marketplace/src/data/repositories/offer_repository.dart';
import 'package:marketplace/src/logic/offer_cubit.dart';
import 'package:marketplace/src/ui/widgets/text_button_widget.dart';
import 'package:marketplace/src/utils/utils.dart';
import 'package:marketplace/theme.dart';

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
        appBar: _appBar,
        body: SafeArea(
          child: _ProductDetailsBodyWidget(widget.offer.product),
        ),
        persistentFooterButtons: [
          TextButtonWidget(
            label: 'Buy Now ${Utils.formatToMonetaryValueFromInteger(
              widget.offer.price,
            )}',
            onTap: state.isLoading
                ? null
                : () => purchaseCubit.purchase(widget.offer.id),
          )
        ],
      ),
    );
  }

  void blocListener(BuildContext context, OfferState state) {
    if (state.purchaseResponse != null) {
      final purchaseResponse = state.purchaseResponse!;

      if (purchaseResponse.success) {
        Utils.showCustomDialog(
          context,
          title: 'Success',
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop<CustomerModel>(
              context,
              purchaseResponse.customer,
            );
          },
          buttonLabel: 'Back to Home',
        );
      } else {
        Utils.showCustomDialog(
          context,
          title: 'Error',
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
          backgroundColor: AppColors.white,
          iconTheme: IconThemeData(
            color: AppColors.purple,
          ),
          title: Text(
            title,
            style: TextStyle(
              color: AppColors.purple,
            ),
          ),
        ),
      );
}

class _ProductDetailsBodyWidget extends StatelessWidget {
  final ProductModel product;

  const _ProductDetailsBodyWidget(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(product.image),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(product.description),
            ),
          ],
        ),
      );
}
