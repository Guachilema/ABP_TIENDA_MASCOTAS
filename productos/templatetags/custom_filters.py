# productos/templatetags/custom_filters.py
from django import template

register = template.Library()

@register.filter
def multiply(value, arg):
    """Multiplica dos valores."""
    try:
        return value * arg
    except (TypeError, ValueError):
        return 0
