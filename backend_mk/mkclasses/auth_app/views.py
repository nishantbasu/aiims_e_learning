from django.shortcuts import render
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from django.shortcuts import redirect
from django.contrib import messages
import requests
from django.contrib.sites.shortcuts import get_current_site
from .models import User
from .serializers import UserCreateSerializer

# Create your views here.
@api_view(['GET'])
@permission_classes([IsAuthenticated])
def restricted(request,*args,**kwargs):
    return Response(data="Only for logged in Users",status=status.HTTP_200_OK)

# @api_view(['GET'])
# def PasswordResetView(request,uid,token):
#     post_data = {'uid': uid, 'token': token}
#     return Response(post_data)


@api_view(('GET','POST'))
def PasswordResetView(request,uid,token):
    if request.POST:
        password=request.POST.get('password1')
        payload = {'uid': uid, 'token': token, 'new_password': password,'re_new_password':password}
        a=get_current_site(request)
        
        url='http://'+str(a)+'/auth/users/reset_password_confirm/'
        print(url)
        response = requests.post(url,data=payload)
        if response.status_code==204:
            messages.success(request, 'Your password has been reset successfully!')
            print('Success')
            return render(request,'templates/success.html')
        else:
            return Response(response.json())
    else:
        return render(request,'templates/reset_password.html')

@api_view(['GET'])
def ActivateView(request,uid,token):
    a=get_current_site(request)
    url='http://'+str(a)+'/auth/users/activation/'
    payload = {'uid': uid, 'token': token}
    response = requests.post(url,data=payload)
    return Response(response)



# if request.POST:
        
        
        
#         if response.status_code==204:
#             messages.success(request, 'Your password has been reset successfully!')
#             print('Success')
#             return render(request,'templates/success.html')
#         else:
#             return Response(response.json())
#     else:

        
    
#         return render(request,'templates/reset_password.html')

@api_view(['PATCH'])
@permission_classes([IsAuthenticated])
def PatchAttemptView(request,uid):
    d=request.data
    data=User.objects.get(id=uid)
    data.evaluation_attempted=d.get("evaluation_attempted",data.evaluation_attempted)
    data.save()
    serializer=UserCreateSerializer(data)
    return Response(serializer.data,status=status.HTTP_200_OK)

@api_view(['PATCH'])
@permission_classes([IsAuthenticated])
def PatchMarksView(request,uid):
    d=request.data
    data=User.objects.get(id=uid)
    data.evaluation_marks=d.get("evaluation_marks",data.evaluation_marks)
    data.save()
    serializer=UserCreateSerializer(data)
    return Response(serializer.data,status=status.HTTP_200_OK)