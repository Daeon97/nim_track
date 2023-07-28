// ignore_for_file: public_member_api_docs

import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dartz/dartz.dart';

mixin class GraphQLOperationHandler {
  Future<T1> call<T1, T2>({
    required String graphQLDocument,
    required Function1<T2, T1> handler,
  }) async {
    final graphQLOperation = Amplify.API.query<String>(
      request: GraphQLRequest<String>(
        document: graphQLDocument,
      ),
    );

    final graphQLResponse = await graphQLOperation.response;

    final data = graphQLResponse.data;

    if (data == null) {
      throw Exception();
    }

    final maybeJson = jsonDecode(data) as T2;

    return handler(maybeJson);
  }
}
