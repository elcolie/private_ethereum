from django.contrib.auth import get_user_model
from rest_framework import serializers

from palmy_cutie_ieie.profiles.models import Profile

User = get_user_model()


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ["username", "name", "url"]

        extra_kwargs = {
            "url": {"view_name": "api:user-detail", "lookup_field": "username"}
        }


class UserSignupSerializer(serializers.ModelSerializer):
    """Sign up only"""
    email = serializers.EmailField(required=True)

    class Meta:
        model = User
        fields = [
            'username',
            'name',
            'password',
            'email',
        ]

    def create(self, validated_data):
        user = User.objects.create_user(
            validated_data['username'],
            name=validated_data['name'],
            password=validated_data['password'],
            email=validated_data['email']
        )
        user.is_superuser = False
        user.is_staff = False
        user.save()
        from web3 import Web3, HTTPProvider
        w3 = Web3(Web3.HTTPProvider('localhost:8545'))
        w3.isConnected()
        _address = w3.geth.personal.new_account(validated_data['password'])
        Profile.objects.create(
            user=user,
            address=_address
        )
        return user
