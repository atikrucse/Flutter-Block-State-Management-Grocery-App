import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/wishlist_items.dart';
import '../../home/models/home_product_data_model.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {

    on<WishListInitialEvent>(wishListInitialEvent);
    on<WishListRemoveFromWishListEvent>(wishListRemoveFromWishListEvent);
  }

  FutureOr<void> wishListInitialEvent(WishListInitialEvent event, Emitter<WishlistState> emit) {

    emit(WishListSuccessState(wishListItems));
  }

  FutureOr<void> wishListRemoveFromWishListEvent(WishListRemoveFromWishListEvent event, Emitter<WishlistState> emit) {

    wishListItems.remove(event.productDataModel);
    emit(WishListSuccessState(wishListItems));
  }
}
