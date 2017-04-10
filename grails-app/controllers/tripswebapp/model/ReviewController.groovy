package tripswebapp.model

import grails.rest.RestfulController

class ReviewController extends RestfulController {
    static responseFormats = ['json']
    ReviewController () {
        super(Review)
    }
}