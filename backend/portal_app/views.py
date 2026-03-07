from django.http import HttpResponse
from django.shortcuts import render
from django.views import View

from portal_app.forms import ReservationForm

# Create your views here.
def hello_world(request):
    return HttpResponse("Hello World")

class hello_class(View):
    def get(self, request):
        return HttpResponse("Hello Class")
    
def home(request):
    form = ReservationForm()

    if request.method == 'POST':
        form = ReservationForm(request.POST)
        if form.is_valid():
            form.save()
            return HttpResponse("Success")
        
    return render(request, 'index.html', {'form': form})

def about(request):
    return render(request, 'about.html')