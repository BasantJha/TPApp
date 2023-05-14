import 'package:another_xlider/another_xlider.dart';
import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Constant/Responsive.dart';
import 'package:contractjobs/Controller/JobSeekers/Controller/JobSeekerDashboard/JobSeeker_FindWork/JobSeeker_FindWorkDetails.dart';
import 'package:contractjobs/Controller/JobSeekers/Controller/JobSeekerDashboard/JobSeeker_HomeView/JobSeeker_HomeChild.dart';
import 'package:contractjobs/Controller/Talents/TalentNavigation/TalentNavigation.dart';
import 'package:contractjobs/CustomView/AppBar/AppBarTitle.dart';
import 'package:contractjobs/CustomView/AppBar/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';


class JobSeeker_FindWork extends StatefulWidget {

  const JobSeeker_FindWork({Key? key}) : super(key: key);

  @override
  State<JobSeeker_FindWork> createState() => _JobSeeker_FindWork();
}


class _JobSeeker_FindWork extends State<JobSeeker_FindWork>
{
  var TRJOBS=jobSeekerTrendingCardListData;
  var viewFilter = ["latest", "Older"];

  var items2 = [
    'Finanace',
    'Human Resource',
    'IT',
    'Banking',
    'Civil',
  ];

  RangeValues _currentRangeValues = const RangeValues(10000, 50000);
  RangeValues _currentRangeValues2 = const RangeValues(2, 10);

  double _lowerValueSalary = 5;
  double _upperValueSalary = 12;

  double _lowerValueExp = 3;
  double _upperValueExp = 8;

  var jobRole = "";
  var subRole = "";
  var location = "";

  void handleJobrole(String value) {
    setState(() {
      jobRole = value;
    });
  }

  void handleSubrole(String value) {
    setState(() {
      subRole = value;
    });
  }

  void handleLocation(String value) {
    setState(() {
      location = value;
    });
  }


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CJAppBar(getJobSeeker_FindWorkTitle, appBarBlock: AppBarBlock(appBarAction: ()
      {
        print("show the action type");
        //Navigator.pop(context);

      })),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: getResponsiveUI(),
      ),
    );
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
  MainfunctionUi()
  {
    return Container(child:Column(
      children: [
        ListTile(
          tileColor: Color(0xffF5F5F5),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color(0xffE3E3E3), width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          leading: ImageIcon(AssetImage(search_Icon)),
          title: TextField(
            cursorColor: Colors.black,
            decoration: InputDecoration(
              hintText: "Search Job",
              border: InputBorder.none,
            ),
            style: TextStyle(color: Colors.black, fontSize: 18.0),
            onChanged: searchResult,
          ),
          trailing: IconButton(
            icon: ImageIcon(
              AssetImage(filter_Icon),
              color: darkBlueColor,
            ),
            onPressed: ()
            {
              showModalBottomSheet(
                  backgroundColor: whiteColor,
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context)
                  {
                    return showTheBottonPopUp();
                  });
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Showing ${TRJOBS.length} Jobs",
              style: TextStyle(
                fontFamily: robotoFontFamily,
                fontSize: small_FontSize,
                color: darkGreyColor,
              ),
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  "Latest",
                  style: TextStyle(
                      color: darkBlueColor,
                      fontFamily: robotoFontFamily),
                ),
                Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: darkBlueColor,
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
            child: ListView.builder(
              itemCount: TRJOBS.length,
              itemBuilder: (context, index)
              {
                var trendingObject = TRJOBS[index];

              return  GestureDetector(child:trendingJobCard(
                    trendingObject.companyName,
                    trendingObject.jobPostedDays,
                    trendingObject.jobType,
                    trendingObject.jobLocation,
                    trendingObject.salaryPackage,
                    trendingObject.workExperience,
                    trendingObject.schooling,
                    trendingObject.companyLogo,
                    trendingObject.colorCode) ,
                onTap: ()
                  {
                    print("show the selected object");

                    TalentNavigation().pushTo(context, JobSeeker_FindWorkDetails());

                  },);

              }
            )),
        SizedBox(
          height: 5,
        )
      ],
    ) ,);
  }

  SizedBox showTheBottonPopUp()
  {
    return SizedBox(
      height: 540,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: ImageIcon(
                AssetImage(filterClose_Icon),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            filterInput(jobSeekerTrendingCardListData.map((jobs) {
              return jobs.jobType;
            })
                .toSet()
                .toList(),
                "Choose Job Role",
                handleJobrole),
            SizedBox(
              height: 15,
            ),
            filterInput(
                items2,
                "Choose Sub Job Role /Skills",
                handleSubrole),
            SizedBox(
              height: 15,
            ),
            filterInput(
                jobSeekerTrendingCardListData
                    .map((loc) {
                  return loc.jobLocation.toString();
                })
                    .toSet()
                    .toList(),
                "Location",
                handleLocation),
            SizedBox(
              height: 15,
            ),
            filterSlider(_lowerValueSalary,
                _upperValueSalary, "Annual Salary", "lac"),
            SizedBox(
              height: 20,
            ),
            filterSlider(_lowerValueExp, _upperValueExp,
                "Experience", "years"),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: darkBlueColor,
                    minimumSize: Size(150, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(10),
                    )),
                onPressed: () {
                  print("Jobrole = $jobRole");
                  print("Subrole = $subRole");
                  print("location = $location");
                  filterResult();
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Apply Filter",
                  style: TextStyle(
                    fontFamily:
                    robotoFontFamily,
                    fontSize:
                    large_FontSize,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Column filterInput(List<String> items, String label, Function valChange)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 14,
            fontFamily: viewHeadingFontfamily,
          ),
        ),
        DropdownButtonFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select any value';
            }
            return null;
          },
          icon: Icon(
            Icons.keyboard_arrow_down_outlined,
            size: 25,
          ),
          style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
              fontFamily: viewHeadingFontfamily),
          itemHeight: 50,
          isExpanded: true,
          menuMaxHeight: 200,
          // value: val,
          onChanged: (String? newval) {
            valChange(newval);
          },
          items: items.map((String items) {
            return DropdownMenuItem(child: Text(items), value: items);
          }).toList(),
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xffDADADA),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ],
    );
  }
  Column filterSlider(double _lowerValue, double _upperValue, String title, String suffix)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        FlutterSlider(
          handlerHeight: 25,
          values: [_lowerValue, _upperValue],
          rangeSlider: true,
          trackBar: FlutterSliderTrackBar(
              activeTrackBarHeight: 5,
              inactiveTrackBarHeight: 5,
              inactiveTrackBar: BoxDecoration(
                // color: Colors.blue[200],

              )),
          handler: FlutterSliderHandler(
            decoration: BoxDecoration(),
            child: Container(
              width: 15,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          rightHandler: FlutterSliderHandler(
            decoration: BoxDecoration(),
            child: Container(
              width: 15,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          tooltip: FlutterSliderTooltip(
              leftSuffix: Text(" $suffix"),
              rightSuffix: Text(" $suffix"),
              boxStyle: FlutterSliderTooltipBox(
                  decoration: BoxDecoration(
                    color: whiteColor,
                  )),
              textStyle: TextStyle(
                color: blackColor,
                fontSize: small_FontSize,
              ),
              alwaysShowTooltip: true,
              positionOffset: FlutterSliderTooltipPositionOffset(top: 40.0)),
          max: 20,
          min: 0,
          onDragging: (handlerIndex, lowerValue, upperValue) {
            _lowerValue = lowerValue;
            _upperValue = upperValue;

            print("_lowervalue changed to $_lowerValue");
            print("_uppervalue changed to $_upperValue");
            setState(() {});
          },
        )
      ],
    );
  }

  void searchResult(String query)
  {
    final suggestions = jobSeekerTrendingCardListData.where((job) {
      var jobTitle = job.jobType.toLowerCase();
      var input = query.toLowerCase();

      print(input);
      print(jobTitle);

      return jobTitle.contains(input);
    }).toList();

    // print("show the search records $suggestions");

    print(suggestions.length);

    setState(() => TRJOBS = suggestions);
  }

  void filterResult()
  {
    final filter = jobSeekerTrendingCardListData.where((job) {
      var jobloc = job.jobLocation.toLowerCase();

      var jobRol = job.jobType.toLowerCase();

      bool flag = jobloc.contains(location.toLowerCase()) &&
          jobRol.contains(jobRole.toLowerCase());

      return flag;
    }).toList();

    setState(() => TRJOBS = filter);

    setState(() {
      location = "";
    });
    setState(() {
      subRole = "";
    });
    setState(() {
      jobRole = "";
    });
  }

}
