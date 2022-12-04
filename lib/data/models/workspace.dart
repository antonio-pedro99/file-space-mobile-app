class WorkSpace {
  final String workSpaceName;
  final double storageLimit;
  final double storageUsed;
  final String joiningDate;

  WorkSpace(
      {required this.joiningDate,
      required this.storageLimit,
      required this.storageUsed,
      required this.workSpaceName});
}

/* {
  "name",
  "joining_date",
  ""
}
 */