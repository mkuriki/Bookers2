class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    
    if @book.save
      redirect_to book_path(@book.id)
      flash[:notice] = "You have created book successfully."
    else
      @books = Book.all
      @user = current_user     
      render :index
    end  
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @new_book = Book.new
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to '/books'
  end
  
  def update
    @book = Book.find(params[:id])
    @user = User.find(params[:id])
      
    if @book.update(book_params)
      redirect_to user_path(@user.id)
      flash[:notice] = "You have updated book successfully."
    else
      render :edit
    end
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  

    # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
