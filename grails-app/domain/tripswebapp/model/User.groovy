package tripswebapp.model

import grails.rest.Resource

/*
@Resource(uri='/users',  formats=['json', 'xml'])
*/

class User {

    String name
    String password
    Boolean blocked
    String fbId
    String token

    Set<Fav> favourites
    Set<Stop> visited

    static hasMany = [favourites : Fav, visited: Stop]

    static mapping = {
        blocked defaultValue: false
    }

    static constraints = {
        favourites nullable: true
        visited nullable: true
        password nullable: false
        fbId nullable: true
    }

    public String toString() {
        name
    }

}
