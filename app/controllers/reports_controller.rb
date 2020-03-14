# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  def index
    @reports = Report.where(user_id: current_user).order(created_at: :DESC)
  end

  def show
  end

  def new
    @report = current_user.reports.new
  end

  def edit
  end

  def create
    @report = current_user.reports.new(report_params)
    if @report.save
      redirect_to @report, notice: t("success.report_was_successfully_created")
    else
      render :new
    end
  end

  def update
    if @report.update(report_params)
      redirect_to @report, notice: t("success.report_was_successfully_updated")
    else
      render :edit
    end
  end

  def destroy
    @report.destroy
    redirect_to user_path(@report.user_id), notice: t("success.report_was_successfully_destroyed")
  end

  private
    def set_report
      @report = Report.find(params[:id])
    end

    def report_params
      params.require(:report).permit(:title, :body)
    end
end
