package tripswebapp.model

import grails.rest.Resource


@Resource(uri='/paths',  formats=['json', 'xml'])

class Path {

    String name
    Integer pathNumber

    static constraints = {

    }
}
