# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  def index
    @books = current_user.books.order(:id).page(params[:page])
  end

  # GET /books/1
  def show
  end

  # GET /books/new
  def new
    @book = current_user.books.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  def create
    @book = current_user.books.new(book_params)
    @book.save!
    redirect_to @book, notice: t("success.book_was_successfully_created")
  end

  # PATCH/PUT /books/1
  def update
    if @book.update(book_params)
      redirect_to @book, notice: t("success.book_was_successfully_updated")
    else
      render :edit, t("errors.messages.book_edit_failure")
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy
    redirect_to books_url, notice: t("success.book_was_successfully_destroyed")
  end

  private
    def set_book
      @book = current_user.books.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :memo, :author, :image)
    end
end
