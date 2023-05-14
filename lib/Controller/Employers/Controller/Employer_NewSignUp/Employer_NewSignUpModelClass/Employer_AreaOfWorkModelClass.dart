
  class Employer_AreaOfWorkModelClass {
    List<CommonDataEmp>? commonDataEmp;

    Employer_AreaOfWorkModelClass({this.commonDataEmp});

    Employer_AreaOfWorkModelClass.fromJson(Map<String, dynamic> json) {
      if (json['commonDataEmp'] != null) {
        commonDataEmp = <CommonDataEmp>[];
        json['commonDataEmp'].forEach((v) {
          commonDataEmp!.add(new CommonDataEmp.fromJson(v));
        });
      }
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      if (this.commonDataEmp != null) {
        data['commonDataEmp'] =
            this.commonDataEmp!.map((v) => v.toJson()).toList();
      }
      return data;
    }
  }

  class CommonDataEmp {
    int? industryId;
    String? industryName;

    CommonDataEmp({this.industryId, this.industryName});

    CommonDataEmp.fromJson(Map<String, dynamic> json) {
      industryId = json['industry_id'];
      industryName = json['industry_name'];
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['industry_id'] = this.industryId;
      data['industry_name'] = this.industryName;
      return data;
    }
  }