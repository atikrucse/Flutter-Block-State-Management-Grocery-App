part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistEvent {}

class WishListInitialEvent extends WishlistEvent {}

class WishListRemoveFromWishListEvent extends WishlistEvent {

  final ProductDataModel productDataModel;
  WishListRemoveFromWishListEvent(this.productDataModel);
}
