class MarketplaceQueries {
  static const String customers = '''
    query customer {
    viewer {
      ... on Customer {
        id
        name
        balance
        offers {
          id
          price
          product {
            id
            name
            description
            image
          }
        }
      }
    }
  }
  ''';
}
