package tripswebapp.model

import grails.rest.Resource
import tripswebapp.media.AudioGuide


@Resource(uri='/stops',  formats=['json', 'xml'])

class Stop {

    String name
    String description
    AudioGuide audioGuide

    static constraints = {
        audioGuide(nullable: true)
    }
}
