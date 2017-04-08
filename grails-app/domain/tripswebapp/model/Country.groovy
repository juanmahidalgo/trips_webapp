package tripswebapp.model

class Country {

    String name

    static hasMany = [cities: City]

    Country(String name) {
        name = name
    }

    public String toString() {
        name
    }

    static constraints = {
    }
}
