package tripswebapp.model

import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.commons.CommonsMultipartFile
import tripswebapp.FileUploadService
import tripswebapp.media.Image

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AdvertismentController {

    FileUploadService fileUploadService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Advertisment.list(params), model:[advertismentInstanceCount: Advertisment.count()]
    }

    def show(Advertisment advertismentInstance) {
        respond advertismentInstance
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def ads
        if(params.filterBy == 'name' && params.filter){
            ads = Advertisment.findAllByTitle(params.filter)
        }
        else if(params.filterBy == 'id' && params.filter){
            ads = Advertisment.get(params.filter)
        }
        else if(params.filterBy == 'city' && params.filter){
            ads = Advertisment.findAllByCity(City.findByName(params.filter));
        }
        else{
            ads = Advertisment.list(params)
        }
        render(view: "list", model: [ads: ads, adsInstanceCount: Advertisment.count()])
    }

    def create() {
        respond new Advertisment(params)
    }

    def sendAdd(Long id ){
        def add = Advertisment.get(id)
    }

    @Transactional
    def save(Advertisment advertismentInstance) {
        if (advertismentInstance == null) {
            notFound()
            return
        }

        if (advertismentInstance.hasErrors()) {
            respond advertismentInstance.errors, view:'create'
            return
        }

        if(params.imageFile?.size> 10000000){
            flash.error = "La imagen supera los 10mb permitidos"
            redirect(action: "create")
            return
        }

        if(params.imageFile?.size>0){
            if(request instanceof MultipartHttpServletRequest)
            {
                MultipartHttpServletRequest mpr = (MultipartHttpServletRequest)request
                CommonsMultipartFile downloadedFile = (CommonsMultipartFile) mpr.getFile("imageFile")
                String fileUploaded = fileUploadService.uploadFile( downloadedFile, params.imageFile.fileItem.fileName, "images/ads/" )
                def image = new Image()
                image.path =  params.imageFile.fileItem.fileName.toString()
                image.save flush: true
                advertismentInstance.image = image
                advertismentInstance.validate()
            }
        } else{
            advertismentInstance.image = null
        }

        advertismentInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = advertismentInstance.title + ' Creado '
                redirect(action: "list")
            }
            '*' { respond advertismentInstance, [status: CREATED] }
        }
    }

    def edit(Advertisment advertismentInstance) {
        respond advertismentInstance
    }

    @Transactional
    def update(Advertisment advertismentInstance) {
        if (advertismentInstance == null) {
            notFound()
            return
        }

        if (advertismentInstance.hasErrors()) {
            respond advertismentInstance.errors, view:'edit'
            return
        }

        advertismentInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Advertisment.label', default: 'Advertisment'), advertismentInstance.id])
                redirect advertismentInstance
            }
            '*'{ respond advertismentInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Advertisment advertismentInstance) {

        if (advertismentInstance == null) {
            notFound()
            return
        }

        advertismentInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Advertisment.label', default: 'Advertisment'), advertismentInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'advertisment.label', default: 'Advertisment'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
