import 'dart:convert';

import 'package:fintrack_app/core/common/utils/currency_helper.dart';
import 'package:fintrack_app/core/common/utils/error_parser.dart';
import 'package:fintrack_app/core/common/utils/http_helper.dart';
import 'package:fintrack_app/core/common/utils/jwt_helper.dart';
import 'package:fintrack_app/core/common/utils/status_codes.dart';
import 'package:fintrack_app/core/constants/exceptions.dart';
import 'package:fintrack_app/core/entities/paged_list.dart';
import 'package:fintrack_app/core/enums/company.dart';
import 'package:fintrack_app/features/subscriptions/data/models/subscription_model.dart';
import 'package:fintrack_app/features/subscriptions/domain/enums/frequency.dart';

abstract interface class SubscriptionRemoteDatasource {
  Future<SubscriptionModel> getById({required String subscriptionId});

  Future<String> create({
    required String name,
    required double amount,
    required String currency,
    required Frequency frequency,
    required Company company,
    required String startDate,
    required String endDate,
  });

  Future<void> delete({required String subscriptionId});

  Future<PagedList<SubscriptionModel>> getAll({
    String? searchTerm,
    int pageSize = 10,
  });

  Future<void> update({
    required String subscriptionId,
    required String name,
    required Frequency frequency,
    required Company company,
  });

  Future<void> cancel({required String subscriptionId});
}

final class SubscriptionRemoteDatasourceImpl
    implements SubscriptionRemoteDatasource {
  @override
  Future<String> create({
    required String name,
    required double amount,
    required String currency,
    required Frequency frequency,
    required Company company,
    required String startDate,
    required String endDate,
  }) async {
    final userInfo = await getUserInfo();

    if (userInfo == null) {
      throw ServerException("Unauthorized");
    }

    try {
      final sanitizedCurrency = sanitizeCurrencyCode(currency);

      final response = await postRequest("/subscriptions", {
        'userId': userInfo.id,
        'name': name,
        'amount': amount,
        'currency': sanitizedCurrency,
        'frequency': frequency.value,
        'company': company.value,
        'startDate': startDate,
        'endDate': endDate,
      });

      if (!isSuccessfulResponse(response.statusCode)) {
        throw parseError(response);
      }

      final responseData = jsonDecode(response.body);

      return responseData.toString();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> delete({required String subscriptionId}) async {
    try {
      final response = await deleteRequest("/subscriptions/$subscriptionId");

      if (!isSuccessfulResponse(response.statusCode)) {
        throw parseError(response);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<PagedList<SubscriptionModel>> getAll({
    String? searchTerm,
    int pageSize = 10,
  }) async {
    try {
      String query = "/subscriptions?pageSize=$pageSize";
      if (searchTerm != null && searchTerm.isNotEmpty) {
        query += "&searchTerm=${Uri.encodeComponent(searchTerm)}";
      }

      final response = await getRequest(query);

      if (!isSuccessfulResponse(response.statusCode)) {
        throw parseError(response);
      }

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      final List<dynamic> itemsData = responseData['items'];
      final List<SubscriptionModel> subscriptions =
          itemsData.map((data) => SubscriptionModel.fromJson(data)).toList();

      final PagedList<SubscriptionModel> pagedList =
          PagedList<SubscriptionModel>(
        items: subscriptions,
        pageSize: responseData['pageSize'],
        totalCount: responseData['totalCount'],
        hasNextPage: responseData['hasNextPage'],
      );

      return pagedList;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<SubscriptionModel> getById({required String subscriptionId}) async {
    try {
      final response = await getRequest("/subscriptions/$subscriptionId");

      if (!isSuccessfulResponse(response.statusCode)) {
        throw parseError(response);
      }

      final dynamic responseData = jsonDecode(response.body);

      final subscription = SubscriptionModel.fromJson(responseData);

      return subscription;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> update({
    required String subscriptionId,
    required String name,
    required Frequency frequency,
    required Company company,
  }) async {
    try {
      final response = await patchRequest("/subscriptions/$subscriptionId", {
        'name': name,
        'frequency': frequency,
        'company': company,
      });

      if (!isSuccessfulResponse(response.statusCode)) {
        throw parseError(response);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> cancel({required String subscriptionId}) async {
    try {
      final response = await postRequest(
        "/subscriptions/$subscriptionId/cancel",
        {},
      );

      if (!isSuccessfulResponse(response.statusCode)) {
        throw parseError(response);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
