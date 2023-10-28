from django.contrib import admin
from django.urls import path,include
from .views import FacultyView
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('',FacultyView,name='FacultyView' ),
]
