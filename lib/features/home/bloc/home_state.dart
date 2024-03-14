part of 'home_bloc.dart';

@immutable

//These are Simple/Build State
abstract class HomeState {}

// These are Action State
abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

//BuildStates Start // BuildWhen
class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {

  final List<ProductDataModel> products;
  final List<ProductDataModel> cartItems;
  final List<ProductDataModel> wishListItems;

  HomeLoadedSuccessState(this.products, this.cartItems, this.wishListItems);

}

class HomeErrorState extends HomeState {}

//BuildStates End

//ActionStates Start /ListenWhen
class HomeNavigateToWishListPageActionState extends HomeActionState{}

class HomeNavigateToCartPageActionState extends HomeActionState{}

class HomeProductItemWishListedActionState extends HomeActionState {
}

class HomeProductItemCartedActionState extends HomeActionState {}
//ActionStates End