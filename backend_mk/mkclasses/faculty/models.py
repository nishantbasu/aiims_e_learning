from django.db import models

# Create your models here.
# Create your models here.
class Faculty(models.Model):
    id=models.AutoField(primary_key=True)
    faculty_name=models.CharField(max_length=100)
    specialization=models.CharField(max_length=200)
    about=models.CharField(max_length=200)
    photo=models.ImageField(upload_to="faculty_photos/%y",default='/faculty_photos/20/default.jpg')
    
    def __str__(self):
        return self.faculty_name