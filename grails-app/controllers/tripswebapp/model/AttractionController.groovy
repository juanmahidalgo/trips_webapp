package tripswebapp.model

import grails.converters.JSON
import groovy.json.JsonBuilder
import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.commons.CommonsMultipartFile
import tripswebapp.FileUploadService
import tripswebapp.media.AudioGuide
import tripswebapp.media.Image
import tripswebapp.media.Video
import tripswebapp.utils.Classification

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AttractionController {

    FileUploadService fileUploadService

    def stats(){
        def counterDic = [:]
        Fav.findAll().each() { def fav ->
            if(!counterDic[fav.stop.name as String] && fav.date > new Date()-365){
                counterDic[fav.stop.name as String] = 1
            } else if(counterDic[fav.stop.name as String] && fav.date > new Date()-365){
                counterDic[fav.stop.name as String] = counterDic[fav.stop.name as String].toLong() + 1
            }
        }
        def builder = new JsonBuilder()
        builder(counterDic)
        render(view: "stats", model: [book: counterDic])


    }

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

    def getMostFavs(){
        def counterDic = [:]
        Fav.findAll().each() { def fav ->
            if(!counterDic[fav.stop.name as String] && fav.date > new Date()-365){
                counterDic[fav.stop.name as String] = 1
            } else if(counterDic[fav.stop.name as String] && fav.date > new Date()-365){
                counterDic[fav.stop.name as String] = counterDic[fav.stop.name as String].toLong() + 1
            }
        }
        counterDic.sort {it.value}
        def i = 0
        def newDic = [:]
        counterDic.each() {
            if(i<10){
                newDic[it] = it.value
            }
            i++
        }
        def builder = new JsonBuilder()
        builder(newDic)
        respond builder, [formats:['json']]
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
        else if(params.filterBy == 'name' && params.filter) {
            attractions = Attraction.findAllByName(params.filter)
        }
        else if(params.filterBy == 'description' && params.filter){
            attractions = Attraction.findAllByDescription(params.filter)
        }
        else if(params.filterBy == 'classification' && params.filter){
            attractions = Attraction.findAllByClassification(Classification.findByName(params.filter))
        }
        else if(params.filterBy == 'NonTranslated'){
            def filtered = []
            def total = Attraction.findAll()
            total.each(){ def a ->
                if(a.traductions.size() < Language.findAll().size()-1){
                    filtered.add(a)
                }
            }
            attractions = filtered
        }
        else{
            attractions = Attraction.list(params)
        }
        respond attractions, model:[attractionInstanceCount: Attraction.count()]
    }

    def show(Attraction attractionInstance) {
        if(params.lang){
            def lang = Language.findByCode(params.lang)
            def trad = StopTraduction.findByStopAndLang(attractionInstance, lang)
            if(!trad){
                respond attractionInstance
                return
            }
            attractionInstance.description = trad.description
            attractionInstance.audioGuides = []
            attractionInstance.audioGuides.add(trad.audioGuide)
            attractionInstance.pointsOfInterest.each() { def point ->
                def pointTrad = PointTraduction.findByPointAndLang(point, lang)
                if(pointTrad){
                    point.description = pointTrad.description
                    point.audioGuide = pointTrad.audioGuide
                }
            }
        }
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
        if (params.documentFile.fileItem?.fileName) {
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
    def uploadVideo(Attraction attractionInstance){
        def path = 'videos/'
        if(params.typeOfFile == 'image'){
            path = 'images/attractions'
        }
        if (params.documentFile.fileItem?.fileName) {
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
    def save(Attraction attractionInstance) {
        if (attractionInstance == null) {
            notFound()
            return
        }
        attractionInstance.latitude = params.latitude.toBigDecimal()
        attractionInstance.longitude = params.longitude.toBigDecimal()

        if(params.imageFile?.size>0){
            if(params.imageFile?.size> 10000000){
                flash.error = "La imagen supera los 10mb permitidos"
                redirect(action: "create")
                return
            }
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

        if(params.mapFile?.size>0){
            if(params.mapFile?.size> 10000000){
                flash.error = "La imagen del mapa supera los 10mb permitidos"
                redirect(action: "create")
                return
            }
            if(request instanceof MultipartHttpServletRequest)
            {
                MultipartHttpServletRequest mpr = (MultipartHttpServletRequest)request
                CommonsMultipartFile downloadedFile = (CommonsMultipartFile) mpr.getFile("mapFile")
                String fileUploaded = fileUploadService.uploadFile( downloadedFile, params.mapFile.fileItem.fileName, "images/maps/" )
                def image = new Image()
                image.path =  params.mapFile.fileItem.fileName.toString()
                image.save flush: true
                attractionInstance.addToMaps(image)
            }
        }

        if(params.videoFile?.size>0){
            if(params.videFile?.size> 20000000){
                flash.error = "El video supera los 20mb permitidos"
                redirect(action: "create")
                return
            }
            if(request instanceof MultipartHttpServletRequest)
            {
                MultipartHttpServletRequest mpr = (MultipartHttpServletRequest)request
                CommonsMultipartFile downloadedFile = (CommonsMultipartFile) mpr.getFile("videoFile")
                String fileUploaded = fileUploadService.uploadFile( downloadedFile, params.videoFile.fileItem.fileName, "videos/" )
                def video = new Video()
                video.path =  params.videoFile.fileItem.fileName.toString()
                video.save flush: true
                attractionInstance.addToVideos(video)
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

        if (attractionInstance.hasErrors()) {
            respond attractionInstance.errors, view:'create'
            return
        }

        attractionInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = attractionInstance.name + ' Creado / Actualizado'
                redirect(action: "list")
            }
            '*' { respond attractionInstance, [status: CREATED] }
        }
    }

    def edit(Attraction attractionInstance) {
        respond attractionInstance
    }

    @Transactional
    def saveTraduction(Attraction attractionInstance){
        def traduction
        if(params.traduction_id){
            traduction = StopTraduction.get(params.traduction_id)
            flash.message = "Traducción en " + traduction.lang.name + " modificada"

        }
        else{
            traduction = new StopTraduction()
            traduction.lang = Language.findById(params.language.id)
            flash.message = "Traducción en " + traduction.lang.name + " creada"
        }
        traduction.description = params.descripcion
        traduction.stop = attractionInstance
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
        attractionInstance.addToTraductions(traduction)
        attractionInstance.save flush:true
        redirect(action: "edit", id: attractionInstance.id)
    }

    def loadTraduction() {
        def attractionInstance = Attraction.get(params.id)
        def traductionInstance
        if(params.traductionId){
            traductionInstance = StopTraduction.get(params.traductionId)
        }
        respond attractionInstance, model:[traductionInstance: traductionInstance]
    }

    @Transactional
    def deleteAtracction(Long id){
        def attractionInstance = Attraction.findById(id)
        if(attractionInstance.reviews){
            attractionInstance.reviews.each(){
                attractionInstance.removeFromReviews(it)
                it.delete flush: true
            }
        }
        flash.message =  attractionInstance.name + ' Borrada'
        attractionInstance.delete flush:true
        redirect action:"list"
    }

    @Transactional
    def update(Attraction attractionInstance) {
        if (attractionInstance == null) {
            notFound()
            return
        }

        attractionInstance.latitude = params.latitude.toBigDecimal()
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

        if(attractionInstance.reviews){
            attractionInstance.reviews.each(){
                it.delete flush: true
            }
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
