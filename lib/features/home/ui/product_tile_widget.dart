
import 'package:bloc_project/features/home/bloc/home_bloc.dart';
import 'package:bloc_project/features/home/models/home_product_data_model.dart';
import 'package:flutter/material.dart';

class ProductTileWidget extends StatelessWidget {

  final ProductDataModel productDataModel;
  final List<ProductDataModel> cartItemList;
  final List<ProductDataModel> wishListItemList;
  final HomeBloc homeBloc;
  const ProductTileWidget({
    super.key,
    required this.productDataModel,
    required this.cartItemList,
    required this.wishListItemList,
    required this.homeBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(10)
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(productDataModel.imageUrl),
                  fit: BoxFit.cover
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Text(productDataModel.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          Text(productDataModel.description),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$'+ productDataModel.price.toString()),
              Row(
                children: [
                  IconButton(
                      onPressed: (){
                        homeBloc.add(HomeProductWishListButtonClickedEvent(productDataModel));
                      },
                      icon: Icon(
                        wishListItemList.map((e) => e.id).contains(productDataModel.id)
                            ? Icons.favorite
                            : Icons.favorite_outline,
                      )

                  ),
                  IconButton(
                      onPressed: (){
                        homeBloc.add(HomeProductCartButtonClickedEvent(productDataModel));
                      },
                      icon: Icon(
                        cartItemList.map((e) => e.id).contains(productDataModel.id)
                            ? Icons.shopping_cart
                            : Icons.add_shopping_cart
                      ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
