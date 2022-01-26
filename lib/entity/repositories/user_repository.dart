import 'package:sms_sender/entity/models/user.dart';
import 'package:sms_sender/entity/repositories/base_repository.dart';
import 'package:sms_sender/data/network/get.dart';

Get _get = Get();

class UserRepository extends BaseRepository {
  String route = 'code-list/';
  @override
  Future<List<User>> get getData async {
    List rawData = await _get.getData(route);
    return rawData.map((json) => User.fromJson(json)).toList();
  }
}
