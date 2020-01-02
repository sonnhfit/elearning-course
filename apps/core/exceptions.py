from rest_framework import status
from rest_framework.exceptions import (
    ValidationError, NotFound, APIException,
    AuthenticationFailed, PermissionDenied,
)


class HTTP400BadRequestError(ValidationError):
    pass


class HTTP401AuthenticationError(AuthenticationFailed):
    pass


class HTTP403ForbiddenError(PermissionDenied):
    pass


class HTTP404NotFoundError(NotFound):
    status_code = status.HTTP_404_NOT_FOUND
    default_detail = 'resource not found'
    default_code = 'not found'


class HTTP409ConflictError(APIException):
    status_code = status.HTTP_409_CONFLICT
    default_detail = 'Conflict resource'
    default_code = 'conflict'
