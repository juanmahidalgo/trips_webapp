package tripswebapp.model
import grails.rest.*

class City {

    String name
    Set<Attraction> attractions
    Country country

    static hasMany = [attractions : Attraction]
    static hasOne = [country: Country]

    static constraints = {
        country nullable: false
    }
}
