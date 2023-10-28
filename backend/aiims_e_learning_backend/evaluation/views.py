from django.shortcuts import render
from .forms import *
# Create your views here.
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework import status
from datetime import datetime
from .models import EvaluationQuestions,Evaluation
from .serializers import EvaluationSerializer,EvaluationQuestionsSerializer
from rest_framework.permissions import IsAuthenticated



@api_view(['GET'])
@permission_classes([IsAuthenticated])
def EvaluationView(request):
    data=Evaluation.objects.all()
    serializer=EvaluationSerializer(data,many=True)
    return Response(serializer.data,status=status.HTTP_200_OK)



# @api_view(['PATCH'])
# @permission_classes([IsAuthenticated])
# def EvaluationViewPatch(request,user_id):
#     d=request.data
#     data=Evaluation.objects.get(user=user_id)
#     data.attempted=d.get("attempted",data.attempted)
#     data.number_of_questions=d.get("number_of_questions",data.number_of_questions)
#     data.user=d.get("user",data.user)
#     data.time_in_seconds=d.get("time_in_seconds",data.time_in_seconds)
#     data.save()
#     serializer=EvaluationSerializer(data)
#     return Response(serializer.data,status=status.HTTP_200_OK)

    

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def EvaluationQuestionsView(request,evaluation_id):
    data=EvaluationQuestions.objects.filter(evaluation=evaluation_id)
    serializer=EvaluationQuestionsSerializer(data,many=True)
    return Response(serializer.data,status=status.HTTP_200_OK)