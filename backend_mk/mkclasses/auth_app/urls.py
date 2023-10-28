from django.urls import path, include
from auth_app import views
from django.conf import settings
from django.conf.urls.static import static
from django.conf.urls import url
from .views import *


urlpatterns = [
    path('',include('djoser.urls')),
    path('',include('djoser.urls.authtoken')),
    path('restricted/', views.restricted),
    path('reset/password/reset/confirm/<str:uid>/<str:token>', views.PasswordResetView,),
    path('activate/<str:uid>/<str:token>', views.ActivateView,),
    path('patchattempted/<str:uid>/', views.PatchAttemptView,),
    path('patchmarks/<str:uid>/', views.PatchMarksView,),
    
    #url(r'^reset/password/reset/confirm/(?P<uid>[\w-]+)/(?P<token>[\w-]+)/$', PasswordResetView.as_view(),),
]
