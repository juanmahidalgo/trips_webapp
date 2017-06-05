package tripswebapp.model

import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.commons.CommonsMultipartFile
import tripswebapp.media.Image

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class RouteController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Route.list(params), model:[routeInstanceCount: Route.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def routes
        if(params.filterBy == 'name' && params.filter){
            routes = Route.findAllByName(params.filter)
        }
        else if(params.filterBy == 'id' && params.filter){
            routes = Route.get(params.filter)
        }
        else if(params.filterBy == 'city' && params.filter){
            routes = Route.findAllByCity(City.findByName(params.filter));
        }
        else{
            routes= Route.list(params)
        }
        render(view: "list", model: [routes: routes, routeInstanceCount: Route.count()])
    }

    def show(Route routeInstance) {
        respond routeInstance
    }

    def create() {
        def stops = Stop.findAllByCity(City.get(params.id))
        params.stops = stops
        params.city = City.get(params.id)
        respond new Route(params)
    }

    @Transactional
    def save(Route routeInstance) {
        routeInstance.stopsOrder = params.mydata.split(',')
        if (routeInstance == null) {
            notFound()
            return
        }

        /*if(params.imageFile?.size> 10000000){
            flash.error = "La imagen supera los 10mb permitidos"
            redirect(action: "create")
            return
        }

        if(params.imageFile?.size>0){
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
        }*/

        if (routeInstance.hasErrors()) {
            respond routeInstance.errors, view:'create'
            return
        }

        routeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = routeInstance.name + ' Creado '
                redirect(action: "list")
            }
            '*' { respond routeInstance, [status: CREATED] }
        }
    }

    def edit(Route routeInstance) {
        respond routeInstance
    }

    @Transactional
    def update(Route routeInstance) {
        if (routeInstance == null) {
            notFound()
            return
        }

        if (routeInstance.hasErrors()) {
            respond routeInstance.errors, view:'edit'
            return
        }

        routeInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = routeInstance.name + ' Creado '
                redirect(action: "list")
            }
            '*'{ respond routeInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Route routeInstance) {

        if (routeInstance == null) {
            notFound()
            return
        }

        routeInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Route.label', default: 'Route'), routeInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'route.label', default: 'Route'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
