import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

var months = [
  '1 month',
  '2 month',
  '3 month',
  '4 month',
  '5 month',
  '6 month',
  '7 month',
  '8 month',
  '9 month',
  '10 month',
  '11 month',
];
var years = [
  '2000',
  '2001',
  '2002',
  '2003',
  '2004',
  '2005',
  '2006',
  '2007',
  '2008',
  '2009',
  '2010',
  '2011',
];

const attachDocImg = AssetImage(Employer_Icon_AttachDocument);
const pdfimg = AssetImage(Employer_Icon_PdfImage);
const viewicon = AssetImage(Employer_Icon_ViewBlue);
const deleteicon = AssetImage(Employer_Icon_DeleteBlue);

class Employer_WorkPlace_UploadAttendance extends StatefulWidget {
  final String? title;
  const Employer_WorkPlace_UploadAttendance({super.key, this.title});

  @override
  State<Employer_WorkPlace_UploadAttendance> createState() => _Employer_WorkPlace_UploadAttendance();
}

class _Employer_WorkPlace_UploadAttendance extends State<Employer_WorkPlace_UploadAttendance> {
  String? heading;
  String? filename;

  @override
  void initState() {
    super.initState();

    heading = widget.title;
  }

  void _pickFile() async {
    // opens storage to pick files and the picked file or files
    // are assigned into result and if no file is chosen result is null.
    // you can also toggle "allowMultiple" true or false depending on your need
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    // if no file is picked
    if (result == null) return;

    // we will log the name, size and path of the
    // first picked file (if multiple are selected)
    print(result.files.first.name);
    print(result.files.first.size);
    print(result.files.first.path);

    setState(() {
      filename = result.files.first.name;
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return SafeArea(
        child: Scaffold(
          backgroundColor: whiteColor,
          appBar:CJAppBar(getEmployer_UploadAttendance, appBarBlock: AppBarBlock(appBarAction: ()
          {
            print("show the action type");
            Navigator.pop(context);
          })),
          body:getResponsiveUI(),
        ));
  }

  Responsive getResponsiveUI()
  {
    return Responsive(
      mobile: MainfunctionUi(),
      tablet: Center(
        child: Container(
          width: webResponsive_TD_Width,
          child: MainfunctionUi(),
        ),
      ),
      desktop: Center(
        child: Container(
          width: webResponsive_TD_Width,
          child: MainfunctionUi(),
        ),
      ),
    );
  }
  Padding MainfunctionUi()
  {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              heading!,
              // "hello",
              style: TextStyle(
                color: darkBlueColor,
                fontFamily: robotoFontFamily,
                fontSize: viewHeadingFontweight,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: upperIncators("Deployment", "500", Colors.blue),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child:
                upperIncators("Attendence Recieved", "500", Colors.green),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: inputFieldDropdown("Current year", years),
              ),
              SizedBox(
                width: 30,
              ),
              Expanded(
                child: inputFieldDropdown("Current Month", months),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          // inputFieldDropdown("choose File", [])
          attachDoc(),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "You can upload multiple documents as a pdf or jpeg Upto imb",
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.red,fontSize: small_FontSize,fontFamily: robotoFontFamily),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: Text(
              "Document Uploaded Successfully!",
              style: TextStyle(
                fontSize: large_FontSize,
                fontFamily: robotoFontFamily,
              ),
              textAlign: TextAlign.center,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                "You will be notified once documents will be verified by the CJ Care Team",
                style: TextStyle(
                  fontSize: small_FontSize,
                  fontFamily: robotoFontFamily,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: Image(
                      image: pdfimg,
                      height: 50,
                    ),
                    title: Text("Name of the Document"),
                    subtitle: Text("January, 2022"),
                    trailing: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        ImageIcon(
                          viewicon,
                          color: darkBlueColor,
                        ),
                        ImageIcon(
                          deleteicon,
                          color: darkBlueColor,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: Image(
                      image: pdfimg,
                      height: 50,
                    ),
                    title: Text("Name of the Document"),
                    subtitle: Text("January, 2022"),
                    trailing: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        ImageIcon(
                          viewicon,
                          color: darkBlueColor,
                        ),
                        ImageIcon(
                          deleteicon,
                          color: darkBlueColor,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: Image(
                      image: pdfimg,
                      height: 50,
                    ),
                    title: Text("Name of the Document"),
                    subtitle: Text("January, 2022"),
                    trailing: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        ImageIcon(
                          viewicon,
                          color: darkBlueColor,
                        ),
                        ImageIcon(
                          deleteicon,
                          color: darkBlueColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container attachDoc() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: lightGreyColor,
          borderRadius: BorderRadius.circular(10.0)),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        initialValue: filename != null ? filename : "Attach Document",
        decoration: InputDecoration(
          suffixIcon: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                elevation: 0,
                backgroundColor: lightGreyColor),
            onPressed: () {
              _pickFile();
            },
            child: Image(
              image: attachDocImg,
            ),
          ),
          hintText: filename != null ? filename : "Attach Documents",
          hintStyle: TextStyle(
              color: textFieldHintTextColor,
              fontSize: medium_FontSize),
          enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        ),
      ),
    );
  }

  Container inputFieldDropdown(String title, List<String> Lts) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: lightGreyColor,
          borderRadius: BorderRadius.circular(10.0)),
      child: DropdownButtonFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select any value';
          }
          return null;
        },
        icon: Icon(Icons.keyboard_arrow_down_outlined),
        isExpanded: true,
        menuMaxHeight: 200,
        hint: Text(
          title,
          style: TextStyle(
            color: textFieldHintTextColor,
            fontSize: medium_FontSize,
          ),
        ),
        items: Lts.map((String items) {
          return DropdownMenuItem(child: Text(items), value: items);
        }).toList(),
        onChanged: (context) {},
        decoration: InputDecoration(
          enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        ),
      ),
    );
  }

  Wrap upperIncators(String title, String val, Color col) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Expanded(child:  Text(
          title,
          style: TextStyle(
            fontWeight: bold_FontWeight,
            fontFamily: robotoFontFamily,
            fontSize: medium_FontSize,
          ),
        ))
       ,
        SizedBox(
          width: 5,
        ),
        Expanded(child: Container(
          // width: 30,
          // height: 17,
          decoration: BoxDecoration(
              color: col,
              border: Border.all(
                color: col,
                width: 3.0,
              ),
              borderRadius: BorderRadius.circular(5)),
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
          // color: Colors.blue,
          child: Center(
              child: Text(
                val,
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
        ),)

      ],
    );
  }
}
