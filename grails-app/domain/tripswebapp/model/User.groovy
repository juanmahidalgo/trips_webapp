package tripswebapp.model

import grails.rest.Resource

@Resource(uri='/users',  formats=['json', 'xml'])

class User {

    String name
    Set<Stop> favourites
    Set<Stop> visited

    static hasMany = [favourites : Stop, visited: Stop]

    static constraints = {
        favourites nullable: true
        visited nullable: true
    }
}
