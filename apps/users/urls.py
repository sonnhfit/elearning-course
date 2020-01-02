from django.urls import path
from . import views as user_views

urlpatterns = [
    path('login/', user_views.LoginAPIView.as_view()),
    path('login_history/', user_views.GetUserInfoAPIView.as_view()),
]
