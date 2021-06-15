import 'package:flutter/material.dart';

import 'package:gql_http_link/gql_http_link.dart';
import 'package:ferry/ferry.dart';
import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:gql_unions/get-data.data.gql.dart';
import 'package:gql_unions/get-data.req.gql.dart';
import 'package:gql_unions/get-data.var.gql.dart';

final link = HttpLink('http://172.20.10.3:3000');

final client = Client(link: link);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontSize: 12, color: Colors.black);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(
        color: Colors.white,
        child: Operation(
          client: client,
          operationRequest: GgetDataReq(),
          builder: (
            BuildContext context,
            OperationResponse<GgetDataData, GgetDataVars>? response,
            Object? error,
          ) {
            if (response == null)
              return Center(child: Text('No response', style: style));

            if (response.loading)
              return Center(child: CircularProgressIndicator());

            final data = response.data;
            final errors = response.graphqlErrors;
            if (errors != null && errors.isNotEmpty)
              return Center(
                  child: Text(
                'Errors: ' + errors.join(),
                style: style,
              ));

            final exception = response.linkException;
            if (exception != null)
              return Center(
                  child: Text(
                'Exception: ' + exception.toString(),
                style: style,
              ));

            if (data == null)
              return Center(
                  child: Text(
                'No data',
                style: style,
              ));

            // This checks if the response is a success object from the union type
            // and should work
            if (data.getData is GgetDataData_getData__asSuccess) {
              return Center(
                  child: Text(
                'Correctly received union data with type __asSuccess',
                style: style,
              ));
            }

            // This checks if the response is an error object from the union type
            // and should work
            if (data.getData is GgetDataData_getData__asError) {
              return Center(
                  child: Text(
                'Correctly received union data with type __asError',
                style: style,
              ));
            }

            // This will show if the type isn't checked previously and happens
            // with code obfuscation
            return Center(
                child: Text(
              'Failed: Data is returned without a known type!',
              style: style,
            ));
          },
        ),
      ),
    );
  }
}
