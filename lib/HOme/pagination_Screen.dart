import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaginationScreen extends StatefulWidget {
  const PaginationScreen({super.key});

  @override
  State<PaginationScreen> createState() => _PaginationScreenState();
}

class _PaginationScreenState extends State<PaginationScreen> {
  final ScrollController scrollController = ScrollController();
  List<dynamic> localList = [];
  bool loading = false;
  int _start = 0;
  final int _limit = 5;

  @override
  void initState() {
    super.initState();
    getPosts();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !loading) {
        _start += _limit;
        getPosts();
      }
    });
  }

  Future<void> getPosts() async {
    try {
      setState(() {
        loading = true;
      });

      var url = Uri.parse(
        'https://jsonplaceholder.typicode.com/posts?_start=$_start&_limit=$_limit',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body.toString());

        setState(() {
          localList.addAll(
            data.map((item) {
              final id = item['id'] ?? 0;
              return {
                ...item,
                "imageUrl": "https://picsum.photos/200/300?random=$id",
                "videoUrl":
                    "https://samplelib.com/lib/preview/mp4/sample-5s.mp4",
              };
            }),
          );
        });
      }
    } catch (error) {
      print('Error: $error');
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: const Text('Pagination with Media'),
      ),
      body: ListView.builder(
        controller: scrollController,
        itemCount: localList.length + (loading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < localList.length) {
            final post = localList[index];
            return Card(
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),

                    const SizedBox(height: 10),
                    if (post['imageUrl'] != null)
                      Image.network(post['imageUrl']),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          } else {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
