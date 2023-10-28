from django.db import models 
from auth_app.models import *
    
#parent model
class Forum(models.Model):
    id=models.AutoField(primary_key=True)
    name=models.CharField(max_length=200,default="anonymous" )
    email=models.ForeignKey(User,blank=True,on_delete=models.CASCADE)
    topic=models.CharField(max_length=300)
    description = models.CharField(max_length=300)
    date_created=models.DateTimeField(auto_now_add=True,null=True)
    
    def __str__(self):
        return self.topic
    def getdate(self):
        return self.date_created
 
#child model
class Discussion(models.Model):
    id=models.AutoField(primary_key=True)
    forum = models.ForeignKey(Forum,blank=True,on_delete=models.CASCADE)
    discuss = models.CharField(max_length=1000)
 
    def __str__(self):
        return str(self.forum)