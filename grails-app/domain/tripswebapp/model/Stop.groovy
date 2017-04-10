package tripswebapp.model

import grails.rest.Resource
import tripswebapp.media.AudioGuide


@Resource(uri='/stops',  formats=['json', 'xml'])

class Stop {

    String name
    String description
    AudioGuide audioGuide
    City city
    Set<Review> reviews

    static belongsTo = [city: City]
    static hasMany = [reviews: Review]

    static constraints = {
        audioGuide(nullable: true)
        city nullable: false
    }

    public String toString() {
        name
    }
}
