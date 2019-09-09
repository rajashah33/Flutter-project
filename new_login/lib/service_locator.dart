import 'package:get_it/get_it.dart';
import 'package:new_login/scoped_models/home_model.dart';
import 'package:new_login/scoped_models/login_model.dart';
import 'package:new_login/scoped_models/register_model.dart';
import 'package:new_login/services/storage_service.dart';

GetIt locator = GetIt();

void setupLocator() {
  // Register services
  locator.registerLazySingleton<StorageService>(() => StorageService());
  // locator.registerLazySingleton<AppConfig>(() => AppConfig());

  // Register models
  locator.registerLazySingleton<HomeModel>(() => HomeModel());
  locator.registerLazySingleton<LoginModel>(() => LoginModel());
  locator.registerLazySingleton<RegisterModel>(() => RegisterModel());
}
