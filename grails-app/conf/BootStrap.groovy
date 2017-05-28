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
            returnArray['latitude'] = it.latitude
            returnArray['longitude'] = it.longitude
            return returnArray
        }
        JSON.registerObjectMarshaller(Attraction) {
            def map = [:]
            map.putAll(it.properties)
            map['id'] = it.id
            return map
        }
        JSON.registerObjectMarshaller(Route) {
            def map = [:]
            map.putAll(it.properties)
            map['stops'] = it.stops
            return map
        }
        JSON.registerObjectMarshaller(Advertisment) {
            def map = [:]
            map.putAll(it.properties)
            map['image'] = it.image
            return map
        }
        JSON.registerObjectMarshaller(PointOfInterest) {
            def map = [:]
            map.putAll(it.properties)
            map['image'] = it.image
            return map
        }
        JSON.registerObjectMarshaller(Review) {
            def returnArray = [:]
            returnArray['id'] = it.id
            returnArray['author'] = it.author?.name
            returnArray['date'] = it.date
            returnArray['score'] = it.score
            returnArray['text'] = it.text
            return returnArray
        }

    }
    def destroy = {

    }
}
