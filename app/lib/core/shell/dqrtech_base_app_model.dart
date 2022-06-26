import 'package:dqrtech/bootstraps/base_model.dart';
import 'package:dqrtech/core/dependency_injection/dependency_resolver.dart';
import 'package:dqrtech/services/route_service.dart';

class DqrtechBaseAppModel extends BaseModel {
 DqrtechBaseAppModel() : super();

  getRoutes() {
    return DependencyBase.createNewInstance<DqrtechRouteService>(DqrtechRouteService).routes;
  }
}
