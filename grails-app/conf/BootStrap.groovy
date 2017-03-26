import tripswebapp.model.*
import grails.converters.JSON


class BootStrap {

    def init = { servletContext ->
        if (City.count() == 0) {
            new City(name: 'Buenos Aires').save()
        }
        JSON.registerObjectMarshaller(City) {
            def returnArray = it.properties
            return returnArray
        }
        JSON.registerObjectMarshaller(Attraction) {
            def returnArray = it.properties
            return returnArray
        }

    }
    def destroy = {

    }
}
