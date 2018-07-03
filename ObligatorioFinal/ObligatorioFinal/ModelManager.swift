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
    public static var staticBands:[Band] = []
    public static var staticBandsConcerts = Dictionary<Int, [Concert]>()
    public static var dictionaryBands = Dictionary<Int, Band>()
    public static var favoriteBands:[Band] = []
    public static var dictionaryFavoriteBands = Dictionary<Int, Band>()
    private static var dictionaryGender = Dictionary<String, [Band]>()
    
    
    public static func deleteFavoriteBand(band: Band){
        let idBand = band.idBand
        if dictionaryFavoriteBands[idBand] != nil{
            dictionaryFavoriteBands.removeValue(forKey: idBand)
        }
        if staticBandsConcerts[idBand] != nil{
            staticBandsConcerts.removeValue(forKey: idBand)
        }
        
    }
    public static func addFavoriteBand(band: Band){
        let idBand = band.idBand
        if dictionaryFavoriteBands[idBand] == nil{
            dictionaryFavoriteBands.updateValue(band, forKey: idBand)
            if band.concertsBand != []{
                staticBandsConcerts.updateValue(band.concertsBand, forKey: idBand)
            }
        }
    }
    
    public static func searchData(nameBand: String) -> [Band]{
        var myBands: [Band] = []
        for band in dictionaryBands.values{
            if band.nameBand.hasSuffix(nameBand){
                myBands.append(band)
            }
        }
        return myBands
    }
    
    public static func searchData(genderBand: String) -> [Band]?{
        return dictionaryGender[genderBand]
    }
    
    public static func searchData(){
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        var refHandle = ref.observe(DataEventType.value, with: { (snapshot) in
            let jsonResult = snapshot.value as? [String:NSArray] ?? [:]
            if let bands = jsonResult["bands"],
                let concerts = jsonResult["concerts"],
                let members = jsonResult["members"],
                let songs = jsonResult["songs"]{
                for band in bands{
                    let diccBand = band as! NSDictionary
                    let myBand = Band(id: diccBand["id_band"] as! Int, name: diccBand["name_band"] as! String, image: diccBand["image_band"] as! String, gender: diccBand["gender"] as! String)
                    staticBands.append(myBand)
                    dictionaryBands.updateValue(myBand, forKey: myBand.idBand)
                    if dictionaryGender[myBand.gender] != nil{
                        dictionaryGender[myBand.gender]?.append(myBand)
                    } else{
                        var genderBands : [Band] = []
                        genderBands.append(myBand)
                        dictionaryGender.updateValue(genderBands, forKey: myBand.gender)
                    }
                    
                }
                
                for concert in concerts{
                    let diccConcert = concert as! NSDictionary
                    let myBand = dictionaryBands[diccConcert["id_band"] as! Int]
                    if myBand != nil{
                        let finalConcert = Concert(title: diccConcert["title"] as! String, locationName: diccConcert["location_name"] as! String, coordinate: CLLocationCoordinate2D(latitude: (diccConcert["location"] as! NSDictionary)["lat"] as! Double,longitude: (diccConcert["location"] as! NSDictionary)["lon"] as! Double), dateConcert: Utils.date(from: (diccConcert["date"] as! String))!, price: diccConcert["price"] as! Int, provider: Provider(name: (diccConcert["provider"] as! NSDictionary)["name"] as! String,url: (diccConcert["provider"] as! NSDictionary)["url"] as! String), bandId: diccConcert["id_band"] as! Int)
                        myBand!.addConcert(concert: finalConcert)
                    }
                }
                for member in members{
                    let diccMember = member as! NSDictionary
                    let myBand = dictionaryBands[diccMember["id_band"] as! Int]
                    if myBand != nil{
                        let finalMember = Member(idBand: diccMember["id_band"] as! Int, name: diccMember["member_name"] as! String, photo: diccMember["member_photo"] as! String, instrument: diccMember["member_instrument"] as! String)
                        myBand!.addMember(member: finalMember)
                    }
                }
                for song in songs{
                    let diccSong = song as! NSDictionary
                    let myBand = dictionaryBands[diccSong["id_band"] as! Int]
                    if myBand != nil{
                        let finalSong = Song(idBand: diccSong["id_band"] as! Int, name: diccSong["song_name"] as! String , url: diccSong["song_url"] as! String)
                        myBand!.addSong(song: finalSong)
                    }
                }
                
                
            }
        })
        
    }
    
}
