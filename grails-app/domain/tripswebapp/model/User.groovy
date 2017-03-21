package tripswebapp.model

class User {

    String name
    Set<Stop> favourites
    Set<Stop> visited

    static hasMany = [favourites : Stop, visited: Stop]

    static constraints = {

    }
}
