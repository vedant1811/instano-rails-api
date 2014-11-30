class VisitorsController < ApplicationController

  def new
    @v1_visitor = V1::Visitor.new(visitor_params)

    if @v1_visitor.save
      render json: @v1_visitor
    else
      render json: @v1_visitor.errors, status: :unprocessable_entity
    end
  end

  def index
    @v1_visitors = V1::Visitor.all

    render json: @v1_visitors
  end

  private

  def visitor_params
    params.permit(:name, :phone, :email, :message)
  end
end
