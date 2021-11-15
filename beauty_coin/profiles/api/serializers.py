from django.contrib.auth import get_user_model
from rest_framework import serializers

from profiles.models import Profile

User = get_user_model()


class UserSignupSerializer(serializers.ModelSerializer):
    """Sign up only"""
    email = serializers.EmailField(required=True)

    class Meta:
        model = User
        fields = [
            'username',
            'password',
            'email',
        ]

    def create(self, validated_data):
        user = User.objects.create_user(
            validated_data['username'],
            password=validated_data['password'],
            email=validated_data['email']
        )
        user.is_superuser = False
        user.is_staff = False
        user.save()
        from web3 import Web3, HTTPProvider
        w3 = Web3(HTTPProvider('http://localhost:8545'))  # web3 must be called locally
        w3.isConnected()
        _address = w3.geth.personal.new_account(validated_data['password'])
        Profile.objects.create(
            user=user,
            address=_address
        )
        return user
