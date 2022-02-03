"""beauty_coin URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from rest_framework.authtoken.views import obtain_auth_token
from profiles.api.fbvs import welcome, get_balance, send_transaction, my_address

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('beauty_coin.api_routers')),
    path('api/auth-token/', obtain_auth_token),
    path('api/welcome/', welcome, name='welcome'),
    path('api/balance/', get_balance, name='get_balance'),
    path('api/send-transaction/', send_transaction, name='send_transaction'),
    path('api/my-address/', my_address, name='my_address'),
]
