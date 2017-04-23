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
    Set<StopTraduction> traductions

    static belongsTo = [city: City]
    static hasMany = [reviews: Review, audioGuides: AudioGuide, traductions: StopTraduction]

    static constraints = {
        city nullable: false
        traductions nullable: true
    }

    public String toString() {
        name
    }
}
