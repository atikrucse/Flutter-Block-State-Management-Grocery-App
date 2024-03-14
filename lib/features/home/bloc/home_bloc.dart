import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_project/data/cart_items.dart';
import 'package:bloc_project/data/grocery_data.dart';
import 'package:bloc_project/data/wishlist_items.dart';
import 'package:meta/meta.dart';

import '../models/home_product_data_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeWishListButtonNavigateEvent>(homeWishListButtonNavigateEvent); //Register HomeWishListButtonNavigateEvent in Event Handler
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
    on<HomeProductWishListButtonClickedEvent>(homeProductWishListButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
  }

  FutureOr<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    // await Future.delayed(Duration(seconds: 3));

    final productList = await GroceryData.groceryProducts.map((e) => ProductDataModel(
      e['id'].toString(),
      e['name'],
      e['description'],
      e['price'].toDouble(),
      e['imageUrl'],
    )).toList();

    final cartItemList = await cartItems;
    final wishListItemList = await wishListItems;

    emit(HomeLoadedSuccessState(productList, cartItemList, wishListItemList));
  }

  FutureOr<void> homeWishListButtonNavigateEvent(HomeWishListButtonNavigateEvent event, Emitter<HomeState> emit) {

    emit(HomeNavigateToWishListPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {

    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeProductWishListButtonClickedEvent(HomeProductWishListButtonClickedEvent event, Emitter<HomeState> emit) async {

    final wishListItemList = await wishListItems.toList(); // Convert to list

    if (wishListItemList.map((e) => e.id).contains(event.clickedProduct.id)) {
      wishListItemList.removeWhere((item) => item.id == event.clickedProduct.id);
    } else {
      wishListItemList.add(event.clickedProduct);
    }

    wishListItems.clear();
    wishListItems.addAll(wishListItemList);

    final productList = await GroceryData.groceryProducts.map((e) => ProductDataModel(
      e['id'].toString(),
      e['name'],
      e['description'],
      e['price'].toDouble(),
      e['imageUrl'],
    )).toList();

    final cartItemList = await cartItems;

    emit(HomeProductItemWishListedActionState());
    emit(HomeLoadedSuccessState(productList, cartItemList, wishListItemList));

  }

  FutureOr<void> homeProductCartButtonClickedEvent(HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) async {

    final cartItemList = await cartItems.toList();

    if(cartItemList.map((e) => e.id).contains(event.clickedProduct.id)) {
      cartItemList.removeWhere((item) => item.id == event.clickedProduct.id);
    } else {
      cartItemList.add(event.clickedProduct);
    }

    cartItems.clear();
    cartItems.addAll(cartItemList);

    final productList = await GroceryData.groceryProducts.map((e) => ProductDataModel(
      e['id'].toString(),
      e['name'],
      e['description'],
      e['price'].toDouble(),
      e['imageUrl'],
    )).toList();

    final wishListItemList = await wishListItems;

    emit(HomeProductItemCartedActionState());
    emit(HomeLoadedSuccessState(productList, cartItemList, wishListItemList));
  }
}
