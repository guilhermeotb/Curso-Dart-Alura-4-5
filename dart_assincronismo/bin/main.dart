import 'package:http/http.dart';
void main(){
  resquestData();
}

resquestData(){
  String url = "https://gist.githubusercontent.com/guilhermeotb/b5e5988083befbf76bfc7e34c6f518d1/raw/8eb9c4615a551aa5f6eb119cec1a93c781759f5e/accounts.json";
 print( get(Uri.parse(url)));
}