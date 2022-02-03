from django.contrib.auth import get_user_model
from django.test import TestCase
from rest_framework import status
from rest_framework.reverse import reverse
from rest_framework.test import APIClient

from profiles.api.serializers import SendTransactionSerializer
from profiles.models import Profile

User = get_user_model()


def register_user(username: str, address: str) -> None:
    user = User.objects.create(username=username)
    Profile.objects.create(
        user=user,
        address=address
    )
    return user


class CoinTransaction(TestCase):

    def setUp(self) -> None:
        self.foggy = register_user('foggy', '0xa456c84CC005100B277D4637896456F99a59A290'.lower())
        self.sarit = register_user('sarit', '0xB795518Ee574c2a55B513D2C1319e8e6e40F6c04'.lower())

    def test_serializer_wrong_address(self) -> None:
        data = {
            'to': "No body",
            'value': 1,
            'password': 'somepassword',
        }
        serializer = SendTransactionSerializer(data=data)
        self.assertFalse(serializer.is_valid())
        self.assertEqual(
            'Not a valid address',
            str(serializer.errors['to'][0])
        )

    def test_serializer_correct_address(self) -> None:
        data = {
            'to': self.sarit.profile.address,
            'value': 1,
            'password': 'somepassword',
        }
        serializer = SendTransactionSerializer(data=data)
        self.assertTrue(serializer.is_valid())

    def test_serializer_non_integer_amount(self) -> None:
        data = {
            'to': self.sarit.profile.address,
            'value': 0.5,
            'password': 'somepassword',
        }
        serializer = SendTransactionSerializer(data=data)
        self.assertTrue(serializer.is_valid())

    def test_see_account_address_authenticated_user(self) -> None:
        client = APIClient()
        client.force_authenticate(user=self.sarit)
        url = reverse('my_address')
        res = client.get(url)
        self.assertEqual(status.HTTP_200_OK, res.status_code)
        self.assertEqual({'address': '0xb795518ee574c2a55b513d2c1319e8e6e40f6c04'}, res.data)

    def test_see_account_address_anonymous(self) -> None:
        client = APIClient()
        url = reverse('my_address')
        res = client.get(url)
        self.assertEqual('Authentication credentials were not provided.', str(res.data['detail']))
