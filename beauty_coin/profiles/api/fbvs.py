"""Function Based View file."""
import typing
import logging
from rest_framework import status
from rest_framework.authtoken.models import Token
from rest_framework.decorators import api_view, renderer_classes, authentication_classes, permission_classes
from rest_framework.renderers import JSONRenderer
from rest_framework.response import Response
from web3 import Web3, HTTPProvider

from payment_transactions.models import PaymentTransaction
from profiles.api.serializers import SendTransactionSerializer

logger = logging.getLogger('django')


def retrieve_token(request) -> typing.Union[Token, Response]:
    """Return token from request."""
    try:
        token_str = request.META['HTTP_AUTHORIZATION']
    except KeyError as err:
        return Response(data={
            'message': str(err)
        }, status=status.HTTP_400_BAD_REQUEST)
    try:
        token = Token.objects.get(key=token_str)
    except Token.DoesNotExist as err:
        return Response(data={
            'message': str(err),
        }, status=status.HTTP_404_NOT_FOUND)
    return token


@api_view(('GET',))
@renderer_classes((JSONRenderer,))
def welcome(request):
    """Example of token and response"""
    token = retrieve_token(request)
    return Response(data={
        'message': f"Hello {token.user.username}",
    }, status=status.HTTP_200_OK)


@api_view(('GET',))
@renderer_classes((JSONRenderer,))
@authentication_classes(())
@permission_classes(())
def get_balance(request):
    logger.info("get_balance")
    token = retrieve_token(request)
    w3 = Web3(HTTPProvider('http://localhost:8545'))  # web3 must be called locally
    balance_eth = w3.eth.get_balance(w3.toChecksumAddress(token.user.profile.address)) / (10 ** 18)
    logger.info(f"ETH: {balance_eth}")
    return Response(data={
        'balance': balance_eth,
    }, status=status.HTTP_200_OK)


@api_view(('POST',))
@renderer_classes((JSONRenderer,))
@authentication_classes(())
@permission_classes(())
def send_transaction(request):
    """Send transaction to private Ethereum."""
    token = retrieve_token(request)
    serializer = SendTransactionSerializer(data=request.data)
    if serializer.is_valid():
        # Check send to sender itself is not allowed
        if token.user.profile.address == request.data['to']:
            return Response(data={
                'message': "Unable to send to same address"
            }, status=status.HTTP_400_BAD_REQUEST)
        # Do transaction
        w3 = Web3(HTTPProvider('http://localhost:8545'))  # web3 must be called locally
        to_address = w3.toChecksumAddress(serializer.validated_data['to'])
        from_address = w3.toChecksumAddress(token.user.profile.address)
        # value = '%.0f' % (serializer.validated_data['value'] * 1000000000000000000)
        value = serializer.validated_data['value'] * 1000000000000000000
        logger.info(f"Wei: {value}")
        w3.geth.personal.unlock_account(
            from_address,
            serializer.validated_data['password'],
            3000,
        )
        try:
            transaction = w3.eth.send_transaction({
                'to': to_address,
                'from': from_address,
                'value': value,
            })
        except ValueError as err:
            # Have 0 want 10000
            return Response(data=err.args[0], status=status.HTTP_403_FORBIDDEN)
        w3.geth.personal.lock_account(from_address)
        kwargs = {
            'from_address': from_address,
            'to_address': to_address,
            'value': str(value),
            'transaction_number': transaction.hex(),
        }
        logger.info(kwargs)
        _ = PaymentTransaction.objects.create(**kwargs)
        return Response(data=kwargs, status=status.HTTP_201_CREATED)
    return Response(data=serializer.errors, status=status.HTTP_400_BAD_REQUEST)
