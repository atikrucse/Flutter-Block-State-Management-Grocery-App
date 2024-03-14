import 'package:bloc_project/features/cart/ui/cart.dart';
import 'package:bloc_project/features/home/bloc/home_bloc.dart';
import 'package:bloc_project/features/home/ui/product_tile_widget.dart';
import 'package:bloc_project/features/wishlist/ui/wish_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {

    super.initState();
    homeBloc.add(HomeInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,

      listenWhen: (previous, current) => current is HomeActionState, //When I get an Action State / Going to listen Action State
      buildWhen: (previous, current) => current is !HomeActionState, //When I don't get an Action State / Going to listen Non-Action State

      //Now Listen to my States
      listener: (context, state) {
        if (state is HomeNavigateToWishListPageActionState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => WishList()));
        } else if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
        } else if (state is HomeProductItemWishListedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item added to Wish List!!')));
        } else if (state is HomeProductItemCartedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item added to Cart!!')));
        }
      },

      //Build according to State
      builder: (context, state) {
       switch (state.runtimeType) {
         case HomeLoadingState:
           return Scaffold(
             body: Center(
               child: CircularProgressIndicator(),
             ),
           );

         case HomeLoadedSuccessState:
           final successState = state as HomeLoadedSuccessState;
           return Scaffold(
             appBar: AppBar(
               title: const Text("Bloc Grocery App", style: TextStyle(color: Colors.white),),
               actions: [
                 IconButton(
                     onPressed: (){
                       homeBloc.add(HomeWishListButtonNavigateEvent());
                     },
                     icon: const Icon(Icons.favorite, color: Colors.white,)
                 ),
                 IconButton(
                     onPressed: (){
                       homeBloc.add(HomeCartButtonNavigateEvent());
                     },
                     icon: const Icon(Icons.shopping_cart, color: Colors.white,)
                 ),
               ],
               backgroundColor: Colors.blue,
             ),
             body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    return ProductTileWidget(
                        homeBloc: homeBloc,
                        productDataModel: successState.products[index],
                        cartItemList: successState.cartItems,
                        wishListItemList: successState.wishListItems,
                    );
                  }),
            );

         case HomeErrorState:
           return Scaffold(
             body: Center(
               child: Text("Error"),
             ),
           );

         default:
           return SizedBox();
       }
      },
    );
  }

}
