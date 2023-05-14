class Emp_Attendence {
  String? month;
  String? no_of_days;
  String? leave_taken;
  String? leave_balance;

  Emp_Attendence(
      {this.month, this.no_of_days, this.leave_taken, this.leave_balance});
}

class Emp_Attendance_Details {
  var month;
  var year;
  var present;
  var leave;
  var totalPaidDays;

  Emp_Attendance_Details(
      {this.month, this.year, this.present,this.leave,this.totalPaidDays});
}