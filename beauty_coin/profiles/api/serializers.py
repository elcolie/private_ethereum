import logging
from django.contrib.auth import get_user_model
from rest_framework import serializers
from rest_framework.exceptions import ValidationError

from profiles.models import Profile

logger = logging.getLogger('django')
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
        try:
            w3 = Web3(HTTPProvider('http://localhost:8545'))  # web3 must be called locally
            w3.isConnected()
            _address = w3.geth.personal.new_account(validated_data['password'])
        except Exception as err:
            logger.info(err)
            user.delete()
        else:
            Profile.objects.create(
                user=user,
                address=_address.lower()
            )
            return user


class SendTransactionSerializer(serializers.Serializer):
    to = serializers.CharField()
    value = serializers.FloatField()
    password = serializers.CharField()

    class Meta:
        fields = [
            'to',
            'value',
            'password',
        ]

    def validate_to(self, data):
        if Profile.objects.filter(address=data.lower()).exists():
            return data
        raise ValidationError('Not a valid address')


class ProfileSerializer(serializers.ModelSerializer):
    class Meta:
        fields = [
            'address',
        ]
