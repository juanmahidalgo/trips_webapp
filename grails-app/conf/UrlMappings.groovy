class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }
        "/cities"(resources:'city')

        "/"(view:"/index")
        "500"(view:'/error')
	}
}
