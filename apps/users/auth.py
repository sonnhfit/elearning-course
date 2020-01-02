from datetime import timedelta
from django.utils.translation import ugettext_lazy as _
from django.utils import timezone
from django.conf import settings
from rest_framework import exceptions
from rest_framework.authentication import TokenAuthentication

from . import models as user_models


class BearerAuthentication(TokenAuthentication):
    keyword = 'Bearer'
    model = user_models.Token

    def authenticate_credentials(self, key):
        model = self.get_model()
        try:
            token = model.objects.select_related('user').get(key=key)
        except model.DoesNotExist:
            raise exceptions.AuthenticationFailed(_('Invalid token.'))

        utc_now = timezone.now()
        expired_time = token.created + timedelta(seconds=settings.EXPIRED_TOKEN_TIME)
        if utc_now > expired_time:
            raise exceptions.AuthenticationFailed(_('Token has expired'))

        if not token.user.is_active:
            raise exceptions.AuthenticationFailed(_('User inactive or deleted.'))

        return (token.user, token)
