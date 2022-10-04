import 'package:dartz/dartz.dart';

import '../clock_timer.imports.dart';
import 'package:ntp/ntp.dart';

class ServerTimeNTPRepository implements IServerTimeRepository {
  @override
  Future<Either<Exception, DateTime>> getTime() async {
    final localTime = DateTime.now();
    var timeout = true;
    var offset;

    try {
      offset = await NTP.getNtpOffset(lookUpAddress: 'time.cloudflare.com', localTime: localTime).timeout(
        Duration(seconds: 3),
        onTimeout: () async {
          throw ("Timeout!");
        },
      );
    } catch (e) {
      return left(Exception());
    }
    return right(
      localTime.add(Duration(milliseconds: offset)),
    );
  }
  //
}
