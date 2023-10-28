from rest_framework import serializers
from .models import Course,Video,Library,Quiz,Questionofquiz#,Question

class CourseSerializer(serializers.ModelSerializer):
    class Meta:
        model = Course
        fields = ('id','course_name','course_description','thumbnail')


class VideoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Video
        fields = ('id','course_name','title','description','video')

# class QuestionSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = Question
#         fields = ('id','video_name','question','option1','option2','option3','option4')

class LibrarySerializer(serializers.ModelSerializer):
    class Meta:
        model = Library
        fields = ('id','course_name','title','description','pdf')

class QuizSerializer(serializers.ModelSerializer):
    class Meta:
        model = Quiz
        fields = ('id','course_name','number_of_questions')

class QuizquestionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Questionofquiz
        fields = ('id','quiz','question','option1','option2','option3','option4','answer')