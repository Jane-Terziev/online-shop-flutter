import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:online_shop/services/base_api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:convert';

class ProductForm extends StatefulWidget {
  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();

  String _title;
  String _description;
  double _price;
  int _instock;
  String _category;
  File _image;
  List categories = [
    'Accessories',
    'Toys',
    'Electronics',
    'Clothes',
    'Educational',
  ];

  Future<http.Response> createProduct(context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var stream =
    new http.ByteStream(DelegatingStream.typed(_image.openRead()));
    // get file length
    var length = await _image.length(); //imageFile is your image file
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer " + sp.getString("token")
    }; // ignore this headers if there is no authentication

    // string to uri
    var uri = Uri.parse(BaseApiClient.CREATE_PRODUCT_URL);

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFileSign = new http.MultipartFile('image', stream, length,
        filename: basename(_image.path));

    // add file to multipart
    request.files.add(multipartFileSign);

    //add headers
    request.headers.addAll(headers);

    //adding params
    request.fields['title'] = _title;
    request.fields['description'] = _description;
    request.fields['price'] = "123.321";
    request.fields['category_id'] = "7";

    // send
    var response = await request.send();

    if(response.statusCode == 200){
      _showToastSuccess(context);
      _formKey.currentState.reset();
      setState(() {
        _image = null;
      });
    }

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Form(
          key: _formKey,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: _image != null ? Image.file(
                    _image,
                    width: 200,
                    height: 200,
                    fit: BoxFit.fitHeight,
                  ) : Image.asset(
                    "assets/images/broken_image.png",
                    width: 200,
                    height: 200,
                  ),
                ),
                Center(
                  child: OutlineButton(
                    onPressed: (){
                      _showPicker(context);
                    },
                    child: Text('Choose Image'),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a product name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Product name',
                  ),
                  onSaved: (String value) {
                    _title = value;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  validator: (value) {
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Product Description',
                  ),
                  onSaved: (String value) {
                    _description = value;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                  validator: (value) {
                    if (value.isEmpty || double.parse(value) <= 0) {
                      return 'Please enter a price bigger than 0';
                    }
                    return null;
                  },
                  onSaved: (String value){
                    _price = double.parse(value);
                  },
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    onPressed: () {
                      if(!_formKey.currentState.validate()){
                        return;
                      }
                      if(_image == null){
                        _showToastError(context);
                        return;
                      }
                      _formKey.currentState.save();
                      createProduct(context);
                    },
                    child: const Text('Add Product', style: TextStyle(fontSize: 20)),
                    color: Colors.blue,
                    textColor: Colors.white,
                    elevation: 5,
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
void _showToastError(BuildContext context) {
  final scaffold = Scaffold.of(context);
  scaffold.showSnackBar(
    SnackBar(
      backgroundColor: Colors.redAccent,
      content: const Text('Please choose an image.', style: TextStyle(color: Colors.white)),
      action: SnackBarAction(
          label: 'Hide', onPressed: scaffold.hideCurrentSnackBar, textColor: Colors.white,),
    ),
  );
}

void _showToastSuccess(BuildContext context) {
  final scaffold = Scaffold.of(context);
  scaffold.showSnackBar(
    SnackBar(
      backgroundColor: Colors.green,
      content: const Text('Product created successfully', style: TextStyle(color: Colors.white)),
      action: SnackBarAction(
        label: 'Hide', onPressed: scaffold.hideCurrentSnackBar, textColor: Colors.white,),
    ),
  );
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, // unused.
      TextEditingValue newValue,
      ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}