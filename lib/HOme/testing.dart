import 'package:flutter/material.dart';

class TestingPagination extends StatefulWidget {
  const TestingPagination({super.key});

  @override
  State<TestingPagination> createState() => _TestingPaginationState();
}

class _TestingPaginationState extends State<TestingPagination> {
  final ScrollController scrollController = ScrollController();
  bool loading = false;
  int _start = 0;
  final int _limit = 5;
  bool _isDarkMode = false; // Store the current theme (light or dark mode)

  // Initial list of image URLs
  List<String> allImages = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLat8bZvhXD3ChSXyzGsFVh6qgplm1KhYPKA&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9EZNefY1fRsA4qVFTBviWyj-5KHY6U8LG0g&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUsbmTZu_uMrmJ0z--CrG-o1UIXytu1OCizQ&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9SRRmhH4X5N2e4QalcoxVbzYsD44C-sQv-w&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMyFtuoRqx2E-IHO9Kcb4xe3wV_U5y40Pq8g&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMyFtuoRqx2E-IHO9Kcb4xe3wV_U5y40Pq8g&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQ1ipeQbFseUM_GzxwMoQj45w9HtAnu4eu5w&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-K2Qe5N26HdG0jQWBEHxZYETyuxdBDUfhzA&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwsAn_T3aA0ZWjVoysDInUL7Aj0n3TZUamsQ&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLat8bZvhXD3ChSXyzGsFVh6qgplm1KhYPKA&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3qJBsnDGDzZykBOGUo5oZ8ZfaqunMmvkXtA&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLat8bZvhXD3ChSXyzGsFVh6qgplm1KhYPKA&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9EZNefY1fRsA4qVFTBviWyj-5KHY6U8LG0g&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUsbmTZu_uMrmJ0z--CrG-o1UIXytu1OCizQ&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMyFtuoRqx2E-IHO9Kcb4xe3wV_U5y40Pq8g&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLat8bZvhXD3ChSXyzGsFVh6qgplm1KhYPKA&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLat8bZvhXD3ChSXyzGsFVh6qgplm1KhYPKA&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-K2Qe5N26HdG0jQWBEHxZYETyuxdBDUfhzA&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLat8bZvhXD3ChSXyzGsFVh6qgplm1KhYPKA&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQ1ipeQbFseUM_GzxwMoQj45w9HtAnu4eu5w&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-K2Qe5N26HdG0jQWBEHxZYETyuxdBDUfhzA&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwsAn_T3aA0ZWjVoysDInUL7Aj0n3TZUamsQ&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLat8bZvhXD3ChSXyzGsFVh6qgplm1KhYPKA&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLat8bZvhXD3ChSXyzGsFVh6qgplm1KhYPKA&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoBuMvSuYezLE9rwI-zOJeIOmcIGfDPqOvFA&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLat8bZvhXD3ChSXyzGsFVh6qgplm1KhYPKA&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQP4SPm_7JYOz4firDmPHDZGrUxVqcumPWtdQ&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPApju79vwfgIlVEZj-8lItXYlv5Xszc3nBA&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRq3PfYQvVEr4_qQN-m-lAe_K7O6oygZ9-Eg&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRq3PfYQvVEr4_qQN-m-lAe_K7O6oygZ9-Eg&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLat8bZvhXD3ChSXyzGsFVh6qgplm1KhYPKA&s',
  ];

  List<String> images = [];

  @override
  void initState() {
    super.initState();
    _loadImages();

    // Listener for infinite scroll
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !loading) {
        _loadImages();
      }
    });
  }

  // Simulate a network request and load more images
  void _loadImages() {
    if (loading) return;
    setState(() {
      loading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        // Load a subset of images and check if all images are loaded
        final newImages = allImages.sublist(
          _start,
          _start + _limit > allImages.length
              ? allImages.length
              : _start + _limit,
        );
        images.addAll(newImages);
        _start += newImages.length;

        // Check if we have loaded all images
        if (_start >= allImages.length) {
          loading = false;
        } else {
          loading = false;
        }
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable the debug banner
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pagination With Media'),
          backgroundColor: _isDarkMode ? Colors.black : Colors.blue,
          actionsIconTheme: IconThemeData(
            color: _isDarkMode ? Colors.white : Colors.black, // Icon color
          ),
          actions: [
            Switch(
              value: _isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  _isDarkMode = value; // Toggle dark mode
                });
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount:
                      images.length +
                      (loading ? 1 : 0), // Add 1 for loading indicator
                  itemBuilder: (context, index) {
                    if (index == images.length) {
                      // Display a loading spinner when more images are being loaded
                      return Center(child: CircularProgressIndicator());
                    }

                    if (index == images.length - 1 &&
                        _start >= allImages.length) {
                      // Display a "No more media" message at the end of the list
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'No more media available',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    }

                    return Container(
                      margin: const EdgeInsets.all(10),
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: NetworkImage(images[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
