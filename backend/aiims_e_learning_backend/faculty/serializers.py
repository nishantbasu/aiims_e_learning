from .models import Faculty
from rest_framework import serializers

class FacultySerializer(serializers.ModelSerializer):
    class Meta:
        model = Faculty
        fields = ('id','faculty_name','specialization','about','photo')