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

        "/user/$id/fav"(controller: "user", parseRequest: false){
            action = "getFavourites"
        }

        /*"/user/fav"(parseRequest:false){
            controller = "user"
            action = "addFavourite"
        }*/
        "/user/favs"(parseRequest:false){
            controller = "user"
            action = "addFavourite"
        }
        "/stats/favs"(parseRequest:false){
            controller = "attraction"
            action = "getMostFavs"
        }
        "/cities"(resources:'city'){
            "/attractions"(resources:"attraction")
            "/routes"(resources:"route")
        }
        "/attractions"(resources:'attraction'){
            "/reviews"(resources:"review")
        }
        "/reviews"(resources:'review')
        "/pointsofinteres"(resources:'pointofinterest')
        "/ads"(resources:'advertisment')
        "/routes"(resources:'route')
        "/reviews"
        "/users"(resources:'user')
        "/"(view:"/index")
        "500"(view:'/error')
	}
}
