package tripswebapp.model
import grails.rest.*
import tripswebapp.media.Image

class City {

    String name
    String state
    Set<Attraction> attractions
    Country country
    Image image
    BigDecimal latitude
    BigDecimal longitude
    Set<Route> routes

    static hasMany = [attractions : Attraction, routes: Route]
    static hasOne = [country: Country]

    static mapping = { country lazy: false }

    public String toString() {
        name
    }

    static constraints = {
        country nullable: false
        image nullable: true
        state nullable: true
        routes nullable: true
        latitude( scale : 16 )
        longitude( scale : 16 )
    }
}
