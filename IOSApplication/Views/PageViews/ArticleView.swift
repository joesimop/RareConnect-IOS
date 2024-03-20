//
//  ArticleView.swift
//  IOSApplication
//
//  Created by Joseph Simopoulos on 3/17/24.
//

import SwiftUI

struct ArticleView: View {
    
    var community_id: Int
    var article_id : Int
    //var article_type : eArticleType
    @State private var article: ViewResult<Article> = ViewResult.Loading()
    private var dispatcher: ViewBindAPIDispatcher = ViewBindAPIDispatcher()
    
    init(community_id: Int, article_id: Int) {
        self.community_id = community_id
        self.article_id = article_id
    }
    
    var body: some View {
        APIResultView(apiResult: $article){ article in
            VStack{
                rcText(article.title)
                rcText(article.abstract)
                rcText(article.timestamp.description)
            }
        }.onAppear(){
            dispatcher.SendRequest((.getArticle(community_id: community_id, article_id: article_id), $article))
        }
    }
}

