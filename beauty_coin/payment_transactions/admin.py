from django.contrib import admin

from payment_transactions.models import PaymentTransaction


class PaymentTransactionAdmin(admin.ModelAdmin):
    __basic_fields = [
        'id',
        'from_address',
        'to_address',
        'value',
        'transaction_number',
        'created',
        'updated',
    ]
    list_display = __basic_fields
    list_display_links = __basic_fields


admin.site.register(PaymentTransaction, PaymentTransactionAdmin)
