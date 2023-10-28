from django.contrib import admin

# Register your models here.
from .models import Course,Video,Library,Quiz,Questionofquiz#,Question

admin.site.register(Course)
admin.site.register(Video)
#admin.site.register(Question)
admin.site.register(Library)
admin.site.register(Quiz)
admin.site.register(Questionofquiz)