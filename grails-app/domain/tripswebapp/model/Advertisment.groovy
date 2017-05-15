package tripswebapp.model

import tripswebapp.media.Image

class Advertisment {
    City city
    String title
    String subtitle
    String description
    BigDecimal latitude
    BigDecimal longitude
    String link
    Image image

    static constraints = {
        city nullable: false
        image nullable: true
    }
}
