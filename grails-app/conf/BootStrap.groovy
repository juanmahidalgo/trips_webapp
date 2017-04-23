import tripswebapp.model.*
import grails.converters.JSON


class BootStrap {

    def init = { servletContext ->
        if (City.count() == 0) {
            new City(name: 'Buenos Aires').save()
        }
        JSON.registerObjectMarshaller(City) {
            def returnArray = [:]
            returnArray['id'] = it.id
            returnArray['name'] = it.name
            returnArray['country_name'] = it.country.name
            returnArray['image'] = it.image
            return returnArray
        }
        JSON.registerObjectMarshaller(Attraction) {
            def map = [:]
            map.putAll(it.properties)
            map['id'] = it.id
            return map
        }
        JSON.registerObjectMarshaller(Review) {
            def returnArray = [:]
            returnArray['id'] = it.id
            returnArray['author'] = it.author.name
            returnArray['date'] = it.date
            returnArray['image'] = it.image
            return returnArray
        }

    }
    def destroy = {

    }
}
