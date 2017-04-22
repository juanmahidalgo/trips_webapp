package tripswebapp.model

import grails.rest.Resource

/*
@Resource(uri='/users',  formats=['json', 'xml'])
*/

class User {

    String name
    String password
    Boolean blocked

    Set<Stop> favourites
    Set<Stop> visited

    static hasMany = [favourites : Stop, visited: Stop]

    static mapping = {
        blocked defaultValue: false
    }

    static constraints = {
        favourites nullable: true
        visited nullable: true
        password nullable: false
    }

    public String toString() {
        name
    }

}
