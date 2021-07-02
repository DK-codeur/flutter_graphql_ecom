import 'package:flutter/material.dart';
import 'package:graphql_ecom/screens/home_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const productGraphQL = """ 
  query products {
    products(first: 10, channel: "default-channel") {
      edges {
        node {
          id
          name
          description
          thumbnail {
            url
          }
        }
      }
		}
  }
""";

void main() {

	final HttpLink httpLink = HttpLink("https://demo.saleor.io/graphql/");

	ValueNotifier<GraphQLClient> client = ValueNotifier(
			GraphQLClient(
			link: httpLink,
			cache: GraphQLCache(
				store: InMemoryStore()
			)
		)
	);

	var app = GraphQLProvider(
		client: client,
		child: MyApp(),
	);

  runApp(app);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GraphQL Ecom',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen()
    );
  }
}


