from rest_framework import serializers
from django.contrib.auth.models import User
from .models import LoginHistory


class LoginEmailValidator(serializers.Serializer):
    username = serializers.CharField(required=True, allow_blank=False)
    password = serializers.CharField(required=True, allow_blank=False)


class UserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = (
            'id', 'username', 'email',
        )


class TokenSerializer(serializers.Serializer):
    access_token = serializers.CharField()
    user = UserSerializer(read_only=True)


class LoginHistorySerializer(serializers.ModelSerializer):

    class Meta:
        model = LoginHistory
        fields = (
            'start_date', 'end_date', 'num_date',
        )
