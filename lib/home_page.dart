import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static String routeName = '';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String quote = "";
  bool isLoading = false;
  Dio dio = Dio();
  @override
  void initState() {
    super.initState();
    getQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 500,
              child: Text(
                "$quote",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            if (isLoading)
              CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: () async {
                  await getQuote();
                },
                child: Text("Generate random quote"),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> getQuote() async {
    // num = num + 1;
    isLoading = true;
    setState(() {});
    var response = await dio.get("https://quotes-api-self.vercel.app/quote");
    print(response);
    quote = response.data["quote"];
    // await Future.delayed(Duration(seconds: 3));
    // num = num + 1;
    isLoading = false;
    setState(() {});
  }
}
