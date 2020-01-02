from django.contrib import admin

from .models import Token, LoginHistory, Notification, UserNotification


class TokenAdmin(admin.ModelAdmin):
    list_display = ('key', 'user', 'created')


class LoginHistoryAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'start_date', 'end_date', 'num_date')


class NotificationAdmin(admin.ModelAdmin):
    list_display = ('id', 'title', 'body', 'created_at')


class UserNotificationAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'notification', 'is_read', 'created_at')


admin.site.register(Token, TokenAdmin)
admin.site.register(LoginHistory, LoginHistoryAdmin)
admin.site.register(Notification, NotificationAdmin)
admin.site.register(UserNotification, UserNotificationAdmin)
