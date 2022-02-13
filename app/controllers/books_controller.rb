class BooksController < ApplicationController
  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "successfully"
      redirect_to book_path(@book)
    else
      redirect_to books_path
    end
  end


  def show
    @book = Book.find(params[:id])
    @Book = Book.new

  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id == current_user.id
      render "edit"
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    #if @book.user_id != current_user.id
      #redirect_to root_path
    #end
    if @book.update(book_params)
      flash[:notice] = "successfully"
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    #if @book.user_id != current_user.id
      #redirect_to root_path
    #end
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
