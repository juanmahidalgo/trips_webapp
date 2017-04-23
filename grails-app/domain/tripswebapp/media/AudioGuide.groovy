package tripswebapp.media

class AudioGuide {
    String path
    static constraints = {
        path nullable: false
    }
    public String toString() {
        path
    }
}
