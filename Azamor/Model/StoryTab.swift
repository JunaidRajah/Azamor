//
//  StoryTab.swift
//  Azamor
//
//  Created by Junaid Rajah on 2021/07/01.
//

import Foundation
import RealmSwift

class StoryTab: Object {
    @objc dynamic var StoryTabChapterName: String = ""
    @objc dynamic var StoryTabID: String = ""
    @objc dynamic var StoryTabDiscription: String = ""
    @objc dynamic var StoryTabBackgroundImageString: String = ""
    @objc dynamic var StoryTabMusicString: String = ""
    
    @objc dynamic var StoryTabMoveActive1: Bool = false
    @objc dynamic var StoryTabMoveID1: String = ""
    @objc dynamic var StoryTabMoveDiscription1: String = ""
    @objc dynamic var StoryTabMoveRequiresRoll1: Bool = false
    @objc dynamic var StoryTabMoveDC1: Int = 0
    @objc dynamic var StoryTabMoveType1: String = ""
    
    @objc dynamic var StoryTabMoveActive2: Bool = false
    @objc dynamic var StoryTabMoveID2: String = ""
    @objc dynamic var StoryTabMoveDiscription2: String = ""
    @objc dynamic var StoryTabMoveRequiresRoll2: Bool = false
    @objc dynamic var StoryTabMoveDC2: Int = 0
    @objc dynamic var StoryTabMoveType2: String = ""
    
    @objc dynamic var StoryTabMoveActive3: Bool = false
    @objc dynamic var StoryTabMoveID3: String = ""
    @objc dynamic var StoryTabMoveDiscription3: String = ""
    @objc dynamic var StoryTabMoveRequiresRoll3: Bool = false
    @objc dynamic var StoryTabMoveDC3: Int = 0
    @objc dynamic var StoryTabMoveType3: String = ""
    
    @objc dynamic var StoryTabMoveActive4: Bool = false
    @objc dynamic var StoryTabMoveID4: String = ""
    @objc dynamic var StoryTabMoveDiscription4: String = ""
    @objc dynamic var StoryTabMoveRequiresRoll4: Bool = false
    @objc dynamic var StoryTabMoveDC4: Int = 0
    @objc dynamic var StoryTabMoveType4: String = ""
    
    @objc dynamic var StoryTabBackActive: Bool = false
    @objc dynamic var StoryTabBackID: String = ""
    @objc dynamic var StoryTabBackDiscription: String = ""
    @objc dynamic var StoryTabBackRequiresRoll: Bool = false
    @objc dynamic var StoryTabBackDC: Int = 0
    @objc dynamic var StoryTabBackType1: String = ""
    
    @objc dynamic var StoryTabFowardActive: Bool = false
    @objc dynamic var StoryTabFowardID: String = ""
    @objc dynamic var StoryTabFowardDiscription: String = ""
    @objc dynamic var StoryTabFowardRequiresRoll: Bool = false
    @objc dynamic var StoryTabFowardDC: Int = 0
    @objc dynamic var StoryTabFowardType: String = ""
    
    @objc dynamic var StoryTabFailID1: String = ""
    @objc dynamic var StoryTabFailID2: String = ""
    
    @objc dynamic var isItemRoom: Bool = false
    @objc dynamic var isEncounter: Bool = false
    
    let items = List<Item>()
    let enemies = List<Enemy>()
}
