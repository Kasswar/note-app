import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';


String _basicAuth = 'Basic ' +
    base64Encode(utf8.encode(
        'kasswar:kasswar12345'));

Map<String, String> myheaders = {
  'authorization': _basicAuth
};



class Crud{
  getRequest(String url)async{
    try{
      var response=await http.get(Uri.parse(url));
      if(response.statusCode==200){
        var responseBody=jsonDecode(response.body);
        return responseBody;
      }else{
        print("error ${response.statusCode}");
      }
    }catch(e){
      print("error catch $e");
    }
  }
  postRequest(String url,Map<String,dynamic> data)async{
    try{
      var response=await http.post(Uri.parse(url),body: data,headers: myheaders);
      if(response.statusCode==200){
        var responseBody=jsonDecode(response.body);
        print("============================================");
        print("$responseBody");
        return responseBody;
      }else{
        print("error ${response.statusCode}");
      }
    }catch(e){
      print("error catch $e");
    }
  }

  postRequestWithFile(String url,Map<String,dynamic> data,File file)async{
    var request= http.MultipartRequest('POST',Uri.parse(url));
    var stream =http.ByteStream(file.openRead());
    var length =await file.length();
    var multiPartFile=http.MultipartFile("image",stream,length,filename: basename(file.path));
    request.headers.addAll(myheaders);
    request.files.add(multiPartFile);
    data.forEach((key, value) {
      request.fields[key]=value;
    });
    var myRequest=await request.send();
    var response=await http.Response.fromStream(myRequest);
    if(response.statusCode==200){
      String dataResponse=response.body.toString();
      return jsonDecode(dataResponse);
    }else{
      print("ERROR ${response.statusCode}");
    }
  }
}