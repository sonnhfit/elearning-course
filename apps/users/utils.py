from django.utils import timezone
from apps.users.models import LoginHistory


def create_or_update_login_history(user_id):
    current_day = timezone.now()
    if LoginHistory.objects.filter(user_id=user_id).exists():
        user_login_day = LoginHistory.objects.filter(
            user_id=user_id
        ).order_by('-end_date').first()
        diff_date = current_day.date() - user_login_day.end_date
        if diff_date.days == 1:
            user_login_day.end_date = current_day.date()
            user_login_day.num_date = user_login_day.num_date + 1
            user_login_day.save()
        elif diff_date.days != 0:
            LoginHistory.objects.create(user_id=user_id)
    else:
        LoginHistory.objects.create(user_id=user_id)
