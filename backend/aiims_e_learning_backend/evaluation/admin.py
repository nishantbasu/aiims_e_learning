from django.contrib import admin
from .models import EvaluationQuestions,Evaluation
# Register your models here.
admin.site.register(Evaluation)
admin.site.register(EvaluationQuestions)