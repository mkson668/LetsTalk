//
//  Recent.swift
//  LetsTalk
//
//  Created by Aaron on 2019-09-09.
//  Copyright © 2019 Aaron Wong. All rights reserved.
//

import Foundation

func startPrivateChat(user1: FUser, user2: FUser) -> String {
    let userId1 = user1.objectId
    let userId2 = user2.objectId
    
    var chatRoomId = ""
    
    // so we access teh same chatroomid regarless of who starts chatt
    let value = userId1.compare(userId2).rawValue
    
    if value < 0 {
        chatRoomId = userId1 + userId2
    } else {
        chatRoomId = userId2 + userId1
    }
    
    let members = [userId1, userId2]
    createRecent(members: members, chatRoomId: chatRoomId, withUserUserName: "", type: kPRIVATE, users: [user1, user2], avatarOfGroup: nil)
    return chatRoomId
}

func createRecent(members: [String], chatRoomId: String, withUserUserName:String, type: String, users: [FUser]?, avatarOfGroup: String?) {
    var tempMembers = members
    reference(.Recent).whereField(kCHATROOMID, isEqualTo: chatRoomId).getDocuments { (snapshot, err) in
        // check if we got anything back at all
        guard let snap = snapshot else {return}
        if !snap.isEmpty {
            for recent in snap.documents {
                let currentRecent = recent.data() as NSDictionary
                if let currentUserId = currentRecent[kUSERID] {
                    if tempMembers.contains(currentUserId as! String) {
                        tempMembers.remove(at: tempMembers.firstIndex(of: currentUserId as! String)!)
                    }
                }
            }
        }
        
        for userId in tempMembers {
            // create recent items
            createRecentItem(userId: userId, chatRoomId: chatRoomId, members: members, withUserUserName: withUserUserName, type: type, users: users, avatarOfGroup: avatarOfGroup)
        }
    }
}

func createRecentItem(userId: String, chatRoomId: String, members:[String], withUserUserName: String, type:String, users:[FUser]?, avatarOfGroup: String?) {
    
    let localReference = reference(.Recent).document()
    let recentId = localReference.documentID
    
    let date = dateFormatter().string(from: Date())
    
    var recent: [String: Any]
    
    if type == kPRIVATE {
        var withUser: FUser?
        
        if users != nil && users!.count > 0 {
            if userId == FUser.currentId() {
                withUser = users!.last!
            } else {
                withUser = users!.first!
            }
        }
        
        recent = [
            kRECENTID: recentId,
            kUSERID: userId,
            kCHATROOMID: chatRoomId,
            kMEMBERS: members,
            kMEMBERSTOPUSH:members,
            kWITHUSERFULLNAME:withUser!.fullname,
            kWITHUSERUSERID: withUser!.objectId,
            kLASTNAME: "",
            kCOUNTER: 0,
            kDATE: date,
            kTYPE: type,
            kAVATAR: withUser!.avatar
            ] as [String:Any]
        
    } else {
        // group chat do later
        
    }
    
}
