package tripswebapp.model

import tripswebapp.media.AudioGuide
import tripswebapp.media.Image

class PointOfInterest{

    AudioGuide audioGuide
    Image image
    String description
    String name

    static belongsTo = [attraction: Attraction]
    static constraints = {
        name nullable: true
        description nullable: true
    }
    static mapping = {
        image lazy: false
    }
}
