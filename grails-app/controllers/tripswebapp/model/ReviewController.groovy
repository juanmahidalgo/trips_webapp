package tripswebapp.model

import grails.rest.RestfulController

import java.sql.Timestamp

class ReviewController extends RestfulController {
    ReviewController () {
        super(Review)
    }
    def index(Integer max){
        params.max = Math.min(max ?: 10, 100)
        respond Review.list(params), model:[reviewInstanceCount: Review.count()]
    }

    def deleteReview(Long id) {
        def reviewInstance = Review.findById(id)
        flash.message =  'Reseña Borrada'
        reviewInstance.delete flush:true
        redirect action:"list"
    }

    def list() {
        try {
            params.max = params.max ?: 10
            def filterBy = params.filterBy
            def filter = params.filter
            def dt1 = new Date()
            def dt2 = new Date()
            def count
            def reviews
            if(params.filterBy){
                if(filterBy == 'stop'){
                    reviews = Review.findAll(params){
                        stop.name == filter
                    }
                }
                if(filterBy == 'city'){
                    reviews = Review.findAll(params){
                        stop.city.name == filter
                    }
                }
                if(filterBy == 'country'){
                    reviews = Review.findAll(params){
                        stop.city.country.name == filter
                    }
                }
                if(filterBy == 'author'){
                    reviews = Review.findAll(params){
                        author == filter
                    }
                }
                if(filterBy == 'text'){
                    reviews = Review.withCriteria {
                        ilike('text', '%' + filter + '%')
                    }
                }
                if(filterBy == 'score'){
                    reviews = Review.findAll(params){
                        score == filter
                    }
                }
                count = reviews.size()
            }
            else{
                reviews = Review.list(params)
                count = Review.count()
            }
            if (params.date1 && params.date2) {
                Date date1 = new Date(params.date1)
                Date date2 = new Date(params.date2)
                Timestamp tdt1 = new Timestamp(date1.getTime())
                Timestamp tdt2 = new Timestamp(date2.getTime())
                reviews = Review.findAll()
                reviews = reviews.findAll(){ def rev ->
                    rev.date > tdt1 & rev.date < tdt2
                }
            }
            render(view: 'list', model: [reviews: reviews, reviewInstanceCount: count, date1: params.date1, date2: params.date2])

        } catch(e) {
            println e
        }
    }
}