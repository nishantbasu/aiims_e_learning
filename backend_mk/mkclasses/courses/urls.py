from django.contrib import admin
from django.urls import path,include
from .views import CourseView,VideoView,LibraryView,QuizView,QuizQuestionView#,QuestionView
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('',CourseView, name='CourseView' ),
    path('<str:course_id>/videos/',VideoView, name='VideoView' ),
    #path('<str:course_id>/videos/<str:video_id>/questions/',QuestionView, name='QuestionView' ),
    path('<str:course_id>/e_library/',LibraryView, name='LibraryView'),
    path('<str:course_id>/quiz/',QuizView, name='QuizView'),
    path('<str:course_id>/quiz/<str:quiz_id>/questions/',QuizQuestionView, name='QuizQuestionView' ),
]+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

