import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:news_app/modules/web_view/web_view.dart';

Widget sectionSeparator() => Container(
      height: 1.0,
      color: Colors.grey,
    );

// Widget articleItemBuilder({required article, required context}) => InkWell(
//       onTap: () {
//         navigateTo(context, webViewScreen(article['url']));
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
//         child: Row(
//           children: [
//             Container(
//               height: 120,
//               width: 120,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   image: DecorationImage(
//                       image: NetworkImage(article['urlToImage']),
//                       fit: BoxFit.cover)),
//             ),
//             const SizedBox(width: 10.0),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     '${article['title']}',
//                     style: Theme.of(context).textTheme.bodyText1,
//                     maxLines: 3,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         '${article['publishedAt']}',
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                       SizedBox(width: 40.0,),
//                       Text(
//                         '${article['author']}',
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           color: Colors.red[600],
//                         ),
//                       ),
//                       SizedBox(width: 20.0,),
//                       IconButton(onPressed: () {}, icon: Icon(Icons.bookmark_border_rounded))
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
Widget articleItemBuilder({required article, required context}) => InkWell(
      onTap: () {
        navigateTo(context, webViewScreen(article['url'], article['author']));
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.5,
                  blurRadius: 1,
                  offset: const Offset(0, 1.5), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    // Container(width: double.maxFinite,
                    //   height: 250,
                    //   decoration: BoxDecoration(
                    //     image:DecorationImage( fit:BoxFit.cover,image: NetworkImage(article['urlToImage'])),
                    //   ),
                    // ),
                    FadeInImage(
                        fit: BoxFit.cover,
                        width: double.maxFinite,
                        placeholder: const AssetImage(
                            'lib/shared/assets/images/placeholder2.png'),
                        image: article['urlToImage'] != null
                            ? NetworkImage(article['urlToImage'])
                            : const AssetImage(
                                    'lib/shared/assets/images/placeholder2.png')
                                as ImageProvider),
                    Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              end: Alignment.topCenter,
                              begin: Alignment.bottomCenter,
                              colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0)
                          ])),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          '${article['title']}',
                          style: Theme.of(context).textTheme.bodyText1,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Text(
                        '${article['publishedAt']}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(
                        width: 40.0,
                      ),
                      Text(
                        '${article['author']}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.red[600],
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.bookmark_border_rounded),
                        iconSize: 30.0,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );

Widget articleListBuilder(articleList, context, {isSearch = false}) =>
    ConditionalBuilder(
      condition: articleList.isNotEmpty,
      builder: (context) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            var date = articleList[index]['publishedAt'];
            var duration = DateTime.now().difference(DateTime.parse(date));
            if (duration.inSeconds < 60) {
              date = '${duration.inSeconds}S';
            } else if (duration.inSeconds < 3600) {
              date = '${duration.inMinutes}M';
            } else if (duration.inSeconds < 86400) {
              date = '${duration.inHours}H';
            } else {
              date = '${duration.inDays}D';
            }
            return articleItemBuilder(article: {
              'urlToImage': articleList[index]['urlToImage'],
              'title': articleList[index]['title'],
              'publishedAt': date,
              'url': articleList[index]['url'],
              'author': articleList[index]['source']['name'],
            }, context: context);
          },
          separatorBuilder: (context, index) => SizedBox(),
          itemCount: articleList.length),
      fallback: (context) => isSearch
          ? Container()
          : const Center(child: CircularProgressIndicator()),
    );
void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
