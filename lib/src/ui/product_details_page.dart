import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketplace/src/data/models/customer_model.dart';
import 'package:marketplace/src/data/models/offer_model.dart';
import 'package:marketplace/src/data/repositories/purchase_repository.dart';
import 'package:marketplace/src/logic/purchase_cubit.dart';
import 'package:marketplace/src/utils/utils.dart';
import 'package:marketplace/theme.dart';

class OfferDetailsPage extends StatefulWidget {
  final OfferModel offer;
  final int balance;
  final PurchaseRepository purchaseRepository;

  const OfferDetailsPage({
    Key? key,
    required this.offer,
    required this.balance,
    required this.purchaseRepository,
  }) : super(key: key);

  @override
  _OfferDetailsPageState createState() => _OfferDetailsPageState();
}

class _OfferDetailsPageState extends State<OfferDetailsPage> {
  late PurchaseCubit purchaseCubit = PurchaseCubit(widget.purchaseRepository);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PurchaseCubit, PurchaseState>(
        bloc: purchaseCubit,
        listener: (context, state) {
          if (state.purchaseResponse != null) {
            final purchaseResponse = state.purchaseResponse!;

            if (purchaseResponse.success) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Success'),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop<CustomerModel>(
                          context,
                          purchaseResponse.customer,
                        );
                      },
                      child: Text('Back to Home'),
                    ),
                  ],
                ),
              );
            } else {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Error'),
                  content: Text(purchaseResponse.errorMessage),
                  actions: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Back to Home'),
                    ),
                  ],
                ),
              );
            }
          }
        },
        builder: (context, snapshot) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2,
                          alignment: Alignment.bottomLeft,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.offer.product.image),
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Theme.of(context).primaryColor,
                            ),
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              widget.offer.product.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: AppColors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(widget.offer.product.description),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios),
                    ),
                  ],
                ),
              ),
            ),
            persistentFooterButtons: [
              Text(
                Utils.formatToMonetaryValueFromInteger(
                  widget.offer.price,
                ),
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 16,
                    ),
              ),
              ElevatedButton(
                onPressed: () => purchaseCubit.purchase(widget.offer.id),
                child: Text('Buy'),
              )
            ],
          );
        });
  }

  @override
  void dispose() {
    purchaseCubit.close();
    super.dispose();
  }
}
