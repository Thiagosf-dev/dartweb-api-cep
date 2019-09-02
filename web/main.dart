import 'dart:html';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  actionButton();
}

void actionButton() {
  querySelector('#search').onClick.listen((event) {
    event.preventDefault();
    getInput();
  });
}

void getInput() {
  String cep = (querySelector('#cep') as InputElement).value;
  getSearchAPI(cep);
}

void getSearchAPI(String cep) async {
  String url = 'http://viacep.com.br/ws/$cep/json/';
  var response = await http.get(url);
  decodeJsonToString(response);
}

void decodeJsonToString(response) async {
  var body = await json.decode(response.body);
  setInputs(body);
}

void setInputs(body) {
  if (body['erro'] == null) {
    clearInputs();
    (querySelector('#state') as InputElement).value = body['uf'];
    (querySelector('#city') as InputElement).value = body['localidade'];
    (querySelector('#region') as InputElement).value = body['bairro'];
    (querySelector('#street') as InputElement).value = body['logradouro'];
  } else {
    clearInputs();
    querySelector('#msgm').text = 'CEP inválido!';
  }
}

void clearInputs() {
  (querySelector('#state') as InputElement).value = '';
  (querySelector('#city') as InputElement).value = '';
  (querySelector('#region') as InputElement).value = '';
  (querySelector('#street') as InputElement).value = '';
  querySelector('#msgm').innerText = null;
}
