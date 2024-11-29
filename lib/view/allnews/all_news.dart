import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/controller/news.dart';
import 'package:news_app/controller/slider_data.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/slider_model.dart';
import 'package:news_app/view/articleview/article_view.dart';
import 'package:shimmer/shimmer.dart';

class AllNews extends StatefulWidget {
  String news;
  AllNews({required this.news});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<SliderModel> sliders = [];
  List<ArticleModel> articles = [];
  bool _loading = true;
  void initState() {
    getSlider();
    getNews();
    super.initState();
    setState(() {});
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    setState(() {
      articles = newsClass.news;
      _loading = false;
    });
  }

  getSlider() async {
    SliderData slider = SliderData();
    await slider.getSlider();
    sliders = slider.sliders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.news + " News",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? _buildShimmerEffect()
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: widget.news == "Breaking"
                    ? sliders.length
                    : articles.length,
                itemBuilder: (context, index) {
                  return AllNewsSection(
                    image: widget.news == "Breaking"
                        ? sliders[index].urlToImage!
                        : articles[index].urlToImage!,
                    desc: widget.news == "Breaking"
                        ? sliders[index].description!
                        : articles[index].description!,
                    title: widget.news == "Breaking"
                        ? sliders[index].title!
                        : articles[index].title!,
                    url: widget.news == "Breaking"
                        ? sliders[index].url!
                        : articles[index].url!,
                  );
                },
              ),
            ),
    );
  }

  Widget _buildShimmerEffect() {
    return ListView.builder(
      itemCount: 5, // Number of shimmer items
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                ),
                SizedBox(height: 5),
                Container(
                  height: 20,
                  width: MediaQuery.of(context).size.width * 0.7,
                  color: Colors.white,
                ),
                SizedBox(height: 5),
                Container(
                  height: 15,
                  width: MediaQuery.of(context).size.width * 0.5,
                  color: Colors.white,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AllNewsSection extends StatelessWidget {
  String image, desc, title, url;
  AllNewsSection(
      {required this.image,
      required this.desc,
      required this.title,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleView(blogUrl: url),
            ));
      },
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: image,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              title,
              maxLines: 2,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              desc,
              maxLines: 3,
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
