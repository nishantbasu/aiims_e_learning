from django.shortcuts import render

# Create your views here.
from django.shortcuts import render

# Create your views here.
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework import status
from datetime import datetime
from .models import Notification
from .serializers import NotificationSerializer
from rest_framework.permissions import IsAuthenticated

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def NotificationView(request):
    data=Notification.objects.all()
    serializer=NotificationSerializer(data,many=True)
    return Response(serializer.data,status=status.HTTP_200_OK)