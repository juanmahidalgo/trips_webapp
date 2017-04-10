package tripswebapp.model

import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.commons.CommonsMultipartFile
import tripswebapp.FileUploadService
import tripswebapp.media.Image

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AttractionController {

    FileUploadService fileUploadService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def attractions
        if(params.cityId){
            attractions = Attraction.findAllByCity(City.get(params.cityId))
        }
        else{
            attractions = Attraction.list(params)
        }
        respond attractions, model:[attractionInstanceCount: Attraction.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def attractions
        if(params.filterBy == 'city' && params.filter){
            attractions = Attraction.findAllByCity(City.findByName(params.filter))
        }
        else if(params.filterBy == 'country' && params.filter){
            def country = Country.findByName(params.filter)
            attractions = Attraction.findAllByCity(City.findByCountry(country))
        }
        else{
            attractions = Attraction.list(params)
        }
        respond attractions, model:[attractionInstanceCount: Attraction.count()]
    }

    def show(Attraction attractionInstance) {
        respond attractionInstance
    }

    def create() {
        respond new Attraction(params)
    }

    def manageImages() {
        def attractionInstance = Attraction.get(params.id)

        respond attractionInstance
    }

    @Transactional
    def deleteImage(){
        def attractionInstance = Attraction.get(params.id)
        def img = Image.get(params.imgId)
        if(img in attractionInstance.maps){
            attractionInstance.removeFromMaps(img)
        }
        else if(img in attractionInstance.images) {
            attractionInstance.removeFromImages(img)
        }
        attractionInstance.save flush: true
        img.delete flush: true

        redirect(action: "show", id: attractionInstance.id)
    }

    @Transactional
    def uploadImage(Attraction attractionInstance){
        def path = 'images/maps/'
        if(params.typeOfFile == 'image'){
            path = 'images/attractions'
        }
        if (params.documentFile.fileItem.fileName) {
            if (request instanceof MultipartHttpServletRequest) {
                params.documentFile.each {
                    if (it.fileItem.fileName) {
                        MultipartHttpServletRequest mpr = (MultipartHttpServletRequest) request
                        CommonsMultipartFile downloadedFile = (CommonsMultipartFile) mpr.getFile(it.fileItem.fieldName)
                        String fileUploaded = fileUploadService.uploadFile(downloadedFile, it.fileItem.fileName, path)
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
        redirect(action: "edit", id: attractionInstance.id)
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
                        attractionInstance.addToImages(image)
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
        attractionInstance.latitude = params.latitude.toBigDecimal()
        attractionInstance.longitude = params.longitude.toBigDecimal()

        if(params.imageFile?.size>0){
            if(request instanceof MultipartHttpServletRequest)
            {
                MultipartHttpServletRequest mpr = (MultipartHttpServletRequest)request
                CommonsMultipartFile downloadedFile = (CommonsMultipartFile) mpr.getFile("imageFile")
                String fileUploaded = fileUploadService.uploadFile( downloadedFile, params.imageFile.fileItem.fileName, "images/cities/" )
                def image = new Image()
                image.path =  params.imageFile.fileItem.fileName.toString()
                image.save flush: true
                attractionInstance.addToImages(image)
            }
        }



        if (attractionInstance.hasErrors()) {
            respond attractionInstance.errors, view:'create'
            return
        }

        attractionInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = attractionInstance.name + ' Creado '
                redirect(action: "index")
            }
            '*' { respond attractionInstance, [status: CREATED] }
        }
    }

    def edit(Attraction attractionInstance) {
        respond attractionInstance
    }

    @Transactional
    def deleteAtracction(Long id){
        def attractionInstance = Attraction.findById(id)
        flash.message =  attractionInstance.name + ' Borrada'
        attractionInstance.delete flush:true
        redirect action:"index"
    }

    @Transactional
    def update(Attraction attractionInstance) {
        if (attractionInstance == null) {
            notFound()
            return
        }

a        attractionInstance.latitude = params.latitude.toBigDecimal()
        attractionInstance.longitude = params.longitude.toBigDecimal()

        if (attractionInstance.hasErrors()) {
            respond attractionInstance.errors, view:'edit'
            return
        }

        attractionInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = attractionInstance.name + ' Actualizada'
                redirect(action: "index")
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
