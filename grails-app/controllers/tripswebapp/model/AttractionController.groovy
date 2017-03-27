package tripswebapp.model

import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.commons.CommonsMultipartFile
import tripswebapp.FileUploadService
import tripswebapp.media.Image

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AttractionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "DELETE"]
    FileUploadService fileUploadService

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

    def manageImages(Attraction attractionInstance) {
        respond attractionInstance
    }

    @Transactional
    def deleteImage(){
        def attractionInstance = Attraction.get(params.id)
        def img = Image.get(params.imgId)
        attractionInstance.removeFromMaps(img)
        attractionInstance.save flush: true
        img.delete flush: true
        respond attractionInstance, view:'show'
    }

    @Transactional
    def uploadImage(Attraction attractionInstance){

        if (params.documentFile.fileItem.fileName) {
            if (request instanceof MultipartHttpServletRequest) {
                params.documentFile.each {
                    if (it.fileItem.fileName) {
                        MultipartHttpServletRequest mpr = (MultipartHttpServletRequest) request
                        CommonsMultipartFile downloadedFile = (CommonsMultipartFile) mpr.getFile(it.fileItem.fieldName)
                        String fileUploaded = fileUploadService.uploadFile(downloadedFile, it.fileItem.fileName, "images/maps/")
                        def image = new Image()
                        image.path = it.fileItem.fileName.toString()
                        image.save flush: true
                        if(params.typeOfFile == 'map'){
                            attractionInstance.addToMaps(image)
                        }
                        else{
                            attractionInstance.addToImages(image)
                        }
                        attractionInstance.save flush: true                    }
                }
            }
        }
        redirect(action: "list")

    }

    @Transactional
    def updateImages(Attraction attractionInstance) {
        if (params.documentFile) {
            if (request instanceof MultipartHttpServletRequest) {
                params.documentFile.each {
                    if (it.value.fileItem.fileName) {
                        MultipartHttpServletRequest mpr = (MultipartHttpServletRequest) request
                        CommonsMultipartFile downloadedFile = (CommonsMultipartFile) mpr.getFile(it.value.fileItem.fieldName)
                        String fileUploaded = fileUploadService.uploadFile(downloadedFile, it.value.fileItem.fileName, "images/maps/")
                        def image = new Image()
                        image.path = it.value.fileItem.fileName.toString()
                        image.save flush: true
                        attractionInstance.addToMaps(image)
                    }
                }
            }
        }
        attractionInstance.save flush:true
        respond attractionInstance, view:'show'
    }

    @Transactional
    def save(Attraction attractionInstance) {
        if (attractionInstance == null) {
            notFound()
            return
        }

        if(params.documentFile){
            if(request instanceof MultipartHttpServletRequest)
            {
                params.documentFile.each {
                    if(it.value.fileItem.fileName){
                        MultipartHttpServletRequest mpr = (MultipartHttpServletRequest)request
                        CommonsMultipartFile downloadedFile = (CommonsMultipartFile) mpr.getFile(it.value.fileItem.fieldName)
                        String fileUploaded = fileUploadService.uploadFile( downloadedFile, it.value.fileItem.fileName, "images/maps/" )
                        def image = new Image()
                        image.path = it.value.fileItem.fileName.toString()
                        image.save flush:true
                        attractionInstance.addToMaps(image)
                    }
                }
            }
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

        if(params.documentFile){
            if(request instanceof MultipartHttpServletRequest)
            {
                params.documentFile.each {
                    if(it.value.fileItem.fileName){
                        MultipartHttpServletRequest mpr = (MultipartHttpServletRequest)request
                        CommonsMultipartFile downloadedFile = (CommonsMultipartFile) mpr.getFile(it.value.fileItem.fieldName)
                        String fileUploaded = fileUploadService.uploadFile( downloadedFile, it.value.fileItem.fileName, "images/maps/" )
                        def image = new Image()
                        image.path = it.value.fileItem.fileName.toString()
                        image.save flush:true
                        attractionInstance.addToMaps(image)
                    }
                }
            }
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
