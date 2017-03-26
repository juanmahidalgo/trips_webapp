package tripswebapp.model
import grails.rest.*

class City {

    String name
    Set<Attraction> attractions
    Country country
    String image

    static hasMany = [attractions : Attraction]
    static hasOne = [country: Country]

    static mapping = { country lazy: false }

    public String toString() {
        name
    }

    static constraints = {
        country nullable: false
    }


}
