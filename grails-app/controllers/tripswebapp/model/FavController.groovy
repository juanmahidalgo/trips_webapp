package tripswebapp.model



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class FavController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Fav.list(params), model:[favInstanceCount: Fav.count()]
    }

    def show(Fav favInstance) {
        respond favInstance
    }

    def create() {
        respond new Fav(params)
    }

    @Transactional
    def save(Fav favInstance) {
        if (favInstance == null) {
            notFound()
            return
        }

        if (favInstance.hasErrors()) {
            respond favInstance.errors, view:'create'
            return
        }

        favInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'fav.label', default: 'Fav'), favInstance.id])
                redirect favInstance
            }
            '*' { respond favInstance, [status: CREATED] }
        }
    }

    def edit(Fav favInstance) {
        respond favInstance
    }

    @Transactional
    def update(Fav favInstance) {
        if (favInstance == null) {
            notFound()
            return
        }

        if (favInstance.hasErrors()) {
            respond favInstance.errors, view:'edit'
            return
        }

        favInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Fav.label', default: 'Fav'), favInstance.id])
                redirect favInstance
            }
            '*'{ respond favInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Fav favInstance) {

        if (favInstance == null) {
            notFound()
            return
        }

        favInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Fav.label', default: 'Fav'), favInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'fav.label', default: 'Fav'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
