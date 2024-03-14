
import 'package:bloc_project/features/home/models/home_product_data_model.dart';
import 'package:bloc_project/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter/material.dart';

class WishListTile extends StatelessWidget {

  final ProductDataModel productDataModel;
  final WishlistBloc wishListBloc;
  const WishListTile({super.key, required this.productDataModel, required this.wishListBloc});

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
                        wishListBloc.add(WishListRemoveFromWishListEvent(productDataModel));
                      },
                      icon: const Icon(Icons.favorite)
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
