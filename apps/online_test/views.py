from django.shortcuts import render
from django.views import View


class HomePage(View):

    def get(self, request):
        return render(request, 'home-page/home_page.html')
        
    def post(self, request):
        pass

class Learn(View):

    def get(self, request):
        return render(request, 'learn/learn.html')



class Login(View):

    def get(self, request):
        return render(request,'login/login.html')


class Login1(View):

    def get(self, request):
        return render(request,'login1/login1.html')             
    
