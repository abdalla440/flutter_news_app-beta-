import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:news_app/modules/web_view/web_view.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/shared/cubit/app_cubit.dart';

enum Options { readLater, favorites }

Widget sectionSeparator() => Container(
      height: 0.5,
      color: Colors.grey.shade700,
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
Widget maxArticleItemBuilder({required article, required context}) => InkWell(
      onTap: () {
        navigateTo(context, webViewScreen(article['url'], article['author']));
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Card(
            color:
                Theme.of(context).scaffoldBackgroundColor == HexColor('121212')
                    ? Colors.white.withOpacity(0.05)
                    : Colors.white,
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
                        height: 250.0,
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
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
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
                          color: Colors.grey[700],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: Container(
                          width: 1,
                          height: 18,
                          color: Colors.grey.shade600,
                          child: const Text(''),
                        ),
                      ),
                      Text(
                        '${article['author']}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.red[600],
                        ),
                      ),
                      const Spacer(),
                      PopupMenuButton(
                        icon: const Icon(Icons.more_vert_rounded),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            onTap: () async {
                              article['urlToImage'] != null
                                  ? article['urlToImage']
                                  : article['urlToImage'] =
                              'https://media.istockphoto.com/vectors/default-image-icon-vector-missing-picture-page-for-website-design-or-vector-id1357365823?k=20&m=1357365823&s=612x612&w=0&h=ZH0MQpeUoSHM3G2AWzc8KkGYRg4uP_kuu0Za8GFxdFc=';
                              int response = await AppCubit.get(context)
                                  .insertToDatabase(
                                      query:
                                          'INSERT INTO articles (urlToImage, title, publishedAt, url, author, type) VALUES ("${article['urlToImage']}","${article['title']}","${article['publishedAt']}","${article['url']}","${article['author']}","read later" )');
                              print(response);
                            },
                            value: Options.readLater.index,
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.bookmark,
                                  color: Colors.red,
                                ),
                                Text('Read Later'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () async {
                              article['urlToImage'] != null
                                  ? article['urlToImage']
                                  : article['urlToImage'] =
                              'https://media.istockphoto.com/vectors/default-image-icon-vector-missing-picture-page-for-website-design-or-vector-id1357365823?k=20&m=1357365823&s=612x612&w=0&h=ZH0MQpeUoSHM3G2AWzc8KkGYRg4uP_kuu0Za8GFxdFc=';
                              int response = await AppCubit.get(context)
                                  .insertToDatabase(
                                  query:
                                  'INSERT INTO articles (urlToImage, title, publishedAt, url, author, type) VALUES ("${article['urlToImage']}","${article['title']}","${article['publishedAt']}","${article['url']}","${article['author']}","favorites" )');
                              print(response);
                            },
                            value: Options.favorites.index,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  color: Colors.yellow.shade800,
                                ),
                                Text('add to Favorites'),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );

PopupMenuItem _buildPopupMenuItem(
    String title, IconData iconData, int position, var color, onTap) {
  return PopupMenuItem(
    onTap: () {
      onTap;
    },
    value: position,
    child: Row(
      children: [
        Icon(
          iconData,
          color: color,
        ),
        Text(title),
      ],
    ),
  );
}

Widget minArticleItemBuilder({required article, required context}) => InkWell(
      onTap: () {
        navigateTo(context, webViewScreen(article['url'], article['author']));
      },
      child: Container(
        height: 120,
        child: Card(
            shape: const Border(
                right: BorderSide(
                    style: BorderStyle.solid, color: Colors.transparent)),
            color:
                Theme.of(context).scaffoldBackgroundColor == HexColor('121212')
                    ? Colors.white.withOpacity(0.05)
                    : Colors.white,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInImage(
                    fit: BoxFit.cover,
                    width: 120.0,
                    height: 130.0,
                    placeholder: const AssetImage(
                        'lib/shared/assets/images/placeholder2.png'),
                    image: article['urlToImage'] != null
                        ? NetworkImage(article['urlToImage'])
                        : const NetworkImage(
                                'https://media.istockphoto.com/vectors/default-image-icon-vector-missing-picture-page-for-website-design-or-vector-id1357365823?k=20&m=1357365823&s=612x612&w=0&h=ZH0MQpeUoSHM3G2AWzc8KkGYRg4uP_kuu0Za8GFxdFc=')
                            as ImageProvider),
                const SizedBox(
                  width: 10.0,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${article['title']}',
                          style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor ==
                                    HexColor('121212')
                                ? Colors.white
                                : Colors.black,
                            fontSize: 15.0,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              '${article['publishedAt']}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 12),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 7),
                              child: Container(
                                width: 1,
                                height: 18,
                                color: Colors.grey.shade600,
                                child: const Text(''),
                              ),
                            ),
                            Text(
                              '${article['author']}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.red[600], fontSize: 12),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  print(
                                      '[INFO] deleting .........................');
                                  AppCubit.get(context)
                                    ..deleteFromDatabase(id: article['id'], type: 'no clear');
                                },
                                icon: const Icon(
                                  Icons.delete_rounded,
                                  color: Colors.red,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );

Widget minArticleListBuilder(articleList, context, {isSearch = false}) =>
    ConditionalBuilder(
      condition: articleList.isNotEmpty,
      builder: (context) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            print('---------------------------------${articleList.length}');
            return minArticleItemBuilder(article: {
              'id': articleList[index]['id'],
              'urlToImage': articleList[index]['urlToImage'],
              'title': articleList[index]['title'],
              'publishedAt': articleList[index]['publishedAt'],
              'url': articleList[index]['url'],
              'author': articleList[index]['author'],
            }, context: context);
          },
          separatorBuilder: (context, index) => const SizedBox(),
          itemCount: articleList.length),
      fallback: (context) => isSearch
          ? Container()
          : const Center(child: Text('no articles to read now')),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

Widget maxArticleListBuilder(articleList, context, {isSearch = false}) =>
    ConditionalBuilder(
      condition: articleList.isNotEmpty,
      builder: (context) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            var date = articleList[index]['publishedAt'];
            var duration = DateTime.now().difference(DateTime.parse(date));
            if (duration.inSeconds < 60) {
              date = '${duration.inSeconds}s';
            } else if (duration.inSeconds < 3600) {
              date = '${duration.inMinutes}m';
            } else if (duration.inSeconds < 86400) {
              date = '${duration.inHours}h';
            } else {
              date = '${duration.inDays}d';
            }
            return maxArticleItemBuilder(article: {
              'urlToImage': articleList[index]['urlToImage'],
              'title': articleList[index]['title'],
              'publishedAt': date,
              'url': articleList[index]['url'],
              'author': articleList[index]['source']['name'],
            }, context: context);
          },
          separatorBuilder: (context, index) => const SizedBox(),
          itemCount: articleList.length),
      fallback: (context) => isSearch
          ? Container()
          : const Center(child: CircularProgressIndicator()),
    );
