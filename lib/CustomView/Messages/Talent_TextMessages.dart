
import 'package:contractjobs/Constant/ConstantIcon.dart';
import 'package:contractjobs/Constant/Constants.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Controller/ModelClass/All_employers.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Controller/ModelClass/EarningCardData.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Controller/ModelClass/employersM.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Controller/Talent_Billing/Talent_Billings.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Controller/Talent_Passbook/Talent_Passbook.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Controller/Talent_RaiseBill/Talent_RaiseBillOfService.dart';
import 'package:contractjobs/Controller/Talents/Controller/TalentDashboard/Talent_Controller/Talent_SalaryStatus/Talent_SalaryStatus.dart';
import 'package:flutter/material.dart';


/*--------------intro slide messages start 7-10-2022 ------------------*/
const getIntroF_Heading="Kaam karne ka Naya Tareeka";
//const getIntroF_SubHeading="Empowering every Indian worker to become socially secured and financially independent";
const getIntroF_SubHeading="Get social security benefits such as PF and ESIC, no matter your job, and become socially secure and financially independent.";


//const getIntroS_Heading="Online Staffing\nPlatform";
//const getIntroS_SubHeading="An online staffing platform changing the way contract workers are discovered sourced and paid.";

const getIntroS_Heading="Why Is Social Security Important?";
const getIntroS_SubHeading="Social security benefits reduce the burden on workers by providing them with healthcare and retirement benefits, thus enabling them to have a more secure future.";

//const getIntroTh_Heading="India's Work\nMarketplace";
//const getIntroTh_SubHeading="Powered by recruiters, partners agencies and entrepreneurs to match job opportunities with the Right Talent";

const getIntroTh_Heading="Become A Socially Responsible Work Giver!";
const getIntroTh_SubHeading="Extend social security benefits to all workers and elevate them to lead a better lifestyle";

/*--------------intro slide messages end 7-10-2022 ------------------*/


/*--------------login option hint start ------------------*/

const getTheTalentKey_LoginOption="I am an Employee";
const getTheTalentValue_LoginOption="Become socially secure by availing \nbenefits such as PF, ESIC & Gratuity";

const getTheJobSeekerKey_LoginOption="I Need a Job";
const getTheJobSeekerValue_LoginOption="Find contract jobs at the click of a \nbutton";

const getTheJobGiverKey_LoginOption="I am an Employer";
const getTheJobGiverValue_LoginOption="Provide social security benefits to all \nyour employees.";

 List getLoginOptionList()
 {
 /*  return [{"title":getTheTalentKey_LoginOption,"subTitle":getTheTalentValue_LoginOption,"selectionStatus":true},
     {"title":getTheJobSeekerKey_LoginOption,"subTitle":getTheJobSeekerValue_LoginOption,"selectionStatus":false},
     {"title":getTheJobGiverKey_LoginOption,"subTitle":getTheJobGiverValue_LoginOption,"selectionStatus":false}];
*/

   return [{"title":getTheJobGiverKey_LoginOption,"subTitle":getTheJobGiverValue_LoginOption,"selectionStatus":true},
     {"title":getTheTalentKey_LoginOption,"subTitle":getTheTalentValue_LoginOption,"selectionStatus":false}];
 }
/*--------------login option hint end ------------------*/


var getEarningCardList = [
  Ernd(
    title: "Passbook",
    subtitle: "All your transactions in one place",
    image: Talent_Icon_EarningPassbook,
    buttontxt: "Click here",
    page: Talent_Passbook(),
  ),
  Ernd(
    title: "Billings",
    subtitle: "Your complete billing record",
    image: Talent_Icon_EarningBilling,
    buttontxt: "Click here",
    page: Talent_Billings(),
  ),
  Ernd(
    title: "Make Your First Transaction Now",
    subtitle: "Raise bill and share it with your employer ",
    image: Talent_Icon_EarningTransaction,
    buttontxt: "Raise Bill",
    page: Talent_RaiseBillOfService(),
  ),
  Ernd(
    title: "Salary Status",
    subtitle: "Track your salary easily",
    image: Talent_Icon_SalaryStatus,
    buttontxt: "Click here",
    page: Talent_SalaryStatus(),
  ),
  Ernd(
    title: "Income Tax Returns",
    subtitle: "View your tax details and upload documents",
    image: Talent_Icon_IncomeTaxReturn,
    buttontxt: "Click here",
    page: Scaffold(),
  ),
];


var getPassbookCaskKhataList = [
  PassbookCashKhata(
    transactionType: "Withdrawl",
    transactionDateTime: "5 sep 2022, 2:00PM",
    transactionAmt: "- ₹1000.",
    transactionAmtZero: "00",
  ),
  PassbookCashKhata(
    transactionType: "Received from ABC",
    transactionDateTime: "2 sep 2022, 2:00PM",
    transactionAmt: "- ₹1000.",
    transactionAmtZero: "00",
  ),
  PassbookCashKhata(
    transactionType: "Received from XYZ",
    transactionDateTime: "5 sep 2022, 2:00PM",
    transactionAmt: "- ₹1000.",
    transactionAmtZero: "00",
  ),
];

var getTalentEmployeeList = [
  All_Emps(category: "Other Employers", emplys: [
    Emps(
      initials: "SK",
      name: "Sharukh Khan",
      email: "shahrukhan@akalinfosys.com",
      phone: "800076785",
    ),
    Emps(
      initials: "AK",
      name: "Akhshya kumar",
      email: "akhshya99@akalinfosys.com",
      phone: "800076785",
    ),
    Emps(
      initials: "AK",
      name: "Akhshya kumar",
      email: "akhshya99@akalinfosys.com",
      phone: "800076785",
    ),
    Emps(
      initials: "JS",
      name: "Jai singh",
      email: "jai-singh24@akalinfosys.com",
      phone: "800076785",
    ),
  ]),
  All_Emps(category: "Prime Employers", emplys: [
    Emps(
      initials: "WP",
      name: "Wipro",
      email: "wipro.com",
      phone: "01-01-2022 to 01-10-2022",
    ),
    Emps(
      initials: "IN",
      name: "infosys",
      email: "infosys.com",
      phone: "01-01-2022 to 01-10-2022",
    ),
  ]),
];

var getRaiseBillChooseEmployerList = [
  BillRaiseChooseEmployer(companyname: "Wipro Ltd.", mobileno: "800076787", email: "abc@gmail.com", companylogo: null),
  BillRaiseChooseEmployer(companyname: "Amitabh Bachan aaaaaaaaaaaaaaaaaaaaaaaa", mobileno: "800076787", email: "amitab@gmail.com", companylogo:Wipro_Icon),
  BillRaiseChooseEmployer(companyname: "Jayashree", mobileno: "800076787", email: "amitab@gmail.com", companylogo:Wipro_Icon),
  BillRaiseChooseEmployer(companyname: "Pratibha", mobileno: "800076787", email: "amitab@gmail.com", companylogo: null),
  BillRaiseChooseEmployer(companyname: "Amitabh Bachan", mobileno: "800076787", email: "amitab@gmail.com", companylogo:Wipro_Icon),
  BillRaiseChooseEmployer(companyname: "Amitabh Bachan", mobileno: "800076787", email: "amitab@gmail.com", companylogo: null),
  BillRaiseChooseEmployer(companyname: "Pratibha", mobileno: "800076787", email: "amitab@gmail.com", companylogo:Wipro_Icon),
  BillRaiseChooseEmployer(companyname: "Amitabh Bachan", mobileno: "800076787", email: "amitab@gmail.com", companylogo: null),
  BillRaiseChooseEmployer(companyname: "Amitabh Bachan", mobileno: "800076787", email: "amitab@gmail.com", companylogo:Wipro_Icon),
  BillRaiseChooseEmployer(companyname: "Madhusmita", mobileno: "800076787", email: "amitab@gmail.com", companylogo: null),
  BillRaiseChooseEmployer(companyname: "Amitabh Bachan", mobileno: "800076787", email: "amitab@gmail.com", companylogo:Wipro_Icon),
  BillRaiseChooseEmployer(companyname: "Amitabh Bachan", mobileno: "800076787", email: "amitab@gmail.com", companylogo:Wipro_Icon),
  BillRaiseChooseEmployer(companyname: "Amitabh Bachan", mobileno: "800076787", email: "amitab@gmail.com", companylogo: null),
  BillRaiseChooseEmployer(companyname: "jayashree", mobileno: "800076787", email: "amitab@gmail.com", companylogo:null),
];

/*--------salary status 4-10-2022 start-----------*/
var salaryStatusList = [
  Talent_SalaryStatusM(month: "August 2022", dateRange: "01/08/2022 - 31/08/2022"),
  Talent_SalaryStatusM(month: "July 2022", dateRange: "01/08/2022 - 31/08/2022"),
  Talent_SalaryStatusM(month: "June 2022", dateRange: "01/08/2022 - 31/08/2022"),
  Talent_SalaryStatusM(month: "May 2022", dateRange: "01/08/2022 - 31/08/2022"),
];





