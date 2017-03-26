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

    def create() {
        respond new City(params)
    }

    @Transactional
    def save(City cityInstance) {
        if (cityInstance == null) {
            notFound()
            return
        }
        if(params.imageFile){
            if(request instanceof MultipartHttpServletRequest)
            {
                MultipartHttpServletRequest mpr = (MultipartHttpServletRequest)request
                CommonsMultipartFile downloadedFile = (CommonsMultipartFile) mpr.getFile("imageFile")
                String fileUploaded = fileUploadService.uploadFile( downloadedFile, params.imageFile.fileItem.fileName, "images/cities/" )
                cityInstance.image = params.imageFile.fileItem.fileName.toString()
                cityInstance.validate()
            }
        }

        if (cityInstance.hasErrors()) {
            respond cityInstance.errors, view:'create'
            return
        }

        cityInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'city.label', default: 'City'), cityInstance.id])
                redirect cityInstance
            }
            '*' { respond cityInstance, [status: CREATED] }
        }
    }

    def edit(City cityInstance) {
        respond cityInstance
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
                redirect cityInstance
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
