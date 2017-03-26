package tripswebapp.model

class Country {

    String name
    Set<City> cities

    static hasMany = [cities: City]

    public String toString() {
        name
    }

    static constraints = {
    }
}
