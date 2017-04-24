package tripswebapp.model

import tripswebapp.media.AudioGuide

class StopTraduction {

    Language lang
    String description
    Stop stop
    AudioGuide audioGuide

    static belongsTo = [stop: Stop]

    static constraints = {
        audioGuide nullable: true
    }

    public String toString() {
        lang
    }
}
