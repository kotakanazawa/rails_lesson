class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  # GET /reports
  def index
    @reports = Report.where(user_id: current_user).order(created_at: :DESC)
  end

  # GET /reports/1
  def show
  end

  # GET /reports/new
  def new
    @report = current_user.reports.new
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports
  def create
    @report = current_user.reports.new(report_params)
    if @report.save
      redirect_to @report, notice: t("success.report_was_successfully_created")
    else
      render :new
    end
  end

  # PATCH/PUT /reports/1
  def update
    if @report.update(report_params)
      redirect_to @report, notice: t("success.report_was_successfully_updated")
    else
      render :edit
    end
  end

  # DELETE /reports/1
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
