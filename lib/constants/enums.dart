enum BottomBarScreens {
  CategoryScreen,
  HomeScreen,
  EmployeeHomeScreen,
  CartScreen,
  FavoritesScreen,
  ProfileScreen,
  OrdersScreen,
  CustomersScreen,
  SystemScreen,
  EmployeesScreen,
  ProductsScreen
}

enum TransacationTabs {
  New,
  Processing,
  Finished,
  All,
}

enum UserTypes {
  Employee,
  Customer,
  Admin,
}

enum ProductGoldPercents { Eighteen, TwentyTwo, TwentyFour, Other }

enum ProductColours { Gold, White, Rose, Other }

enum ProductVisibility { All, Premiums, PremiumAndStandarts }

enum TransactionStatuses {
  WaitToConfirm,
  Confirmed,
  WaitForPurchase,
  StartToPrepare,
  Send,
  Completed,
  Cancelled,
  NotConfirmed,
}

enum CustomerTypes {
  Premium,
  Standart,
  Other,
}

enum EmployeeStatus {
  Administor,
  Standart,
  Limited,
}

enum SearchAreaTypes {
  CustomerProducts,
  EmployeeProducts,
  Categories,
  Collections,
  Customers,
  Employess,
}

enum SortStatuses { Primary, Secondary, Standart }
