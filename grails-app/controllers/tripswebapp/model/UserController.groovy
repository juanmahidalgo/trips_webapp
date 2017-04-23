package tripswebapp.model

import groovy.json.JsonSlurper

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class UserController {

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond User.list(params), model:[userInstanceCount: User.count()]
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def users
        if(params.filterBy == 'name' && params.filter){
            users = User.findAllByName(params.filter)
        }
        else if(params.filterBy == 'id' && params.filter){
            users = Attraction.find(params.filter)
        }
        else{
            users= User.list(params)
        }
        render(view: "list", model: [users: users, userInstanceCount: User.count()])
    }

    @Transactional
    def login(params){
        def jsonSlurper = new JsonSlurper()
        def status
        def body = jsonSlurper.parseText(request.reader.text)
        def user = User.findByFbId(body.id)
        if(user){
            status = 200
        }else{
            user = new User(body)
            user.fbId = body.id
            user.password = ''
            user.blocked = false
            user.save flush: true
            status= 201
            if(!user)
                status = 404
        }
        render(status: status, text: user)
    }

    @Transactional
    def blockUser(Long id){
        def userInstance = User.find(id)
        userInstance.blocked = true
        userInstance.save flush: true
        redirect action:"list"
    }

    def show(User userInstance) {
        respond userInstance
    }

    def create() {
        respond new User(params)
    }

    @Transactional
    def save(User userInstance) {
        if (userInstance == null) {
            notFound()
            return
        }

        if (userInstance.hasErrors()) {
            respond userInstance.errors, view:'create'
            return
        }

        userInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
                redirect userInstance
            }
            '*' { respond userInstance, [status: CREATED] }
        }
    }

    def edit(User userInstance) {
        respond userInstance
    }

    @Transactional
    def update(User userInstance) {
        if (userInstance == null) {
            notFound()
            return
        }

        if (userInstance.hasErrors()) {
            respond userInstance.errors, view:'edit'
            return
        }

        userInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'User.label', default: 'User'), userInstance.id])
                redirect userInstance
            }
            '*'{ respond userInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(User userInstance) {

        if (userInstance == null) {
            notFound()
            return
        }

        userInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'User.label', default: 'User'), userInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
