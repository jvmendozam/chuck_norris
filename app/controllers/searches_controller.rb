class SearchesController < ApplicationController

  include Concerns::Connectable
  include Concerns::Transformable
  require 'securerandom'

  before_action :prevent_nil_at_refresh, only: [:index]

  BASE_URL = 'https://api.chucknorris.io/jokes'

  def index
  end

  def index_categories
    @search = Search.new(value: params["value"])
    response = connection(BASE_URL).get("random", category: @search.value).body
    @quotes = [{"value": response["value"], "id": SecureRandom.hex}]
    save_values
  end

  def random
    @search = Search.new(value: "random")
    response = connection(BASE_URL).get("random").body
    @quotes = [{"value": response["value"], "id": SecureRandom.hex}]
    save_values
  end


  # GET /searches/new
  def new
  end

  # GET /searches/1/edit
  def edit
  end

  # POST /searches
  # POST /searches.json
  def create
    @search = Search.new(search_params)
    response = connection(BASE_URL).get("search", query: @search.value.parameterize.underscore).body
    @quotes = response["result"]
    save_values
  end

  def categories
    respond_to do |format|
      response = connection(BASE_URL).get("categories").body
      opt = []
      response.each {|item| opt.append({value: item})}
      @categories = opt
      format.html
      format.js
    end
  end

  def update
    respond_to do |format|
      if @search.update(search_params)
        format.html {redirect_to @search, notice: 'Search was successfully updated.'}
        format.json {render :show, status: :ok, location: @search}
      else
        format.html {render :edit}
        format.json {render json: @search.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /searches/1
  # DELETE /searches/1.json
  def destroy
    @search.destroy
    respond_to do |format|
      format.html {redirect_to searches_url, notice: 'Search was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  def send_mail
    @search = Search.find(params['search'])
    @quotes = quote_to_response(@search)
    @email = params['email']
    flash[:message] =t("sent_email", email: @email)
    redirect_to root_path
    SearchMailer.search_email(@search, @quotes, @email).deliver
  end

  private

  def prevent_nil_at_refresh
    redirect_to root_path unless @search.present?
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_search
    @search = Search.find(params[:id])
  end

  def save_values
    if @search.save
      response_to_quote(@quotes,@search)
      render :action => 'index'
    else
      flash[:message] = t("missing_search_param")
      redirect_to root_path
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def search_params
    params.require(:search).permit(:value)
  end
end
