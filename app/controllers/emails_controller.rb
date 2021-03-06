# == Schema Information
#
# Table name: emails
#
#  id            :integer          not null, primary key
#  name          :string
#  newsletter_id :integer
#  send_date     :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class EmailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_email, only: [:show, :edit, :update, :destroy, :build]

  # GET /emails
  # GET /emails.json
  def index
    newsletter = Newsletter.find(params[:newsletter_id])
    @emails = newsletter.emails.all
  end

  # GET /emails/1
  # GET /emails/1.json
  def show
    @newsletter = @email.newsletter
    @links = @email.links.includes(:category)
  end

  # GET /emails/new
  def new
    @email = Email.new(newsletter_id: params[:newsletter_id])

    @email
  end

  # GET /emails/1/edit
  def edit
    @newsletter = @email.newsletter
  end

  # POST /emails
  # POST /emails.json
  def create
    @email = Email.new(email_params)

    respond_to do |format|
      if @email.save
        format.html { redirect_to [@newsletter, @email], notice: 'Email was successfully created.' }
        format.json { render :show, status: :created, location: @email }
      else
        format.html { render :new }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /emails/1
  # PATCH/PUT /emails/1.json
  def update
    respond_to do |format|
      if @email.update(email_params)
        format.html { redirect_to @email, notice: 'Email was successfully updated.' }
        format.json { render :show, status: :ok, location: @email }
      else
        format.html { render :edit }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emails/1
  # DELETE /emails/1.json
  def destroy
    @email.destroy
    respond_to do |format|
      format.html { redirect_to newsletter_emails_path, notice: 'Email was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def build
    @html = @email.build
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email
      @email = Email.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_params
      params.require(:email).permit(:name, :newsletter_id, :send_date)
    end
end
