class Organization {
  final String organizationId;
  final String organizationName;
  final String organizationParentId;
  final String organizationType;

  Organization({
    required this.organizationId,
    required this.organizationName,
    required this.organizationParentId,
    required this.organizationType,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      organizationId: json["InternalOrganizationId"].toString(),
      organizationName: json["InternalOrganizationName"].toString(),
      organizationParentId: json["ParentOrganizationId"].toString(),
      organizationType: json["OrganizationType"].toString(),
    );
  }
}
