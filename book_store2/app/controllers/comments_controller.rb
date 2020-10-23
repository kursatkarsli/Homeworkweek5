class CommentsController < ApplicationController
  
    def create
        @book = Book.find(params[:book_id])
        @comment = @book.comments.create(comment_params)
        redirect_to book_path(@book)
    end
    def edit
      @comment = Comment.find(params[:id])   
      @book = Book.find(params[:book_id])
    end
    def update
      @comment = Comment.find(params[:id]) 
      if @comment.update_attributes(:accept => true)
        redirect_to dashboard_index_url
      else
        render 'edit'
      end
    end
     
      private
        def comment_params
          params.require(:comment).merge(user_id: current_user.id).permit(:title, :content, :user_id)      
        
        end
end