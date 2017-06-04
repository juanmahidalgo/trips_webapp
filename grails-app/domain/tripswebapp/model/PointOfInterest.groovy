package tripswebapp.model

import tripswebapp.media.AudioGuide
import tripswebapp.media.Image

class PointOfInterest{

    AudioGuide audioGuide
    Image image
    String description
    String name
    Set<PointTraduction> traductions
    Integer position

    static hasMany = [traductions: PointTraduction]
    static belongsTo = [attraction: Attraction]
    static constraints = {
        name nullable: false
        description nullable: false
        position nullable: true
        audioGuide nullable: true
        image nullable: true
    }
    static mapping = {
        image lazy: false
    }
}
