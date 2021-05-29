import 'package:flutter/material.dart';
import 'package:marketplace/src/data/models/offer_model.dart';
import 'package:marketplace/src/utils/utils.dart';
import 'package:marketplace/theme.dart';

class OfferDetailsPage extends StatefulWidget {
  final OfferModel offer;
  final int balance;

  const OfferDetailsPage({
    Key? key,
    required this.offer,
    required this.balance,
  }) : super(key: key);

  @override
  _OfferDetailsPageState createState() => _OfferDetailsPageState();
}

class _OfferDetailsPageState extends State<OfferDetailsPage> {
  @override
  Widget build(BuildContext context) {
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
          onPressed: () => onPurchase(widget.offer.id),
          child: Text('Buy'),
        )
      ],
    );
  }
}
