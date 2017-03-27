package tripswebapp.media



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ImageController {

    static responseFormats = ['json', 'xml']
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Image.list(params), [status: OK]
    }

    @Transactional
    def save(Image imageInstance) {
        if (imageInstance == null) {
            render status: NOT_FOUND
            return
        }

        imageInstance.validate()
        if (imageInstance.hasErrors()) {
            render status: NOT_ACCEPTABLE
            return
        }

        imageInstance.save flush:true
        respond imageInstance, [status: CREATED]
    }

    @Transactional
    def update(Image imageInstance) {
        if (imageInstance == null) {
            render status: NOT_FOUND
            return
        }

        imageInstance.validate()
        if (imageInstance.hasErrors()) {
            render status: NOT_ACCEPTABLE
            return
        }

        imageInstance.save flush:true
        respond imageInstance, [status: OK]
    }

    @Transactional
    def delete(Image imageInstance) {

        if (imageInstance == null) {
            render status: NOT_FOUND
            return
        }

        imageInstance.delete flush:true
        render status: NO_CONTENT
    }
}
