package tripswebapp.model


class Fav {

    Date date
    Attraction stop
    User user

    static constraints = {
        stop nullable: false
        date nullable: false
        user nullable: false
    }
}
