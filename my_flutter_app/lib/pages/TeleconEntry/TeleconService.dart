import 'package:http/src/response.dart';
import 'package:my_flutter_app/dto/TeleconEntryRequest.dart';
import '../../URL.dart';


class TeleconService {
  Future<Response> createEntry(
      TeleconEntryRequest entryData,String patientId) async {
    final response = await createTeleconEntry(
      entryData.startTime,
      entryData.endTime,
      entryData.complaint,
      entryData.findings,
      entryData.currentHabits ?? [],
      patientId
    );
    return response;
  }
}
