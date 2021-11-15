from django.contrib.auth import get_user_model
from django.db import models

User = get_user_model()


class Profile(models.Model):
    """1 to 1 relation of User and Profile."""
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    address = models.CharField(max_length=42, null=False, blank=False)

    def __str__(self):
        return f"{self.address}"
