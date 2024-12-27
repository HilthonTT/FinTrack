import 'dart:convert';

import 'package:fintrack_app/core/common/utils/error_parser.dart';
import 'package:fintrack_app/core/common/utils/http_helper.dart';
import 'package:fintrack_app/core/common/utils/status_codes.dart';
import 'package:fintrack_app/core/enums/company.dart';
import 'package:fintrack_app/features/expenses/data/models/expense_model.dart';
import 'package:fintrack_app/features/expenses/domain/enums/expense_category.dart';

abstract interface class ExpenseRemoteDataSource {
  Future<ExpenseModel> getById({required String id});

  Future<List<ExpenseModel>> getAll({int take = 10});

  Future<String> create({
    required String name,
    required double amount,
    required String currencyCode,
    required ExpenseCategory category,
    required Company company,
    required DateTime date,
  });

  Future<void> update({
    required String id,
    required String name,
    required double amount,
    required DateTime date,
  });

  Future<void> delete({required String id});
}

final class ExpenseRemoteDataSourceImpl implements ExpenseRemoteDataSource {
  @override
  Future<String> create({
    required String name,
    required double amount,
    required String currencyCode,
    required ExpenseCategory category,
    required Company company,
    required DateTime date,
  }) async {
    final response = await postRequest("/expenses", {
      'name': name,
      'amount': amount,
      'currencyCode': currencyCode,
      'category': category.index,
      'company': company.index,
      'date': date.toIso8601String(),
    });

    if (!isSuccessfulResponse(response.statusCode)) {
      throw parseError(response);
    }

    final responseData = jsonDecode(response.body);

    return responseData.toString();
  }

  @override
  Future<void> delete({required String id}) async {
    final response = await deleteRequest("/expenses/$id");

    if (!isSuccessfulResponse(response.statusCode)) {
      throw parseError(response);
    }
  }

  @override
  Future<List<ExpenseModel>> getAll({int take = 10}) async {
    final response = await getRequest("/expenses?take=$take");

    if (!isSuccessfulResponse(response.statusCode)) {
      throw parseError(response);
    }

    final List<dynamic> responseData = jsonDecode(response.body);

    final List<ExpenseModel> expenses =
        responseData.map((data) => ExpenseModel.fromJson(data)).toList();

    return expenses;
  }

  @override
  Future<ExpenseModel> getById({required String id}) async {
    final response = await getRequest("/expenses/$id");

    if (!isSuccessfulResponse(response.statusCode)) {
      throw parseError(response);
    }

    final dynamic responseData = jsonDecode(response.body);

    final expense = ExpenseModel.fromJson(responseData);

    return expense;
  }

  @override
  Future<void> update({
    required String id,
    required String name,
    required double amount,
    required DateTime date,
  }) async {
    final response = await postRequest("/expenses/$id", {
      'name': name,
      'amount': amount,
      'date': date.toIso8601String(),
    });

    if (!isSuccessfulResponse(response.statusCode)) {
      throw parseError(response);
    }
  }
}