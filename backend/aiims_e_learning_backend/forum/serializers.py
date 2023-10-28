from rest_framework import serializers
from .models import Forum,Discussion

class ForumSerializer(serializers.ModelSerializer):
    class Meta:
        model = Forum
        fields = ('id','name','email','topic','description','date_created')

class DiscussionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Discussion
        fields = ('id','forum','discuss')

class DateSerializer(serializers.ModelSerializer):
    class Meta:
        model = Forum
        fields = ('topic','date_created')