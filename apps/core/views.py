from django.shortcuts import render
from rest_framework.views import exception_handler as drf_exception_handler
# Create your views here.


def exception_handler(exc, context):
    response = drf_exception_handler(exc, context)
    return response