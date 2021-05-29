class Queries {
  static const String customer = '''
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

class Mutations {
  static String purchase(String offerId) => '''
    mutation purchase {
      purchase(offerId: "$offerId") {
        success
        errorMessage
        customer {
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
