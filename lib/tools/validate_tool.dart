
bool ValidarURL(String url){
  String patternURL = r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
  RegExp regExp = RegExp(patternURL);
  bool isURL = regExp.hasMatch(url);
  print(isURL.toString());
  return isURL;
}