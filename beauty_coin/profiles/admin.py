from django.contrib import admin

from profiles.models import Profile


class ProfileAdmin(admin.ModelAdmin):
    __basic_fields = ['id', 'user', 'address']
    list_display = __basic_fields
    list_display_links = __basic_fields


admin.site.register(Profile, ProfileAdmin)
