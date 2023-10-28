
from .models import * 
from .forms import *
from django.shortcuts import redirect, render
from djoser.conf import django_settings
# Create your views here.
 
from django.shortcuts import render,redirect

# Create your views here.
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework import status
from datetime import datetime
from rest_framework.permissions import IsAuthenticated
from .serializers import ForumSerializer,DiscussionSerializer
from rest_framework.views import APIView

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def home(request):
    data=Forum.objects.all()
    serializer=ForumSerializer(data,many=True)
    return Response(serializer.data,status=status.HTTP_200_OK)

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def getDate(request):
    data=Forum.objects.all()
    count=data.count()
    count=count-1
    topic=data[count]
    data=topic.getdate()
    return Response(data,status=status.HTTP_200_OK)

@api_view(['POST'])
@permission_classes([IsAuthenticated])
def addInForum(request):
    form = CreateInForum(request.POST)
    print(form)
    if form.is_valid():
        form.save()
        return Response({"message": "Got some data!", "data": form.data})
    else:
        
        return Response({"message":"Bad Request"},status=status.HTTP_400_BAD_REQUEST)

@api_view(['POST'])
@permission_classes([IsAuthenticated])
def addInDiscussion(request):
    form = CreateInDiscussion(request.POST)
    if form.is_valid():
        form.save()
        return Response({"message": "Got some data!", "data": form.data},status=status.HTTP_200_OK)
    else:
        return Response({"message":"Bad Request"},status=status.HTTP_400_BAD_REQUEST)
    

@api_view(['GET'])
def getDiscussion(request,forum_id):
    data=Discussion.objects.filter(forum=forum_id)
    serializer=DiscussionSerializer(data,many=True)
    return Response(serializer.data,status=status.HTTP_200_OK)




# class PasswordResetView(APIView):

#    def get (self, request, uid, token):
#        post_data = {'uid': uid, 'token': token}
#        return Response(post_data)

