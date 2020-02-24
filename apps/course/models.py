from django.db import models

# Create your models here.
class Courses(models.Model):
    course_name = models.CharField(max_length=200)
    time_pub = models.DateTimeField()

class Lessons(models.Model):
    course_name = models.ForeignKey(Courses, on_delete=models.CASCADE)
    lesson = models.CharField(max_length=100)
    
