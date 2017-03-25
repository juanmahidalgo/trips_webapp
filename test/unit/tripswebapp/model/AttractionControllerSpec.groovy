package tripswebapp.model



import grails.test.mixin.*
import spock.lang.*

@TestFor(AttractionController)
@Mock(Attraction)
class AttractionControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.attractionInstanceList
            model.attractionInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.attractionInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'POST'
            def attraction = new Attraction()
            attraction.validate()
            controller.save(attraction)

        then:"The create view is rendered again with the correct model"
            model.attractionInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            attraction = new Attraction(params)

            controller.save(attraction)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/attraction/show/1'
            controller.flash.message != null
            Attraction.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def attraction = new Attraction(params)
            controller.show(attraction)

        then:"A model is populated containing the domain instance"
            model.attractionInstance == attraction
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def attraction = new Attraction(params)
            controller.edit(attraction)

        then:"A model is populated containing the domain instance"
            model.attractionInstance == attraction
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'PUT'
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/attraction/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def attraction = new Attraction()
            attraction.validate()
            controller.update(attraction)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.attractionInstance == attraction

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            attraction = new Attraction(params).save(flush: true)
            controller.update(attraction)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/attraction/show/$attraction.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'DELETE'
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/attraction/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def attraction = new Attraction(params).save(flush: true)

        then:"It exists"
            Attraction.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(attraction)

        then:"The instance is deleted"
            Attraction.count() == 0
            response.redirectedUrl == '/attraction/index'
            flash.message != null
    }
}
