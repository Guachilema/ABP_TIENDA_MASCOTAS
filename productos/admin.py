from django.contrib import admin

# Register your models here.
# tienda_mascotas/admin.py

from django.contrib import admin
from .models import Producto

@admin.register(Producto)
class ProductoAdmin(admin.ModelAdmin):
    list_display = ('nombre', 'precio', 'disponible')
    search_fields = ('nombre',)
