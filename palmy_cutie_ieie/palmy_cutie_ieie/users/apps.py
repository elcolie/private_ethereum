from django.apps import AppConfig
from django.utils.translation import gettext_lazy as _


class UsersConfig(AppConfig):
    name = "palmy_cutie_ieie.users"
    verbose_name = _("Users")

    def ready(self):
        try:
            import palmy_cutie_ieie.users.signals  # noqa F401
        except ImportError:
            pass
