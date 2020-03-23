import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';


class CategoryBoxes extends StatelessWidget {
  String _imageurl;
  final _json_url;
  var _json;

  CategoryBoxes(this._json_url, {String imageurl}) {
    _imageurl = imageurl;
    http.get(_json_url).then((response) {
      _json = jsonDecode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.indigo,
        appBar: new AppBar(
          leading: new IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Menu',
            onPressed: () {
            },
          ),
          title: new Text("Категории"),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
            new IconButton(
              icon: new Icon(Icons.monetization_on),
              onPressed: () {},
            )
          ],
        ),
        body: new ListView.builder(itemCount: _json == null ? 0 : _json.length,
            itemBuilder: (context, i) {
              return new Container(
                  color: Colors.black12,
                  height: 100.0,
                  child: new Row(children: [
                    new Image.network(
                      _imageurl, width: 100.0, height: 100.0, fit:
                    BoxFit.cover),
                    new Expanded(child: new Container(padding: new
                      EdgeInsets.all(5.0), child: new Column(
                        children: [
                          new Text(
                              _json[i]['id'].toString(), style: new TextStyle(
                              fontSize: 20.0),
                              overflow: TextOverflow.ellipsis,
                          ),
                          new Expanded(child: new Text(
                            utf8.decode(_json[i]['name'].toString().codeUnits), softWrap: true,
                            textAlign:
                            TextAlign.justify,)),
                         ]
                    )))
                  ])
              );
            })
    );
  }
}
void main() {
  runApp(
      new MaterialApp(
          debugShowCheckedModeBanner: false,
          home: new CategoryBoxes('http://server.getoutfit.ru/categories', imageurl : 'https://cs.pikabu.ru/post_img/big/2013/07/24/1/1374615707_1216066370.jpg')
          )
      );
}