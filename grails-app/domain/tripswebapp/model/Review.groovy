package tripswebapp.model

import grails.rest.Resource

@Resource(uri='/reviews', formats=['json'])
class Review {
    Stop stop
    String text
    User author
    Date date
    Integer score

    static constraints = {
        author nullable: true
    }
}
