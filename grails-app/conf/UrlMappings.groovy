class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }
        "/user/login"(parseRequest:false){
            controller = "user"
            action = "login"
        }
        "/user/fav"(controller: "user", parseRequest: false) {
            action = [GET: "getFavourites", POST: "addFavourite"]
        }

        /*"/user/fav"(parseRequest:false){
            controller = "user"
            action = "addFavourite"
        }*/
        "/user/favs"(parseRequest:false){
            controller = "user"
            action = "addFavourite"
        }
        "/cities"(resources:'city'){
            "/attractions"(resources:"attraction")
        }
        "/attractions"(resources:'attraction'){
            "/reviews"(resources:"review")
        }
        "/reviews"(resources:'review')
        "/reviews"
        "/users"(resources:'user')
        "/"(view:"/index")
        "500"(view:'/error')
	}
}
