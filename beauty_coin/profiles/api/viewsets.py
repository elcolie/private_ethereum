from rest_framework.mixins import CreateModelMixin
from rest_framework.viewsets import GenericViewSet

from profiles.api.serializers import UserSignupSerializer


class SignupViewSet(CreateModelMixin, GenericViewSet):
    permission_classes = ()
    serializer_class = UserSignupSerializer
