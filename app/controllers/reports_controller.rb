class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, except: [:show, :index]

  def index
    @reports = Report.paginate(page: params[:page]).order(created_at: :desc)
  end

  def list
    @reports = Report.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @report = Report.new
  end

  def edit
  end

  def create
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.save
        format.html { redirect_to all_reports_url, notice: 'Report was successfully created.' }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to all_reports_url, notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to all_reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_report
    @report = Report.friendly.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:article, :image, :caption, :match_id)
  end

  def authenticate
    authenticate_or_request_with_http_basic('Trespassers will be prosecuted') do |username, password|
      username == ENV['USERNAME'] && password == ENV['ADMIN_PASSWORD']
    end
  end
end
