Uri makeApiVenda(String path) => 
  Uri.parse('https://micros-servicos-sales-api.herokuapp.com/api/$path');
Uri makeApiLogin(String path) => 
  Uri.parse('https://micros-servicos-auth-api.herokuapp.com/api/user/$path');
Uri makeApiProduct(String path) => 
  Uri.parse('https://micros-servicos-product-api.herokuapp.com/api/product/$path');
