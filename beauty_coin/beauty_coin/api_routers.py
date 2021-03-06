from django.conf import settings
from rest_framework.routers import DefaultRouter, SimpleRouter


# from palmy_cutie_ieie.users.api.views import SignupViewSet
from profiles.api.viewsets import SignupViewSet

if settings.DEBUG:
    router = DefaultRouter()
else:
    router = SimpleRouter()

router.register('signup', SignupViewSet, basename='signup')

app_name = 'api'
urlpatterns = router.urls
