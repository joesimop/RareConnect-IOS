//
//  CommunityBoardVM.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 2/20/24.
//

import Foundation
import SwiftUI

///View Model for Community Board Page
class CommunityBoardVM : ViewModel {
    
    
    var community_id: Int = 0
    var profile_id: Int = 0
    @Published var posts: ViewResult<[CommunityBoardPost]> = ViewResult(defaultValue: [])
    @Published var pinnedPosts: ViewResult<[CommunityBoardPost]> = ViewResult(defaultValue: [])
    @Published var commentSection: ViewResult<[Comment]> = ViewResult(defaultValue: [])
    private var dispatcher : ViewModelAPIDispatcher = ViewModelAPIDispatcher()
    
    init(community_id: Int, profile_id: Int){
        self.community_id = community_id
        self.profile_id = profile_id
        self.OnViewOpen()
    }
    
    ///Get pinned posts and posts from backend and sets the data
    func OnViewOpen() {
        dispatcher.SendRequests(.getPinnedPosts(community_id: community_id, profile_id: profile_id),
                            .getBoardPosts(community_id: community_id, profile_id: profile_id))
            { (pinnedPosts, allPosts) in
                DispatchQueue.main.async {
                    self.pinnedPosts.SetData(pinnedPosts)
                    self.posts.SetData(allPosts)
                }
            }
    }
    
    ///Get pinned posts and posts from backend and sets the data
    func OnViewOpen(community_id: Int, profile_id: Int) {
        self.community_id = community_id
        self.profile_id = profile_id
        dispatcher.SendRequests(.getPinnedPosts(community_id: community_id, profile_id: profile_id),
                            .getBoardPosts(community_id: community_id, profile_id: profile_id))
            { (pinnedPosts, allPosts) in
                DispatchQueue.main.async {
                    self.pinnedPosts.SetData(pinnedPosts)
                    self.posts.SetData(allPosts)
                }
            }
    }
    
    ///Repulls the pinned posts and posts from the backend
    func Refresh() {
        self.posts.Refresh()
        self.pinnedPosts.Refresh()
        self.OnViewOpen()
    }
    
    ///Get posts from backend and set the data
    func GetPosts(){
        dispatcher.SendRequestViewUpdate(.getBoardPosts(community_id: community_id, profile_id: profile_id)){ result in
            self.posts.SetData(result)
        }
    }
    
    ///Get pinned posts from backend and set the data
    func GetPinnedPosts(){
        dispatcher.SendRequestViewUpdate(.getBoardPosts(community_id: community_id, profile_id: profile_id)){ result in
            self.posts.SetData(result)
        }
    }
    
    ///Get Comments for a post
    func GetComments(post_id: Int){
        dispatcher.SendRequestViewUpdate(.getComments(community_id: community_id, post_id: post_id)){ result in
            self.commentSection.SetData(result)
        }
    }
    
    ///Create a comment on a post. Note: the post_id is in the newComment parameter.
    func Comment(newComment: Comment){
        dispatcher.SendRequestViewUpdate(.commentPost(community_id: community_id, newComment: newComment)) { apiResult in
            if IsSuccessful(apiResult) {
                self.commentSection.data!.append(newComment)
                let commentedPost = self.posts.data!.firstIndex(where: {post in post.id == newComment.post_id})
                self.posts.data![commentedPost!].comments.append(newComment)
                self.posts.data![commentedPost!].comment_count += 1
            }
        }
    }
    
    ///Toggles the upvote for a profile on a post. Closure provided to update view accordingly.
    func UpvoteToggle(body: BooleanToggle, completion: @escaping (APIResponseCode) -> Void){
        dispatcher.SendRequestBindUpdate(.upvoteToggle(community_id: community_id, body: body)) { apiResult in
            completion(apiResult)
        }
    }
    
    ///Toggles the favorite for a profile on a post. Closure provided to update view accordingly.
    func FavoriteToggle(body: BooleanToggle, completion: @escaping (APIResponseCode) -> Void){
        dispatcher.SendRequestBindUpdate(.favoriteToggle(community_id: community_id, body: body)) { apiResult in
            completion(apiResult)
        }
    }
    
    ///Toggles the pin for a post. Closure provided to update view accordingly.
    func PinToggle(post_id: Int, completion: @escaping (APIResponseCode) -> Void){
        dispatcher.SendRequestBindUpdate(.pinToggle(community_id: community_id, post_id: post_id)) { apiResult in
            completion(apiResult)
        }
    }
    
    //NOTE: Need to rewrite API Call so that is returns the new post it created in the database,
    //      then append that to the published results.
    func PostToBoard(newPost: NewBoardPost, completion: @escaping (APIResponseCode) -> Void){
        dispatcher.SendRequestBindUpdate(.postToBoard(community_id: community_id, newPost: newPost)) { apiResult in
            completion(apiResult)
        }
    }
}
