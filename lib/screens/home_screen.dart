import 'package:flutter/material.dart';
import 'package:graphql_ecom/main.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GraphQL Ecom'),
      ),

      body: Query(
        options: QueryOptions(
          document: gql(productGraphQL)
        ), 
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            return  Text(
              result.exception.toString()
            );
          }

          if(result.isLoading) {
            return Center(
              child: CircularProgressIndicator()
            );
          }


          final productList = result.data?['products']['edges'];
          print('###### $productList');

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('My products'),
              ),

              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0,
                    childAspectRatio: 3.1/4
                  ), 
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    var product = productList[index]['node'];
                    return Card(
                      elevation: 3,
                      child: Column(
                        children: [
                          Container(
                            child: Image.network(
                              product['thumbnail']['url'],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              product['name']
                            ),
                          )
                        ],
                      ),
                    );
                  } ,
                ),
              )

            ],
          );
        }
      )
    );
  }
}