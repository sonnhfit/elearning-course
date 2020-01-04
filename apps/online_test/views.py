from django.shortcuts import render
from django.views import View


class Login(View):

    def get(self, request):
        return render(request,'login/login.html')


class Login1(View):

    def get(self, request):
        return render(request,'login1/login1.html')        