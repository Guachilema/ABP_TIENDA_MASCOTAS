
# Create your views here.
from django.db import models
from django.shortcuts import render, redirect, get_object_or_404
from .models import Producto, ProductoCarrito
from django.contrib.sessions.models import Session
from django.contrib import messages

def index(request):
    productos = Producto.objects.all()
    return render(request, 'productos/index.html', {'productos': productos})

def producto_detalle(request, id):
    producto = get_object_or_404(Producto, id=id)
    return render(request, 'productos/producto_detalle.html', {'producto': producto})


def productos(request):
    productos = Producto.objects.filter(disponible=True)
    return render(request, 'productos.html', {'productos': productos})
# productos/views.py


def agregar_al_carrito(request, producto_id):
    # Verifica si el usuario tiene una sesión activa
    if not request.session.session_key:
        request.session.create()

    producto = get_object_or_404(Producto, id=producto_id)
    cantidad = 1  # Aquí puedes modificar si quieres agregar una cantidad diferente
    
    # Verifica si el producto ya está en el carrito
    carrito_item, created = ProductoCarrito.objects.get_or_create(
        session_id=request.session.session_key,
        producto=producto,
        defaults={'cantidad': cantidad}
    )
    
    if not created:  # Si el producto ya existe, solo aumenta la cantidad
        carrito_item.cantidad += cantidad
        carrito_item.save()

    return redirect('productos:index')  # O redirige a la página de carrito si lo prefieres
def ver_carrito(request):
    carrito_items = ProductoCarrito.objects.filter(session_id=request.session.session_key)

    productos_con_totales = []
    total_general = 0  # Total acumulado de todos los productos en el carrito

    for item in carrito_items:
        total_item = item.cantidad * item.producto.precio
        productos_con_totales.append({
            'item': item,
            'total': total_item
        })
        total_general += total_item

    return render(request, 'productos/ver_carrito.html', {'productos_con_totales': productos_con_totales, 'total_general': total_general})

def limpiar_carrito(request):
    # Eliminar todos los productos del carrito de la sesión
    ProductoCarrito.objects.filter(session_id=request.session.session_key).delete()
    return redirect('productos:ver_carrito')

def eliminar_producto(request, item_id):
    item = get_object_or_404(ProductoCarrito, id=item_id)
    item.delete()
    return redirect('productos:ver_carrito')

def confirmar_compra(request):
    if request.method == "POST":
        cantidad_pedidos = int(request.POST.get("cantidad_pedidos", 1))
        # Limpiamos el carrito después de confirmar la compra
        request.session["productos_con_totales"] = []
        request.session.modified = True

        return render(request, "productos/confirmacion.html", {
            "cantidad_pedidos": cantidad_pedidos,
        })

    return redirect("productos:carrito")
