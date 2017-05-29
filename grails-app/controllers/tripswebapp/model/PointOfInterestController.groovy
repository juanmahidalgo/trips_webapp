package tripswebapp.model

import grails.converters.JSON
import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.commons.CommonsMultipartFile
import tripswebapp.FileUploadService
import tripswebapp.media.AudioGuide
import tripswebapp.media.Image

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PointOfInterestController {

    FileUploadService fileUploadService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond PointOfInterest.list(params), model:[pointOfInterestInstanceCount: PointOfInterest.count()]
    }

    def show(PointOfInterest pointOfInterestInstance) {
        respond pointOfInterestInstance
    }

    def create() {
        respond new PointOfInterest(params)
    }

    def loadTraduction() {
        def pointOfInterestInstance = PointOfInterest.get(params.id)
        def traductionInstance
        if(params.traductionId){
            traductionInstance = PointTraduction.get(params.traductionId)
        }
        respond pointOfInterestInstance, model:[traductionInstance: traductionInstance]
    }

    @Transactional
    def saveTraduction(PointOfInterest pointInstance){
        def traduction
        if(params.traduction_id){
            traduction = PointTraduction.get(params.traduction_id)
            flash.message = "Traducción en " + traduction.lang.name + " modificada"
        }
        else{
            traduction = new PointTraduction()
            traduction.lang = Language.findById(params.language.id)
            flash.message = "Traducción en " + traduction.lang.name + " creada"
        }
        traduction.description = params.descripcion
        traduction.point = pointInstance
        if(params.audioGuideFile?.size>0){
            if(request instanceof MultipartHttpServletRequest)
            {
                MultipartHttpServletRequest mpr = (MultipartHttpServletRequest)request
                CommonsMultipartFile downloadedFile = (CommonsMultipartFile) mpr.getFile("audioGuideFile")
                String fileUploaded = fileUploadService.uploadFile( downloadedFile, params.audioGuideFile.fileItem.fileName, "audios/" )
                def audioGuide = new AudioGuide()
                audioGuide.path =  params.audioGuideFile.fileItem.fileName.toString()
                audioGuide.save flush: true
                traduction.audioGuide = audioGuide
            }
        }
        traduction.save flush:true
        pointInstance.addToTraductions(traduction)
        pointInstance.save flush:true
        redirect(action: "edit", id: pointInstance.id)
    }

    @Transactional
    def savePoint(PointOfInterest pointOfInterestInstance) {

        pointOfInterestInstance.attraction = Attraction.get(params.attractionId)
        if (pointOfInterestInstance == null) {
            notFound()
            return
        }

        if(params.imageFile?.size>0){
            if(params.imageFile?.size> 10000000){
                flash.error = "La imagen supera los 10mb permitidos"
                respond pointOfInterestInstance, [status: 500]
                return
            }
            if(request instanceof MultipartHttpServletRequest)
            {
                MultipartHttpServletRequest mpr = (MultipartHttpServletRequest)request
                CommonsMultipartFile downloadedFile = (CommonsMultipartFile) mpr.getFile("imageFile")
                String fileUploaded = fileUploadService.uploadFile( downloadedFile, params.imageFile.fileItem.fileName, "images/pointsofinterest/" )
                def image = new Image()
                image.path =  params.imageFile.fileItem.fileName.toString()
                image.save flush: true
                pointOfInterestInstance.image = image
            }
        }

        if(params.audioGuideFile?.size>0){
            if(params.imageFile?.size> 10000000){
                flash.error = "La audioguia supera los 10mb permitidos"
                respond pointOfInterestInstance, [status: 500]
                return
            }
            if(request instanceof MultipartHttpServletRequest)
            {
                MultipartHttpServletRequest mpr = (MultipartHttpServletRequest)request
                CommonsMultipartFile downloadedFile = (CommonsMultipartFile) mpr.getFile("audioGuideFile")
                String fileUploaded = fileUploadService.uploadFile( downloadedFile, params.audioGuideFile.fileItem.fileName, "audios/" )
                def audioGuide = new AudioGuide()
                audioGuide.path =  params.audioGuideFile.fileItem.fileName.toString()
                audioGuide.save flush: true
                pointOfInterestInstance.audioGuide = audioGuide
            }
        }
        pointOfInterestInstance.validate()
        pointOfInterestInstance.save flush:true

        if (pointOfInterestInstance.hasErrors()) {
            respond pointOfInterestInstance.errors, view:'create'
            return
        }

        pointOfInterestInstance.attach()
        response.status = 200
        render(pointOfInterestInstance as JSON)

    }

    @Transactional
    def deletePoint(){
        def point = PointOfInterest.get((params.id).toLong())
        point.delete flush:true
        response.status = 200
        render status: NO_CONTENT
    }

    @Transactional
    def save(PointOfInterest pointOfInterestInstance) {
        if (pointOfInterestInstance == null) {
            notFound()
            return
        }

        if (pointOfInterestInstance.hasErrors()) {
            respond pointOfInterestInstance.errors, view:'create'
            return
        }

        if(params.imageFile?.size>0){
            if(request instanceof MultipartHttpServletRequest)
            {
                MultipartHttpServletRequest mpr = (MultipartHttpServletRequest)request
                CommonsMultipartFile downloadedFile = (CommonsMultipartFile) mpr.getFile("imageFile")
                String fileUploaded = fileUploadService.uploadFile( downloadedFile, params.imageFile.fileItem.fileName, "images/attractions/" )
                def image = new Image()
                image.path =  params.imageFile.fileItem.fileName.toString()
                image.save flush: true
                attractionInstance.addToImages(image)
            }
        }

        if(params.audioGuideFile?.size>0){
            if(request instanceof MultipartHttpServletRequest)
            {
                MultipartHttpServletRequest mpr = (MultipartHttpServletRequest)request
                CommonsMultipartFile downloadedFile = (CommonsMultipartFile) mpr.getFile("audioGuideFile")
                String fileUploaded = fileUploadService.uploadFile( downloadedFile, params.audioGuideFile.fileItem.fileName, "audios/" )
                def audioGuide = new AudioGuide()
                audioGuide.path =  params.audioGuideFile.fileItem.fileName.toString()
                audioGuide.save flush: true
                attractionInstance.addToAudioGuides(audioGuide)
            }
        }

        pointOfInterestInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'pointOfInterest.label', default: 'PointOfInterest'), pointOfInterestInstance.id])
                redirect pointOfInterestInstance
            }
            '*' { respond pointOfInterestInstance, [status: CREATED] }
        }
    }

    def edit(PointOfInterest pointOfInterestInstance) {
        respond pointOfInterestInstance
    }

    @Transactional
    def update(PointOfInterest pointOfInterestInstance) {
        if (pointOfInterestInstance == null) {
            notFound()
            return
        }

        if (pointOfInterestInstance.hasErrors()) {
            respond pointOfInterestInstance.errors, view:'edit'
            return
        }

        pointOfInterestInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'PointOfInterest.label', default: 'PointOfInterest'), pointOfInterestInstance.id])
                redirect pointOfInterestInstance
            }
            '*'{ respond pointOfInterestInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(PointOfInterest pointOfInterestInstance) {

        if (pointOfInterestInstance == null) {
            notFound()
            return
        }

        pointOfInterestInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'PointOfInterest.label', default: 'PointOfInterest'), pointOfInterestInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'pointOfInterest.label', default: 'PointOfInterest'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
