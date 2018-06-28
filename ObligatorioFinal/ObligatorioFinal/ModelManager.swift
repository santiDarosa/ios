//
//  ModelManager.swift
//  ObligatorioFinal
//
//  Created by SP 25 on 14/6/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import Foundation
import MapKit
import Firebase
import FirebaseDatabase


class ModelManager{
    public static var myBands:[Band] = []
    public static var myBandsConcerts:[Concert] = []
    
    
    public static func searchData(text: String){
        
    }
    
    public static func addData(){
        let band = Band(id: 0,name: "Green Day", image: "https://www.imer.mx/reactor/wp-content/uploads/sites/40/green-day-cr-frank-maddocks-2017-billboard-1548-1548x774.jpg", gender: "Punk Rock")
        
        let gdArg = Concert(title: "Green Day in Argentina", locationName: "Jose Amalfitani Stadium", coordinate: CLLocationCoordinate2D(latitude: -34.635538, longitude: -58.520868), dateConcert: Utils.date(from: "2018/11/10 21:00")!, price: 800, provider: Provider(name:"RedUTS",url:"reduts.com.uy"), bandId: 0)
        
        let gdBr = Concert(title: "Green Day in Brazil", locationName: "Beira Rio Stadium", coordinate: CLLocationCoordinate2D(latitude: -30.065671, longitude: -51.236062), dateConcert: Utils.date(from: "2018/11/13 21:00")!, price: 500, provider: Provider(name:"RedUTS",url:"reduts.com.uy"), bandId: 0)
        
        let gdUy = Concert(title: "Green Day in Uruguay", locationName: "Estadio Centenario", coordinate: CLLocationCoordinate2D(latitude: -34.894564, longitude: -56.152807), dateConcert: Utils.date(from: "2018/11/16 21:00")!, price: 1000, provider: Provider(name:"RedUTS",url:"reduts.com.uy"), bandId: 0)
        
        let bja = Member(name: "Billie Joe Armstrong", photo: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/RiP2013_GreenDay_Billie_Joe_Armstrong_0021.jpg/220px-RiP2013_GreenDay_Billie_Joe_Armstrong_0021.jpg", instrument: "Singer, Leader Guitar")
        let md = Member(name: "Mike Dirnt", photo: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/Mike_Dirnt_Oslo_2017.jpg/270px-Mike_Dirnt_Oslo_2017.jpg", instrument: "Bass")
        let tc = Member(name: "Tre Cool", photo: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5f/RiP2013_GreenDay_Tre_Cool_0002.jpg/260px-RiP2013_GreenDay_Tre_Cool_0002.jpg", instrument: "Drums")
        let jw = Member(name: "Jason White", photo: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/The_Big_Cats_in_Little_Rock_2008_1.jpg/250px-The_Big_Cats_in_Little_Rock_2008_1.jpg", instrument: "Rhytm Guitar")
        
        let ai = Song(name: "American Idiot", url: "https://www.youtube.com/watch?v=Ee_uujKuJMI")
        let jos = Song(name: "Jesus of Suburbia", url: "https://www.youtube.com/watch?v=lPLvBO_2Gn0")
        
        let red = Band(id: 1,name: "Los Redonditos de Ricota", image: "https://www.eldiario24.com/d24ar/fotos/notas/2016/10/05/384917_20161005103257.jpg", gender: "Punk Rock")
        
        let rdOl = Concert(title: "Patricio Rey en Olavarria", locationName: "Olavarria", coordinate: CLLocationCoordinate2D(latitude: -36.913350, longitude: -60.346776), dateConcert: Utils.date(from: "2018/11/21 20:00")!, price: 1200, provider: Provider(name:"RedUTS",url:"reduts.com.uy"), bandId: 1)
        
        let rdtn = Concert(title: "Patricio Rey en Tandil", locationName: "Tandil", coordinate: CLLocationCoordinate2D(latitude: -37.339361, longitude: -59.136522), dateConcert: Utils.date(from: "2018/12/21 21:30")!, price: 250, provider: Provider(name:"RedUTS",url:"reduts.com.uy"), bandId: 1)
        
        let rdnu = Concert(title: "Patricio Rey en el Monumental", locationName: "Monumental de Nunez", coordinate: CLLocationCoordinate2D(latitude: -34.545068, longitude: -58.449764), dateConcert: Utils.date(from: "2018/09/16 23:00")!, price: 700, provider: Provider(name:"RedUTS",url:"reduts.com.uy"), bandId: 1)
        
        let cis = Member(name: "Indio Solari", photo: "https://assets.diarioregistrado.com/media-photo_5b16eb6d03e8eb343c9fdd93_640w.jpeg", instrument: "Singer")
        let skay = Member(name: "Skay Bellinson", photo: "https://i.ytimg.com/vi/AzvGWogjpRY/hqdefault.jpg", instrument: "Guitar")
        
        let af = Song(name: "Un poco de amor frances", url: "https://www.youtube.com/watch?v=tMVSw2xS3sA")
        let lbp = Song(name: "La Bestia Pop", url: "https://www.youtube.com/watch?v=BRTQgZr633I")
        
        band.addConcert(concert: gdArg)
        band.addConcert(concert: gdBr)
        band.addConcert(concert: gdUy)
        
        band.addMember(member: bja)
        band.addMember(member: md)
        band.addMember(member: tc)
        band.addMember(member: jw)
        
        band.addSong(song: ai)
        band.addSong(song: jos)
        
        myBands.append(band)
        for concert in band.concertsBand{
            myBandsConcerts.append(concert)
        }
        
        red.addConcert(concert: rdnu)
        red.addConcert(concert: rdOl)
        red.addConcert(concert: rdtn)
        
        red.addMember(member: cis)
        red.addMember(member: skay)
        
        red.addSong(song: af)
        red.addSong(song: lbp)
        
        myBands.append(red)
        for concert in red.concertsBand{
            myBandsConcerts.append(concert)
        }
        
    }
    
}
