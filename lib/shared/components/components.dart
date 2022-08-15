import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

Widget articleSeparator() => Container(
      height: 1.0,
      color: Colors.grey,
    );

Widget articleItemBuilder({required article,
 required context}) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: NetworkImage(article['urlToImage']),
                    fit: BoxFit.cover)),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${article['title']}',
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${article['publishedAt']}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey[600],

                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

Widget articleListBuilder({required articleList,
  required context}) => ConditionalBuilder(
      condition: articleList.isNotEmpty,
      builder: (context) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            if (articleList[index]['urlToImage'] == null) {
              articleList[index]['urlToImage'] =
                  'https://unsplash.com/a/img/empty-states/photos.png';
            }
            return articleItemBuilder(article: {
              'urlToImage': articleList[index]['urlToImage'],
              'title': articleList[index]['title'],
              'publishedAt': articleList[index]['publishedAt'],
            },context: context
            );
          },
          separatorBuilder: (context, index) => articleSeparator(),
          itemCount: articleList.length),
      fallback: (context) => const Center(child: CircularProgressIndicator()),
    );
