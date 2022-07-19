abstract class ShopStates {}
class ShopInitialState extends ShopStates{}
class ShopChangeBottomNavState extends ShopStates{}
class ShopLoadingHomeState extends ShopStates{}
class ShopSuccessHomeState extends ShopStates{}
class ShopErrorHomeState extends ShopStates{}
class ShopLoadingCategoriesState extends ShopStates{}
class ShopSuccessCategoriesState extends ShopStates{}
class ShopErrorCategoriesState extends ShopStates{}
class ShopSuccessFavoritesState extends ShopStates{}
class ShopErrorFavoritesState extends ShopStates{}



class ShopLoadingProfileState extends ShopStates{}
class ShopSuccessProfileState extends ShopStates{}
class ShopErrorProfileState extends ShopStates{}


class ShopUpdateUserLoadingState extends ShopStates{}
class ShopUpdateUserSuccessState extends ShopStates{}
class ShopUpdateUserErrorState extends ShopStates{}


class ShopQuantityIncrementState extends ShopStates{}
class ShopQuantityDecrementState extends ShopStates{}


class ShopQuantityOfBasketIncrementState extends ShopStates{}
class ShopQuantityOfBasketDecrementState extends ShopStates{}


class ShopRemoveItemFromBasketState extends ShopStates{}

class ShopToggleThemeState extends ShopStates{}