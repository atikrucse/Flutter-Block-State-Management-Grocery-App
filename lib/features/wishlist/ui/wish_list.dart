import 'package:bloc_project/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:bloc_project/features/wishlist/ui/wish_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {

  final WishlistBloc wishListBloc = WishlistBloc();

  @override
  void initState() {
    wishListBloc.add(WishListInitialEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Wish List Page"),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocConsumer<WishlistBloc, WishlistState>(
          bloc: wishListBloc,

          listenWhen: (previous, current) => current is WishlistActionState,

          buildWhen: (previous, current) => current is !WishlistActionState,

          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case WishListSuccessState:
                final successState = state as WishListSuccessState;

                return ListView.builder(
                  itemCount: successState.wishListItems.length,
                  itemBuilder: (context, index) {
                    return WishListTile(
                        wishListBloc: wishListBloc,
                        productDataModel: successState.wishListItems[index]);
                  },
                );

              default:
                return const SizedBox();
            }
          },
        )
    );
  }
}
