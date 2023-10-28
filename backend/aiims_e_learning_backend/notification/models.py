from django.db import models

# Create your models here.
from django.db import models

# Create your models here.
# Create your models here.
class Notification(models.Model):
    id=models.AutoField(primary_key=True)
    title=models.CharField(max_length=100)
    details=models.CharField(max_length=200)
    
    def __str__(self):
        return self.title