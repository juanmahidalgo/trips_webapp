package tripswebapp.model

import grails.converters.JSON
import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.commons.CommonsMultipartFile
import tripswebapp.FileUploadService
import tripswebapp.media.Image

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional



@Transactional(readOnly = true)
class CityController {

    FileUploadService fileUploadService
    //static responseFormats = ['json']
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond City.list(params), model:[cityInstanceCount: City.count()]
    }

    def show(City cityInstance) {
        respond cityInstance
    }

    def manageImages() {
        def cityInstance = City.get(params.id)

        respond cityInstance
    }

    def create() {
        respond new City(params)
    }

    @Transactional
    def save(City cityInstance) {
        if (cityInstance == null) {
            notFound()
            return
        }
        def country = Country.findByName(params.country)
        if(!country){
            country = new Country(name: params.country)
        }
        country.save flush: true
        cityInstance.country = country
        def exists = City.findByNameAndCountry(params.name, country)
        if(exists){
            flash.error = "Ya existe Una ciudad con ese nombre y el mismo país"
            redirect(action: "create")
            return
        }
        if(params.imageFile){
            if(request instanceof MultipartHttpServletRequest)
            {
                MultipartHttpServletRequest mpr = (MultipartHttpServletRequest)request
                CommonsMultipartFile downloadedFile = (CommonsMultipartFile) mpr.getFile("imageFile")
                String fileUploaded = fileUploadService.uploadFile( downloadedFile, params.imageFile.fileItem.fileName, "images/cities/" )
                def image = new Image()
                image.path =  params.imageFile.fileItem.fileName.toString()
                image.save flush: true
                cityInstance.image = image
                cityInstance.validate()
            }
        } else{
            cityInstance.image = null
        }

        if (cityInstance.hasErrors()) {
            respond cityInstance.errors, view:'create'
            return
        }

        cityInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'city.label', default: 'City'), cityInstance.id])
                redirect(action: "index")
            }
            '*' { respond cityInstance, [status: CREATED] }
        }
    }

    def edit(City cityInstance) {
        respond cityInstance
    }

    @Transactional
    def uploadImage(City cityInstance){
        def path = 'images/cities/'
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
                        cityInstance.image = image
                        cityInstance.save flush: true                    }
                }
            }
        }
        redirect(action: "show", id: cityInstance.id)
    }

    @Transactional
    def update(City cityInstance) {
        if (cityInstance == null) {
            notFound()
            return
        }

        if (cityInstance.hasErrors()) {
            respond cityInstance.errors, view:'edit'
            return
        }

        cityInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'City.label', default: 'City'), cityInstance.id])
                redirect(action: "list", params: params)
            }
            '*'{ respond cityInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(City cityInstance) {

        if (cityInstance == null) {
            notFound()
            return
        }

        cityInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'City.label', default: 'City'), cityInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'city.label', default: 'City'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
