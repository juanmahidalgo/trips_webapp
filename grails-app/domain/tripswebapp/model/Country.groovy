package tripswebapp.model

class Country {

    String name
    Set<City> cities

    static hasMany = [cities: City]

    static constraints = {
    }
}
