class Admin::BadgesController < Admin::BaseController
  before_action :find_badges, only: %i[index]
  before_action :find_badge, only: %i[show edit update destroy]

  def index; end

  def show; end

  def edit; end

  def update
    if @badge.update(badge_params)
      redirect_to admin_badges_path
    else
      render :edit
    end
  end

  def create
    @badge = Badge.new(badge_params)
    if @badge.save
      redirect_to admin_badges_path
    else
      render :new
    end
  end

  def new
    @badge = Badge.new
  end

  def destroy
    @badge.destroy
    redirect_to admin_badges_path
  end

  private

  def find_badges
    @badges = Badge.all
  end

  def find_badge
    @badge = Badge.find(params[:id])
  end

  def badge_params
    params.require(:badge).permit(:name, :path, :rule_id)
  end
end
