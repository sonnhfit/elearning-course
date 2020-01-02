from django.contrib import admin
from .models import GradingSystem, GradeRange


class GradingSystemAdmin(admin.ModelAdmin):
    readonly_fields = ('creator',)

admin.site.register(GradingSystem, GradingSystemAdmin)
admin.site.register(GradeRange)
