package tripswebapp.model

import tripswebapp.media.Image

class Route {
    Set<Stop> stops
    ArrayList<String> stopsOrder
    String name
    String description
    City city
    Image image


    static constraints = {
        city nullable: false
        name nullable: false
        image nullable: true
    }

    static hasMany = [stops: Stop]

}
