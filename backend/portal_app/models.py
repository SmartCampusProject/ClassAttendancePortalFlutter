from django.db import models

# Create your models here.
class MenuItem(models.Model):
    name = models.CharField(max_length=255)
    price = models.IntegerField()

class Reservation(models.Model):
    first_name = models.CharField(max_length=255)
    last_name = models.CharField(max_length=255)
    guests_count = models.IntegerField()
    resevation_time = models.DateTimeField(auto_now=True)
    comments = models.CharField(max_length=1000)