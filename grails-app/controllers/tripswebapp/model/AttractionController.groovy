package tripswebapp.model



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AttractionController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Attraction.list(params), model:[attractionInstanceCount: Attraction.count()]
    }

    def show(Attraction attractionInstance) {
        respond attractionInstance
    }

    def create() {
        respond new Attraction(params)
    }

    @Transactional
    def save(Attraction attractionInstance) {
        if (attractionInstance == null) {
            notFound()
            return
        }

        if (attractionInstance.hasErrors()) {
            respond attractionInstance.errors, view:'create'
            return
        }

        attractionInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'attraction.label', default: 'Attraction'), attractionInstance.id])
                redirect attractionInstance
            }
            '*' { respond attractionInstance, [status: CREATED] }
        }
    }

    def edit(Attraction attractionInstance) {
        respond attractionInstance
    }

    @Transactional
    def update(Attraction attractionInstance) {
        if (attractionInstance == null) {
            notFound()
            return
        }

        if (attractionInstance.hasErrors()) {
            respond attractionInstance.errors, view:'edit'
            return
        }

        attractionInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Attraction.label', default: 'Attraction'), attractionInstance.id])
                redirect attractionInstance
            }
            '*'{ respond attractionInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Attraction attractionInstance) {

        if (attractionInstance == null) {
            notFound()
            return
        }

        attractionInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Attraction.label', default: 'Attraction'), attractionInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'attraction.label', default: 'Attraction'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
