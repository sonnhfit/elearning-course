from django.contrib import admin
from django.urls import path, include
from . import views as online_views

urlpatterns = [
    path('', online_views.index, name='index'),
    path('manage/', online_views.prof_manage, name='manage'),
    path('quizzes/', online_views.quizlist_user, name='quizlist_user'),
]