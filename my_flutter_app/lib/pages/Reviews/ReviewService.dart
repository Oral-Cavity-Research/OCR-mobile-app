import 'package:http/src/response.dart';
import 'package:my_flutter_app/dto/ReviewRequestDto.dart';

import '../../URL.dart';


class ReviewService {
  Future<Response> createRequest(
      ReviewRequest entryData,String teleconId) async {
    final response = await addReview(
        entryData.provisionalDiagnosis,
        entryData.managementSuggestions,
        entryData.referralSuggestions,
        entryData.otherComments,
        teleconId
    );
    return response;
  }
}
