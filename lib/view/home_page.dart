import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/api.dart';
import 'package:flutter_sample/provider/auth_provider.dart';
import 'package:flutter_sample/provider/crud_provider.dart';
import 'package:flutter_sample/provider/login_provider.dart';
import 'package:flutter_sample/view/create_page.dart';
import 'package:flutter_sample/view/customize_page.dart';
import 'package:flutter_sample/view/detail_page.dart';
import 'package:get/get.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final userData = ref.watch(userProvider);
    final isLoad = ref.watch(loadingProvider);
    final productData = ref.watch(productProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Sample Shop'),
      ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(

                  child: Text(userData[0].email)),
              ListTile(
                leading: Icon(Icons.person),
                title: Text(userData[0].username),
              ),

              ListTile(
                onTap: (){
                  Navigator.of(context).pop();
                 Get.to(() => CreatePage(), transition: Transition.leftToRight);
                },
                leading: Icon(Icons.add),
                title: Text('product create'),
              ),

              ListTile(
                onTap: (){
                  Navigator.of(context).pop();
                  Get.to(() => CustomizePage(), transition: Transition.leftToRight);
                },
                leading: Icon(Icons.settings_rounded),
                title: Text('customize product'),
              ),


              ListTile(
                onTap: (){
                   if(isLoad == true){
                     ref.read(loadingProvider.notifier).toggle();
                   }
                  ref.read(userProvider.notifier).clearBox();
                },
                leading: Icon(Icons.exit_to_app),
                title: Text('LogOut'),
              ),

            ],
          ),
        ),
        body: productData.when(
            data: (data){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 2/2
                    ),
                    itemBuilder:(context, index){
                     return  InkWell(
                       onTap: (){
                         Get.to(() => DetailPage(data[index]), transition: Transition.zoom);
                       },
                       child: GridTile(
                         child: ClipRRect(
                             borderRadius: BorderRadius.circular(10),
                             child: Hero(
                                 tag: data[index].imagePath,
                                 child: Image.network('${Api.baseUrl}/${data[index].imagePath}', fit: BoxFit.cover,)),
                         ) ,
                         footer: GridTileBar(
                           backgroundColor: Colors.black87,
                           leading: Text(data[index].product_name, style: TextStyle(color: Colors.white),),
                           trailing: Container(
                               margin: EdgeInsets.only(left: 40),
                               child: Text('Rs. ${data[index].price}', style: TextStyle(color: Colors.white),)),
                         ),
                       ),
                     );
                    }
                ),
              );
            },
            error: (err, stack) => Center(child: Text('$err')),
            loading: () => Center(child: CircularProgressIndicator(
              color: Colors.purple,
            ),)
        )
    );
  }
}
