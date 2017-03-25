package tripswebapp.model

import grails.rest.Resource
import tripswebapp.media.AttractionMap
import tripswebapp.media.Image
import tripswebapp.media.Video
import tripswebapp.utils.Classification

class Attraction extends Stop{

    Float latitude
    Float longitude
    String schedule
    Float cost
    Integer averageTime
    Classification classification
    Set<Image> images
    Set<Video> videos
    Set<AttractionMap> maps
    Set<PointOfInterest> pointsOfInterest

    static hasMany = [images : Image, videos: Video, maps: AttractionMap, pointsOfInterest : PointOfInterest]

    static constraints = {
        schedule nullable: true
        cost nullable: true
        averageTime nullable: true
        images nullable: true
        videos nullable: true
        maps nullable: true
        pointsOfInterest nullable:true
    }
}
