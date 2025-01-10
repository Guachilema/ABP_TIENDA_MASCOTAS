from django.db import models
from django.contrib.auth.models import User

class Producto(models.Model):
    nombre = models.CharField(max_length=100)
    descripcion = models.TextField()
    precio = models.DecimalField(max_digits=10, decimal_places=2)
    imagen = models.ImageField(upload_to='productos/')
    disponible = models.BooleanField(default=True)

    def __str__(self):
        return self.nombre

class ProductoCarrito(models.Model):
    producto = models.ForeignKey(Producto, on_delete=models.CASCADE)
    usuario = models.ForeignKey(User, on_delete=models.CASCADE, null=True, blank=True)
    session_id = models.CharField(max_length=255, null=True, blank=True)
    cantidad = models.PositiveIntegerField(default=1)
    
    def __str__(self):
        return f'{self.producto.nombre} - {self.cantidad}'

    @property
    def total(self):
        return self.cantidad * self.producto.precio  # Cambié 'self.precio' por 'self.producto.precio'
