part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistState {}

abstract class WishlistActionState {}

class WishlistInitial extends WishlistState {}

class WishListSuccessState extends WishlistState {
  final List<ProductDataModel> wishListItems;

  WishListSuccessState(this.wishListItems);
}