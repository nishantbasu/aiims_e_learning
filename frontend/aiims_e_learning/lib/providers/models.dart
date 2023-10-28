class Courses {
  final int id;
  final String course_name;
  final String course_description;
  final String thumbnail;

  Courses({this.id, this.course_name, this.course_description, this.thumbnail});

  factory Courses.fromJson(Map<String, dynamic> json) {
    return Courses(
        id: json['id'] as int,
        course_name: json['course_name'] as String,
        course_description: json['course_description'] as String,
        thumbnail: json['thumbnail'] as String);
  }
}

class Faculties {
  final int id;
  final String faculty_name;
  final String specialization;
  final String about;
  final String photo;

  Faculties(
      {this.id,
      this.faculty_name,
      this.specialization,
      this.about,
      this.photo});

  factory Faculties.fromJson(Map<String, dynamic> json) {
    return Faculties(
      id: json['id'] as int,
      faculty_name: json['faculty_name'] as String,
      specialization: json['specialization'] as String,
      about: json['about'] as String,
      photo: json['photo'] as String,
    );
  }
}

class Notifications {
  final int id;
  final String title;
  final String details;

  Notifications({
    this.id,
    this.title,
    this.details,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['id'] as int,
      title: json['title'] as String,
      details: json['details'] as String,
    );
  }
}

class Videolists {
  final int id;
  final int course_name;
  final String title;
  final String description;
  final String video;

  Videolists(
      {this.id, this.course_name, this.title, this.description, this.video});

  factory Videolists.fromJson(Map<String, dynamic> json) {
    return Videolists(
      id: json['id'] as int,
      course_name: json['course_name'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      video: json['video'] as String,
    );
  }
}

class Pdflists {
  final int id;
  final int course_name;
  final String title;
  final String description;
  final String pdf;

  Pdflists({this.id, this.course_name, this.title, this.description, this.pdf});

  factory Pdflists.fromJson(Map<String, dynamic> json) {
    return Pdflists(
      id: json['id'] as int,
      course_name: json['course_name'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      pdf: json['pdf'] as String,
    );
  }
}

// class Questions {
//   final int id;
//   final int video_name;
//   final String question;
//   final String option1;
//   final String option2;
//   final String option3;
//   final String option4;
//   final int answer;

//   Questions(
//       {this.id,
//       this.video_name,
//       this.question,
//       this.option1,
//       this.option2,
//       this.option3,
//       this.option4,
//       this.answer});

//   factory Questions.fromJson(Map<String, dynamic> json) {
//     return Questions(
//       id: json['id'] as int,
//       video_name: json['video_name'] as int,
//       question: json['question'] as String,
//       option1: json['option1'] as String,
//       option2: json['option2'] as String,
//       option3: json['option3'] as String,
//       option4: json['option4'] as String,
//       answer: json['answer'] as int,
//     );
//   }
// }

class UserList {
  final String username;
  final String phone;
  final int id;
  final String email;

  UserList({
    this.username,
    this.phone,
    this.id,
    this.email,
  });

  factory UserList.fromJson(Map<String, dynamic> json) {
    return UserList(
      username: json['username'] as String,
      phone: json['phone'] as String,
      id: json['id'] as int,
      email: json['email'] as String,
    );
  }
}

class ForumList {
  final int id;
  final String name;
  final int email;
  final String topic;
  final String description;
  final String date_created;

  ForumList(
      {this.id,
      this.name,
      this.email,
      this.topic,
      this.description,
      this.date_created});

  factory ForumList.fromJson(Map<String, dynamic> json) {
    return ForumList(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as int,
      topic: json['topic'] as String,
      description: json['description'] as String,
      date_created: json['date_created'] as String,
    );
  }
}

class Discussion {
  final int id;
  final int forum;
  final String discuss;

  Discussion({this.id, this.forum, this.discuss});

  factory Discussion.fromJson(Map<String, dynamic> json) {
    return Discussion(
      id: json['id'] as int,
      forum: json['forum'] as int,
      discuss: json['discuss'] as String,
    );
  }
}

class QuizList {
  final int id;
  final int course_name;
  final int number_of_questions;

  QuizList({this.id, this.course_name, this.number_of_questions});

  factory QuizList.fromJson(Map<String, dynamic> json) {
    return QuizList(
      id: json['id'] as int,
      course_name: json['course_name'] as int,
      number_of_questions: json['number_of_questions'] as int,
    );
  }
}

class QuizQuestionList {
  final int id;
  final int quiz;
  final String question;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final int answer;

  QuizQuestionList(
      {this.id,
      this.quiz,
      this.question,
      this.option1,
      this.option2,
      this.option3,
      this.option4,
      this.answer});

  factory QuizQuestionList.fromJson(Map<String, dynamic> json) {
    return QuizQuestionList(
      id: json['id'] as int,
      quiz: json['quiz'] as int,
      question: json['question'] as String,
      option1: json['option1'] as String,
      option2: json['option2'] as String,
      option3: json['option3'] as String,
      option4: json['option4'] as String,
      answer: json['answer'] as int,
    );
  }
}

class EvaluationList {
  final int id;
  final String instructions;
  final int time_in_seconds;

  EvaluationList({this.id, this.instructions, this.time_in_seconds});

  factory EvaluationList.fromJson(Map<String, dynamic> json) {
    return EvaluationList(
      id: json['id'] as int,
      instructions: json['instructions'] as String,
      time_in_seconds: json['time_in_seconds'] as int,
    );
  }
}

class EvaluationQuestionList {
  final int id;
  final int evaluation;
  final String question;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final int answer;

  EvaluationQuestionList(
      {this.id,
      this.evaluation,
      this.question,
      this.option1,
      this.option2,
      this.option3,
      this.option4,
      this.answer});

  factory EvaluationQuestionList.fromJson(Map<String, dynamic> json) {
    return EvaluationQuestionList(
      id: json['id'] as int,
      evaluation: json['evaluation'] as int,
      question: json['question'] as String,
      option1: json['option1'] as String,
      option2: json['option2'] as String,
      option3: json['option3'] as String,
      option4: json['option4'] as String,
      answer: json['answer'] as int,
    );
  }
}
