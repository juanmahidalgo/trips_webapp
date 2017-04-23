package tripswebapp.model
import tripswebapp.media.AudioGuide

import grails.rest.Resource
@Resource(uri='/stops',  formats=['json', 'xml'])

class Stop {

    String name
    String description
    City city
    Set<AudioGuide> audioGuides
    Set<Review> reviews

    static belongsTo = [city: City]
    static hasMany = [reviews: Review, audioGuides: AudioGuide]

    static constraints = {
        city nullable: false
    }

    public String toString() {
        name
    }
}
