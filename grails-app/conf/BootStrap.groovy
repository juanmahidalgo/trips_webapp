import tripswebapp.model.City

class BootStrap {

    def init = { servletContext ->
        if (City.count() == 0) {
            new City(name: 'Buenos Aires').save()
        }
    }
    def destroy = {
    }
}
