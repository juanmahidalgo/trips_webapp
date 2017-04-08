package tripswebapp.model
import grails.rest.*
import tripswebapp.media.Image

class City {

    String name
    String state
    Set<Attraction> attractions
    Country country
    Image image

    static hasMany = [attractions : Attraction]
    static hasOne = [country: Country]

    static mapping = { country lazy: false }

    public String toString() {
        name
    }

    static constraints = {
        country nullable: false
        image nullable: true
        state nullable: true
    }
}
