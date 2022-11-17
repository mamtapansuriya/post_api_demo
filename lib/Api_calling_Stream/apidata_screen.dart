import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:post_api_demo/Api_calling_Stream/apidata_model.dart';

class ApiDataScreen extends StatelessWidget {
  ApiDataScreen({Key? key}) : super(key: key);
  List<ApiDataModel> apiDataList = [];
  Stream<List<ApiDataModel>> getDataStream() async* {
    var client = http.Client();
    try {
      const String fullURL =
          "http://sgcricketnew.cricketfeed.co.in/api/values/LiveSeries";
      final response = await client.get(Uri.parse(fullURL));
      apiDataList = apiDataModelFromJson(response.body);
      // print("apiDataList length is====${apiDataList.length}");
      yield apiDataList;
    } catch (e) {
      print("Post Api Error--->$e");
      client.close();
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("Api Data")),
      body:
          // StreamBuilder<dynamic>(
          //   stream: ApiDataStream().apiDataSteam,
          //   builder: (context, snapshot) {
          //     print("data is===${snapshot.data}");
          //     if (snapshot.hasData) {
          //       return ListView.builder(
          //           itemCount: apiDataList.length,
          //           itemBuilder: (context, index) {
          //             var data = apiDataList[index];
          //             return ListTile(
          //               title: Text(data.seriesname.toString()),
          //               subtitle: Text(data.seriesid.toString()),
          //             );
          //           });
          //     } else if (snapshot.hasError) {
          //       return const Text("snapshot as Error");
          //     } else {
          //       return const SizedBox();
          //     }
          //   },
          // ),
          StreamBuilder<List<ApiDataModel>>(
        stream: getDataStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: apiDataList.length,
                itemBuilder: (context, index) {
                  var data = apiDataList[index];
                  return ListTile(
                    title: Text(
                      data.seriesname.toString(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.seriesid.toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          data.startdate.toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          data.enddate.toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return const Text(
              "snapshot as Error",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    ));
  }
}
