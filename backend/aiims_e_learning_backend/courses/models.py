from django.db import models
from auth_app.models import *

# Create your models here.
class Course(models.Model):
    id=models.AutoField(primary_key=True)
    course_name=models.CharField(max_length=100)
    course_description=models.CharField(max_length=200)
    thumbnail=models.FileField(upload_to="thumbnail/%y",default='book.png')
    
    def __str__(self):
        return self.course_name


class Video(models.Model):
    id=models.AutoField(primary_key=True)
    course_name=models.ForeignKey(Course,on_delete=models.CASCADE)
    title=models.CharField(max_length=100)
    description=models.CharField(max_length=200)
    video=models.FileField(upload_to="video/%y")
    
    def __str__(self):
        return self.title


# class Question(models.Model):
#     id=models.AutoField(primary_key=True)
#     video_name=models.ForeignKey(Video,on_delete=models.CASCADE)
#     question=models.TextField()
#     option1=models.CharField(max_length=200)
#     option2=models.CharField(max_length=200)
#     option3=models.CharField(max_length=200)
#     option4=models.CharField(max_length=200)
#     answer=models.IntegerField()
    
#     def __str__(self):
#         return self.question

class Library(models.Model):
    id=models.AutoField(primary_key=True)
    course_name=models.ForeignKey(Course,on_delete=models.CASCADE)
    title=models.CharField(max_length=100)
    description=models.CharField(max_length=200)
    pdf=models.FileField(upload_to="pdf/%y")
    
    def __str__(self):
        return self.title

class Quiz(models.Model):
    id=models.AutoField(primary_key=True)
    course_name=models.ForeignKey(Course,on_delete=models.CASCADE)
    number_of_questions=models.IntegerField()

    def __int__(self):
        return self.number_of_questions


class Questionofquiz(models.Model):
    id=models.AutoField(primary_key=True)
    quiz=models.ForeignKey(Quiz,on_delete=models.CASCADE)
    question=models.TextField()
    option1=models.CharField(max_length=200)
    option2=models.CharField(max_length=200)
    option3=models.CharField(max_length=200)
    option4=models.CharField(max_length=200)
    answer=models.IntegerField()
    
    def __str__(self):
        return self.question

