from django.urls import path
from portal_app import views

urlpatterns = [
    path('function', views.hello_world),
    path('class', views.hello_class.as_view()),
]
