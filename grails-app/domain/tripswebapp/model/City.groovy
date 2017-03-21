package tripswebapp.model

class City {


    String name

    Set<Attraction> attractions

    static hasMany = [attractions : Attraction]

    static constraints = {

    }
}
