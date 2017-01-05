class PhotosController < ApplicationController
  before_action :authenticate, except: [:index, :show, :all]
  before_action :set_match,
    except: [:all, :list, :new_warmup_match_photo, :create_warmup_match_photo]
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  def index
    @photos = @match.photos.all.order(created_at: :desc)
  end

  def all
    @photos = Photo.all
    @matches = Match.where(id: Photo.pluck(:match_id).uniq).order(id: :desc)
  end

  def list
    @photos = Photo.all.order(created_at: :desc)
  end

  def show
    if @photo.match
      @first_team = Team.find(@photo.match.team1_id)
      @opponent_team = Team.find(@photo.match.team2_id)
    end
  end

  def new
    @photo = @match.photos.new
  end

  def edit; end

  def create
    @photo = @match.photos.new(photo_params)

    respond_to do |format|
      if @photo.save
        format.html {
          redirect_to all_matches_url, notice: 'Photo was successfully created.'
        }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_warmup_match_photo
    @photo = Photo.new(photo_params)
    if @photo.save
      redirect_to all_matches_url, notice: 'Warmup match photo created!'
    else
      redirect_to all_matches_url, alert: 'Could not save photo'
    end
  end

  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html {
          redirect_to all_matches_url, notice: 'Photo was successfully updated.'
        }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @photo.destroy
    respond_to do |format|
      format.html {
        redirect_to all_photos_url, notice: 'Photo was successfully destroyed.'
      }
      format.json { head :no_content }
    end
  end

  private

  def authenticate
    authenticate_or_request_with_http_basic('Trespassers will be prosecuted') do |username, password|
      username == ENV['USERNAME'] && password == ENV['ADMIN_PASSWORD']
    end
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def set_match
    @match = Match.friendly.find(params[:match_id])
  end

  def photo_params
    params.require(:photo).permit(:picture)
  end
end
