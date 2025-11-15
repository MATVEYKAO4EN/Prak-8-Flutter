import 'package:get_it/get_it.dart';
import 'models/warehouse_store.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<WarehouseStore>(() => WarehouseStore());
}