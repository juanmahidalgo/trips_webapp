class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }
        "/cities"(resources:'city'){
            "/attractions"(resources:"attraction")
        }
        "/attractions"(resources:'attraction'){
            "/reviews"(resources:"review")
        }
        "/reviews"(resources:'review')
        "/"(view:"/index")
        "500"(view:'/error')
	}
}
