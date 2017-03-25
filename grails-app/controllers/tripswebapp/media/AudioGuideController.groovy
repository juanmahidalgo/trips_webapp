package tripswebapp.media



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AudioGuideController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond AudioGuide.list(params), model:[audioGuideInstanceCount: AudioGuide.count()]
    }

    def show(AudioGuide audioGuideInstance) {
        respond audioGuideInstance
    }

    def create() {
        respond new AudioGuide(params)
    }

    @Transactional
    def save(AudioGuide audioGuideInstance) {
        if (audioGuideInstance == null) {
            notFound()
            return
        }

        if (audioGuideInstance.hasErrors()) {
            respond audioGuideInstance.errors, view:'create'
            return
        }

        audioGuideInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'audioGuide.label', default: 'AudioGuide'), audioGuideInstance.id])
                redirect audioGuideInstance
            }
            '*' { respond audioGuideInstance, [status: CREATED] }
        }
    }

    def edit(AudioGuide audioGuideInstance) {
        respond audioGuideInstance
    }

    @Transactional
    def update(AudioGuide audioGuideInstance) {
        if (audioGuideInstance == null) {
            notFound()
            return
        }

        if (audioGuideInstance.hasErrors()) {
            respond audioGuideInstance.errors, view:'edit'
            return
        }

        audioGuideInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'AudioGuide.label', default: 'AudioGuide'), audioGuideInstance.id])
                redirect audioGuideInstance
            }
            '*'{ respond audioGuideInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(AudioGuide audioGuideInstance) {

        if (audioGuideInstance == null) {
            notFound()
            return
        }

        audioGuideInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'AudioGuide.label', default: 'AudioGuide'), audioGuideInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'audioGuide.label', default: 'AudioGuide'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
