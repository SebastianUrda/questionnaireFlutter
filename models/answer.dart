class Answer{
  double latitude;
  double longitude;
  DateTime date;
  int answer;
  int questionId;
  int userId;

  Answer({this.latitude, this.longitude, this.date, this.answer, this.questionId,
      this.userId});

  Map<String,dynamic> toJson()=>{
    'latitude':latitude,
    'longitude':longitude,
    'date':date.toIso8601String().split(".")[0]+"Z",
    'answer':answer,
    'questionId':questionId,
    'userId':userId
  };

  @override
  String toString() {
    return 'Answer{latitude: $latitude, longitude: $longitude, date: $date, answer: $answer, questionId: $questionId, userId: $userId}';
  }


}