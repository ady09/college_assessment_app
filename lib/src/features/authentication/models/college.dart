

class UserCollege {
  List<dynamic> questionAnswers;
  String comments;
  String currentQuestionIndex;
  

  UserCollege({
    required this.questionAnswers,
    required this.comments,
    required this.currentQuestionIndex,
  });

  Map<String, dynamic> toJson() => {
        "comments": comments,
        "current question": currentQuestionIndex,
        "answers": questionAnswers,
      };

  factory UserCollege.fromJson(Map<String, dynamic> map) {
    
    return UserCollege(
      comments: map['comments'],
      currentQuestionIndex: map['current question'],
      questionAnswers: map['answers'],
      
    );
  }
}
