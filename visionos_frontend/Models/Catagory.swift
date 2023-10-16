//
//  Catagory.swift
//  visionos_frontend
//
//  Created by Abir Pal on 13/10/23.
//

import Foundation

struct Catagory: Identifiable {
    var id = UUID()
    var image: String
    var title: String
}

let catagory : [Catagory] = [
    Catagory(image: "image1", title: "Design"),
    .init(image: "image2", title: "Development"),
    Catagory(image: "image3", title: "Marketing"),
    Catagory(image: "image4", title: "IT and Software"),
    Catagory(image: "image5", title: "Personal Development"),
    Catagory(image: "image6", title: "Business"),
    Catagory(image: "image7", title: "Photography"),
    Catagory(image: "image8", title: "Music"),

]
