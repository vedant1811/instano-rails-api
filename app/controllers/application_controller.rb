class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    render 'public/homepage/index.html'
  end

  def staging
    render 'public/homepage/staging.html'
  end

  def new_visitor
    @v1_visitor = V1::Visitor.new(visitor_params)

    if @v1_visitor.save
      render json: @v1_visitor
    else
      render json: @v1_visitor.errors, status: :unprocessable_entity
    end
  end

  private

  def visitor_params
    params.require(:visitor).permit(:name, :phone, :email, :message)
  end
end
