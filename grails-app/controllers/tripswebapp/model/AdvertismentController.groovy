package tripswebapp.model

import grails.converters.JSON
import grails.plugins.rest.client.RestBuilder
import groovy.json.JsonBuilder
import groovy.json.JsonOutput
import groovyx.net.http.RESTClient
import org.codehaus.groovy.grails.web.json.JSONObject
import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.commons.CommonsMultipartFile
import tripswebapp.FileUploadService
import tripswebapp.media.Image
import groovyx.net.http.HTTPBuilder
import static groovyx.net.http.ContentType.*

import static groovyx.net.http.Method.GET
import static groovyx.net.http.Method.POST
import static groovyx.net.http.ContentType.TEXT



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

        def adv = [
                notification : [
                        body: 'hola',
                        title: 'hola',
                        icon: 'logo',
                        click_action: 'OPEN_ADVERTISING'
                ],
                data: [
                        add_id: '1'
                ],
                registration_id: 'ey_-qzhpyKM:APA91bG2GS5LKK8n4SoSLlVgMZEuBGpe8lPBIOeGdE2f1SWS7iQK3E8ht07GuKtYR9l8GMEzE0n6UY5S6Vc2ao9KzvkQhgpqCv0N71q5jUu13Z1XvXpRdbbzkTENh3w9_CNuNUflbH7j'
        ] as JSON //encode as JSON

        def jsonn = new JsonBuilder()

        def json2 = JsonOutput.toJson(notification: [body: 'hola', title: 'hola', icon: 'logo'], to: 'ey_-qzhpyKM:APA91bG2GS5LKK8n4SoSLlVgMZEuBGpe8lPBIOeGdE2f1SWS7iQK3E8ht07GuKtYR9l8GMEzE0n6UY5S6Vc2ao9KzvkQhgpqCv0N71q5jUu13Z1XvXpRdbbzkTENh3w9_CNuNUflbH7j')


        def string = "{'to':'ey_-qzhpyKM:APA91bG2GS5LKK8n4SoSLlVgMZEuBGpe8lPBIOeGdE2f1SWS7iQK3E8ht07GuKtYR9l8GMEzE0n6UY5S6Vc2ao9KzvkQhgpqCv0N71q5jUu13Z1XvXpRdbbzkTENh3w9_CNuNUflbH7' ,'notification':{'body':'chau','tittle':'hola','icon':'logo'}}"
        //JsonBuilder json = new groovy.json.JsonBuilder(adv)
        jsonn {
            to 'ey_-qzhpyKM:APA91bG2GS5LKK8n4SoSLlVgMZEuBGpe8lPBIOeGdE2f1SWS7iQK3E8ht07GuKtYR9l8GMEzE0n6UY5S6Vc2ao9KzvkQhgpqCv0N71q5jUu13Z1XvXpRdbbzkTENh3w9_CNuNUflbH7j'
        }

        def strfinal = '{\"notification\":{\"body\":\"hola\",\"tittle\":\"hola\",\"icon\":\"logo\"},\"to\":\"ey_-qzhpyKM:APA91bG2GS5LKK8n4SoSLlVgMZEuBGpe8lPBIOeGdE2f1SWS7iQK3E8ht07GuKtYR9l8GMEzE0n6UY5S6Vc2ao9KzvkQhgpqCv0N71q5jUu13Z1XvXpRdbbzkTENh3w9_CNuNUflbH7j\"}'

        def string2 = '{"notification":{"body":"hola","tittle":"hola","icon":"logo"},"to":"ey_-qzhpyKM:APA91bG2GS5LKK8n4SoSLlVgMZEuBGpe8lPBIOeGdE2f1SWS7iQK3E8ht07GuKtYR9l8GMEzE0n6UY5S6Vc2ao9KzvkQhgpqCv0N71q5jUu13Z1XvXpRdbbzkTENh3w9_CNuNUflbH7j"}'


        /*RESTClient restClient = new RESTClient("https://gcm-http.googleapis.com/gcm/send")
        def response = restClient.post(
                body: string,
                contentType: 'application/json'
        )*/

        /*def http = new HTTPBuilder( "https://gcm-http.googleapis.com/gcm/send" )
        http.setHeaders([Authorization: "key=AIzaSyCZgtai2IQgEKQopHC2afKkShY_sbT3J1E"])

        http.request( POST ) { req ->
            body = [
                    notification : [
                            body: 'hola',
                            title: 'hola',
                            icon: 'logo',
                            click_action: 'OPEN_ADVERTISING'
                    ],
                    data: [
                            add_id: '1'
                    ],
                    registration_id: 'ey_-qzhpyKM:APA91bG2GS5LKK8n4SoSLlVgMZEuBGpe8lPBIOeGdE2f1SWS7iQK3E8ht07GuKtYR9l8GMEzE0n6UY5S6Vc2ao9KzvkQhgpqCv0N71q5jUu13Z1XvXpRdbbzkTENh3w9_CNuNUflbH7j'
            ]
            requestContentType = URLENC
            response.success = { resp ->
                println "POST response status: ${resp.statusLine}"
                assert resp.statusLine.statusCode == 201
            }
        }
*/

        RestBuilder rest = new RestBuilder()
        def resp = rest.post("https://gcm-http.googleapis.com/gcm/send") {
            header 'Authorization', 'key=AIzaSyCZgtai2IQgEKQopHC2afKkShY_sbT3J1E'
            contentType 'application/json'
            body string2
        }
        return resp

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

        advertismentInstance.latitude = params.latitude.toBigDecimal()
        advertismentInstance.longitude = params.longitude.toBigDecimal()

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
