from django.shortcuts import render

# Create your views here.
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework import status
from datetime import datetime
from .models import Course,Video,Library,Quiz,Questionofquiz#,Question
from .serializers import CourseSerializer,VideoSerializer,LibrarySerializer,QuizSerializer,QuizquestionSerializer#,QuestionSerializer
from rest_framework.permissions import IsAuthenticated


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def CourseView(request):
    data=Course.objects.all()
    serializer=CourseSerializer(data,many=True)
    return Response(serializer.data,status=status.HTTP_200_OK)

@api_view(['GET'])
def VideoView(request,course_id):
    data=Video.objects.filter(course_name=course_id)
    serializer=VideoSerializer(data,many=True)
    return Response(serializer.data,status=status.HTTP_200_OK)

# @api_view(['GET'])
# @permission_classes([IsAuthenticated])
# def QuestionView(request,video_id,course_id):
#     data=Question.objects.filter(video_name=video_id)
#     serializer=QuestionSerializer(data,many=True)
#     return Response(serializer.data,status=status.HTTP_200_OK)


@api_view(['GET'])
def LibraryView(request,course_id):
    data=Library.objects.filter(course_name=course_id)
    serializer=LibrarySerializer(data,many=True)
    return Response(serializer.data,status=status.HTTP_200_OK)

@api_view(['GET'])
def QuizView(request,course_id):
    data=Quiz.objects.filter(course_name=course_id)
    serializer=QuizSerializer(data,many=True)
    return Response(serializer.data,status=status.HTTP_200_OK)

@api_view(['GET'])
def QuizQuestionView(request,quiz_id,course_id):
    data=Questionofquiz.objects.filter(quiz=quiz_id)
    serializer=QuizquestionSerializer(data,many=True)
    return Response(serializer.data,status=status.HTTP_200_OK)