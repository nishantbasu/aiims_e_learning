from django.db import models
from auth_app.models import User

# Create your models here.
class Evaluation(models.Model):
    id=models.AutoField(primary_key=True)
    instructions=models.TextField(default='No Instructions')
    time_in_seconds=models.IntegerField()

    def __int__(self):
        return self.number_of_questions


class EvaluationQuestions(models.Model):
    id=models.AutoField(primary_key=True)
    evaluation=models.ForeignKey(Evaluation,on_delete=models.CASCADE)
    question=models.TextField()
    option1=models.CharField(max_length=200)
    option2=models.CharField(max_length=200)
    option3=models.CharField(max_length=200)
    option4=models.CharField(max_length=200)
    answer=models.IntegerField()
    
    def __str__(self):
        return self.question

