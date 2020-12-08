class ParkingData {
  String key;
  String subject;
  bool completed;
  String userId;

  ParkingData(this.subject, this.userId, this.completed);

  /*ParkingData.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        userId = snapshot.value["userId"],
        subject = snapshot.value["subject"],
        completed = snapshot.value["completed"];
  */
  toJson() {
    return {
      "userId": userId,
      "subject": subject,
      "completed": completed,
    };
  }
}
