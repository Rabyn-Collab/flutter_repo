import 'package:flutter/material.dart';
import 'package:flutter_sample/api.dart';
import 'package:flutter_sample/models/products.dart';




class DetailPage extends StatelessWidget {
 final Product product;
 DetailPage(this.product);
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final containerHeight = h - h*0.35;
    return Scaffold(
      backgroundColor: Colors.purple,
        body: SafeArea(
          child: Container(
            child: Stack(
              children: [
                Container(
                   height:  containerHeight,
                  margin: EdgeInsets.only(top: h * 0.35),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(45),
                      topLeft: Radius.circular(45)
                    )
                  ),
                  child: LayoutBuilder(
                    builder: (context, constrained) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(top: constrained.maxHeight * 0.15),
                                  child: Text(product.product_detail)),
                            ),
                            ElevatedButton(
                                onPressed: () {

                                }, child: Text('Add To Cart')),
                            SizedBox(height: 10,)
                          ],
                        ),
                      );
                    }
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, top: 10),
                  height:  h * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.product_name, style: TextStyle(fontSize: 20, color: Colors.white),),
                      Container(
                        margin: EdgeInsets.only(top: 95),
                        child: Row(
                          children: [
                            Text('Rs. ${product.price}', style: TextStyle(color: Colors.white),),
                            SizedBox(width:15 ,),
                            Expanded( child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Hero(
                                    tag: product.imagePath,
                                    child: Image.network('${Api.baseUrl}/${product.imagePath}',))))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
