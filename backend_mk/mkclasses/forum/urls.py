from django.contrib import admin
from django.urls import path,re_path
from forum.views import *
from django.conf.urls import  url
 
urlpatterns = [
    path('',home,name='home'),
    path('addInForum/',addInForum,name='addInForum'),
    path('addInDiscussion/',addInDiscussion,name='addInDiscussion'),
    path('<str:forum_id>/getDiscussion/',getDiscussion,name='getDiscussion'),
    path('getDate/',getDate,name='getDate'),
    
   # url(r'^reset/password/reset/confirm/(?P<uid>[\w-]+)/(?P<token>[\w-]+)/$', PasswordResetView.as_view(),),
]
