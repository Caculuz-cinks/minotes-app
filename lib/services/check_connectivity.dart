import 'package:connectivity/connectivity.dart';

//check if device has internet access
Future<bool> isConnected()async{
  var internetAccess = await (Connectivity().checkConnectivity());
  if(internetAccess == ConnectivityResult.mobile || internetAccess == ConnectivityResult.wifi) return true;
  else return false;
}