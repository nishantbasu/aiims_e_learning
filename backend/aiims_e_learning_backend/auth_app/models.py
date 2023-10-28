from django.db import models
from django.contrib.auth.models import AbstractUser
from courses.models import *


class User(AbstractUser):
    id = models.AutoField(primary_key=True)
    email=models.EmailField(verbose_name='email',max_length=255,unique=True)
    phone=models.CharField(null=True,max_length=255)
    REQUIRED_FIELDS=['username','phone','first_name','is_active','evaluation_attempted','evaluation_marks']
    USERNAME_FIELD='email'
    evaluation_attempted=models.BooleanField(default=False)
    evaluation_marks=models.IntegerField(default=0)
    

    def get_username(self):
        return self.email



