
from rest_framework import serializers
from .models import Evaluation,EvaluationQuestions


class EvaluationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Evaluation
        fields = ('id','instructions','time_in_seconds')

class EvaluationQuestionsSerializer(serializers.ModelSerializer):
    class Meta:
        model = EvaluationQuestions
        fields = ('id','evaluation','question','option1','option2','option3','option4','answer')