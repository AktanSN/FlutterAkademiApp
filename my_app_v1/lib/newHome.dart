import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:my_app_v1/styles.dart';
import 'package:my_app_v1/widgets.dart';

class NewHomePage extends StatelessWidget {
  NewHomePage({super.key});

  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade400,
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade400,
        title: const Text('Uygulama Adı'),
        elevation: 0,
        centerTitle: true,
      ),
      drawer: ChatWidgets.drawer(context),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10),
            margin: EdgeInsets.all(0),
            child: Container(
              color: Colors.indigo.shade400,
              padding: const EdgeInsets.all(8),
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 10),
                    child: Text(
                      'Son Aktif Kullanıcılar',
                      style: Styles.h1(),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, i) {
                        return ChatWidgets.circleProfile(
                          onTap: () {},
                          name: 'Kullanıcı',
                          number: i,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: Styles.friendsBox(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Text(
                      'Ekip',
                      style: Styles.h1().copyWith(color: Colors.indigo),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, i) {
                          return Card(
                            elevation: 8,
                            color: Colors.white,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.indigo.shade400,
                                child: Text('A'),
                              ),
                              title: Text('Kullanıcı'),
                              subtitle: Text('Çevrimiçi'),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.message),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ); /**/
  }
}
