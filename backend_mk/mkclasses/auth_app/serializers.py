from djoser.serializers import UserCreateSerializer, UserSerializer
from rest_framework import serializers
from .models import *


class UserCreateSerializer(UserCreateSerializer):



    
    class Meta(UserCreateSerializer.Meta):
        model= User
        fields= ('id','email','username','password','first_name','phone','is_active','evaluation_attempted','evaluation_marks')