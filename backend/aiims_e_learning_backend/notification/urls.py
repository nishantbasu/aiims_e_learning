from django.contrib import admin
from django.urls import path,include
from .views import NotificationView
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('',NotificationView,name='NotificationView'),
]
