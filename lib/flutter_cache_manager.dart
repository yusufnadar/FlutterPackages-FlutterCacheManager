import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class FlutterCacheManagerPage extends StatefulWidget {
  const FlutterCacheManagerPage({Key? key}) : super(key: key);

  @override
  State<FlutterCacheManagerPage> createState() => _FlutterCacheManagerPageState();
}

class _FlutterCacheManagerPageState extends State<FlutterCacheManagerPage> {

  @override
  void dispose() {
    DefaultCacheManager().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Cache Manager'),
        actions: [
          TextButton(onPressed: (){
            cacheManager();
          }, child: const Text('Cache Manager',style: TextStyle(color: Colors.white),))
        ],
      ),
      body: Center(
        child: CachedNetworkImage(
          cacheManager: CacheManager(
              Config(
                  'flutter_packages',
                  stalePeriod: const Duration(hours: 2),
                  maxNrOfCacheObjects: 10,
                  repo: JsonCacheInfoRepository(databaseName: 'new_photos')
              )
          ),
          key: UniqueKey(),
          imageUrl: 'https://mymodernmet.com/wp/wp-content/uploads/2019/07/will-burrard-lucas-beetlecam-23-1024x683.jpg',
          imageBuilder: (context,imageProvider) => CircleAvatar(backgroundImage: imageProvider,radius: 100,),
          errorWidget: (context,url,errorMessage)=>Icon(Icons.error),
          //placeholder: (context,url)=>CircularProgressIndicator(),
          progressIndicatorBuilder: (context,url,progress)=>CircularProgressIndicator(value: progress.progress,),
          fit: BoxFit.contain,
          fadeInCurve: Curves.bounceOut,
          fadeInDuration: Duration(seconds: 5),
        ),
      ),
    );
  }

  void cacheManager() async{
    //DefaultCacheManager().emptyCache();
    //DefaultCacheManager().downloadFile('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYAHZ0lpBtlP8lXebTIEtnA5-gDxLrPaL-CA&usqp=CAU');
    var photo =  DefaultCacheManager().getImageFile('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYAHZ0lpBtlP8lXebTIEtnA5-gDxLrPaL-CA&usqp=CAU');
  }
}

