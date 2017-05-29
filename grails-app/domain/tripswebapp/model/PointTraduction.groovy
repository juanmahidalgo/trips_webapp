package tripswebapp.model

import tripswebapp.media.AudioGuide

class PointTraduction {

    Language lang
    String description
    PointOfInterest point
    AudioGuide audioGuide

    static belongsTo = [point: PointOfInterest]

    static constraints = {
        audioGuide nullable: true
        point nullable: false
    }

    public String toString() {
        lang
    }
}
