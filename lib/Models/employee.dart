class Employee {
  final String employeeId;
  final String employeeName;
  final String employeeCNIC;
  final String employeeDepartment;
  final String employeeDesignation;
  final bool present;

  Employee({
    required this.employeeId,
    required this.employeeName,
    required this.employeeCNIC,
    required this.employeeDepartment,
    required this.employeeDesignation,
    required this.present,
  });

  factory Employee.fromJson(Map<String, dynamic> json,bool pres) {
    return Employee(
      employeeId: json["EmpId"].toString(),
      employeeName: json["EmpName"].toString(),
      employeeCNIC: json["EmpCnic"].toString(),
      employeeDepartment: json["DepName"].toString(),
      employeeDesignation: json["DesignationName"].toString(),
      present: pres,
    );
  }
}
