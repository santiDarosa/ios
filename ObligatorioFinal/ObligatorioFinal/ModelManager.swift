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
    public static var staticBandsConcerts:[Concert] = []
    public static var dictionaryBands = Dictionary<Int, Band>()
    public static var favoriteBands:[Band] = []
    public static var dictionaryFavoriteBands = Dictionary<Int, Band>()
    //Controla repetidos
    private static var dictionaryTotal = Dictionary<String, Int>()
    
    
    public static func searchData(nameBand: String) -> [Band]{
        var myBands: [Band] = []
        var myBand: Band? = nil
        
        if let path = Bundle.main.path(forResource: "project", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>,
                    let bands = jsonResult["bands"] as? [Dictionary<String, AnyObject>],
                    let concerts = jsonResult["concerts"] as? [Dictionary<String, AnyObject>],
                    let members = jsonResult["members"] as? [Dictionary<String, AnyObject>],
                    let songs = jsonResult["songs"] as? [Dictionary<String, AnyObject>]{
                    for band in bands{
                        if band["name_band"] as! String == nameBand{
                            if dictionaryBands[band["id_band"] as! Int] != nil{
                                return [dictionaryBands[band["id_band"] as! Int]!]
                            } else{
                                myBand = Band(id: band["id_band"] as! Int, name: band["name_band"] as! String, image: band["image_band"] as! String, gender: band["gender"] as! String)
                                myBands.append(myBand!)
                                staticBands.append(myBand!)
                                dictionaryBands.updateValue(myBand!, forKey: myBand!.idBand)
                            }
                        }
                    }
                    if let myBand = myBand{
                        for concert in concerts{
                            if myBand.idBand == concert["id_band"] as! Int && dictionaryTotal[concert["title"] as! String] != 1{
                                let finalConcert = Concert(title: concert["title"] as! String, locationName: concert["location_name"] as! String, coordinate: CLLocationCoordinate2D(latitude: (concert["location"]!)["lat"] as! Double,longitude: (concert["location"]!)["lon"] as! Double), dateConcert: Utils.date(from: (concert["date"] as! String))!, price: concert["price"] as! Int, provider: Provider(name: (concert["provider"]!)["name"] as! String,url: (concert["provider"]!)["url"] as! String), bandId: concert["id_band"] as! Int)
                                myBand.addConcert(concert: finalConcert)
                                dictionaryTotal.updateValue(1, forKey: finalConcert.title!)
                            }
                        }
                        for member in members{
                            if myBand.idBand == member["id_band"] as! Int && dictionaryTotal[member["member_name"] as! String] != 1{
                                let finalMember = Member(idBand: member["id_band"] as! Int, name: member["member_name"] as! String , photo: member["member_photo"] as! String, instrument: member["member_instrument"] as! String)
                                myBand.addMember(member: finalMember)
                                dictionaryTotal.updateValue(1, forKey: finalMember.memberName)
                            }
                        }
                        for song in songs{
                            if myBand.idBand == song["id_band"] as! Int && dictionaryTotal[song["song_name"] as! String] != 1{
                                let finalSong = Song(idBand: song["id_band"] as! Int, name: song["song_name"] as! String , url: song["song_url"] as! String)
                                myBand.addSong(song: finalSong)
                                dictionaryTotal.updateValue(1, forKey: finalSong.songName)
                            }
                        }
                    }else{
                        return myBands
                    }
                }
            } catch {
                // handle error
            }
        }
        return myBands
    }
    
    public static func searchData(genderBand: String) -> [Band]{
        var myBand: Band? = nil
        var myBands: [Band] = []
        var myDiccBands = Dictionary<Int, Band>()
        
        if let path = Bundle.main.path(forResource: "project", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>,
                    let bands = jsonResult["bands"] as? [Dictionary<String, AnyObject>],
                    let concerts = jsonResult["concerts"] as? [Dictionary<String, AnyObject>],
                    let members = jsonResult["members"] as? [Dictionary<String, AnyObject>],
                    let songs = jsonResult["songs"] as? [Dictionary<String, AnyObject>]{
                    for band in bands{
                        if band["gender"] as! String == genderBand{
                            if dictionaryBands[band["id_band"] as! Int] != nil{
                                myBand = (dictionaryBands[band["id_band"] as! Int]!)
                                myBands.append(myBand!)
                                myDiccBands.updateValue(myBand!, forKey: myBand!.idBand)
                            } else{
                                myBand = Band(id: band["id_band"] as! Int, name: band["name_band"] as! String, image: band["image_band"] as! String, gender: band["gender"] as! String)
                                myBands.append(myBand!)
                                staticBands.append(myBand!)
                                dictionaryBands.updateValue(myBand!, forKey: myBand!.idBand)
                                myDiccBands.updateValue(myBand!, forKey: myBand!.idBand)
                            }
                        }
                    }
                    for concert in concerts{
                        
                        if myDiccBands[concert["id_band"] as! Int] != nil && dictionaryTotal[concert["title"] as! String] != 1{
                            myBand = myDiccBands[concert["id_band"] as! Int]
                                let finalConcert = Concert(title: concert["title"] as! String, locationName: concert["location_name"] as! String, coordinate: CLLocationCoordinate2D(latitude: (concert["location"]!)["lat"] as! Double,longitude: (concert["location"]!)["lon"] as! Double), dateConcert: Utils.date(from: (concert["date"] as! String))!, price: concert["price"] as! Int, provider: Provider(name: (concert["provider"]!)["name"] as! String,url: (concert["provider"]!)["url"] as! String), bandId: concert["id_band"] as! Int)
                            myBand?.addConcert(concert: finalConcert)
                            dictionaryTotal.updateValue(1, forKey: finalConcert.title!)
                            }
                        }
                        for member in members{
                            if myDiccBands[member["id_band"] as! Int] != nil && dictionaryTotal[member["member_name"] as! String] != 1{
                                myBand = myDiccBands[member["id_band"] as! Int]
                                let finalMember = Member(idBand: member["id_band"] as! Int, name: member["member_name"] as! String , photo: member["member_photo"] as! String, instrument: member["member_instrument"] as! String)
                                myBand?.addMember(member: finalMember)
                                dictionaryTotal.updateValue(1, forKey: finalMember.memberName)
                            }
                        }
                        for song in songs{
                            if myDiccBands[song["id_band"] as! Int] != nil && dictionaryTotal[song["song_name"] as! String] != 1{
                                myBand = myDiccBands[song["id_band"] as! Int]
                                let finalSong = Song(idBand: song["id_band"] as! Int, name: song["song_name"] as! String , url: song["song_url"] as! String)
                                myBand?.addSong(song: finalSong)
                                dictionaryTotal.updateValue(1, forKey: finalSong.songName)
                            }
                        }
                    
                }
            } catch {
                // handle error
            }
        }
        return myBands
    }
    
    public static func addData(){
        
        if let path = Bundle.main.path(forResource: "project", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let bands = jsonResult["bands"] as? [Dictionary<String, AnyObject>],
                let concerts = jsonResult["concerts"] as? [Dictionary<String, AnyObject>],
                let members = jsonResult["members"] as? [Dictionary<String, AnyObject>],
                let songs = jsonResult["songs"] as? [Dictionary<String, AnyObject>]{
                    for band in bands{
                        let finalBand = Band(id: band["id_band"] as! Int, name: band["name_band"] as! String, image: band["image_band"] as! String, gender: band["gender"] as! String)
                        staticBands.append(finalBand)
                        dictionaryBands.updateValue(finalBand, forKey: finalBand.idBand)
                    }
                    for concert in concerts{
                        let finalConcert = Concert(title: concert["title"] as! String, locationName: concert["location_name"] as! String, coordinate: CLLocationCoordinate2D(latitude: (concert["location"]!)["lat"] as! Double,longitude: (concert["location"]!)["lon"] as! Double), dateConcert: Utils.date(from: (concert["date"] as! String))!, price: concert["price"] as! Int, provider: Provider(name: (concert["provider"]!)["name"] as! String,url: (concert["provider"]!)["url"] as! String), bandId: concert["id_band"] as! Int)
                        let concertBand = dictionaryBands[finalConcert.bandId]
                        concertBand?.addConcert(concert: finalConcert)
                    }
                    for member in members{
                        let finalMember = Member(idBand: member["id_band"] as! Int, name: member["member_name"] as! String , photo: member["member_photo"] as! String, instrument: member["member_instrument"] as! String)
                        let memberBand = dictionaryBands[finalMember.idBand]
                        memberBand?.addMember(member: finalMember)
                    }
                    for song in songs{
                        let finalSong = Song(idBand: song["id_band"] as! Int, name: song["song_name"] as! String , url: song["song_url"] as! String)
                        let songBand = dictionaryBands[finalSong.idBand]
                        songBand?.addSong(song: finalSong)
                    }
                }
                else{
                    print("no anda")
                }
            } catch {
                // handle error
            }
        }
    }
}
