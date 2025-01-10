from django.conf import settings
from django.conf.urls.static import static
from django.urls import path
from . import views
app_name = 'productos'

urlpatterns = [
    path('', views.index, name='index'),
    path('producto/<int:id>/', views.producto_detalle, name='producto_detalle'),
    path('productos/', views.productos, name='productos'),
    path('ver_carrito/', views.ver_carrito, name='ver_carrito'),
    path('eliminar_producto/<int:item_id>/', views.eliminar_producto, name='eliminar_producto'),  # Mantener solo esta línea
    path('limpiar_carrito/', views.limpiar_carrito, name='limpiar_carrito'),
    path('agregar_al_carrito/<int:producto_id>/', views.agregar_al_carrito, name='agregar_al_carrito'),
    path("confirmar-compra/", views.confirmar_compra, name="confirmar_compra"),
]
# tienda_mascotas/urls.py

