package tripswebapp.utils

class Classification {

    String name

    static constraints = {
        name nullable: false
    }

    public String toString() {
        name
    }
}
