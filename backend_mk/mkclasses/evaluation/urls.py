from django.contrib import admin
from django.urls import path,include
from .views import EvaluationView,EvaluationQuestionsView
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('',EvaluationView, name='EvaluationView'),
    # path('<str:user_id>/patch',EvaluationViewPatch, name='EvaluationViewPatch'),
    path('<str:evaluation_id>/questions/',EvaluationQuestionsView, name='EvaluationQuestionsView'),
]+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

