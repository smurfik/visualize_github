class UsersController < ApplicationController

  def index
  end

  def create
    oath_attrs = request.env['omniauth.auth']
    @user = User.find_or_initialize_by(uid: oath_attrs.uid)
    @user.username   = oath_attrs.info.nickname
    @user.email      = oath_attrs.info.email
    @user.avatar_url = oath_attrs.info.image
    @user.token      = oath_attrs.credentials.token
    @user.save
    session[:user_id] = @user.id
    redirect_to root_path
  end

  def sign_out
    session.delete(:user_id)
    redirect_to root_path
  end

  def github_api
    client = Octokit::Client.new(:access_token => current_user.token)
    # render json: client.repositories[0].language
    # render json: [ location: client.user.location,
    #                following: client.user.following,
    #                followers: client.user.followers,
    #                website: client.user.blog,
    #                name: client.user.name,
    #                repos: client.user.public_repos,
    #                gists: client.user.public_gists,
    #                user: client.user
    #             ]
  end

  def language_chart
    client = Octokit::Client.new(:access_token => current_user.token)
    hash = Hash.new(0)
    client.repositories.each do |repo|
      if repo.language.nil?
        hash["n/a"] += 1
      else
        hash[repo.language] += 1
      end
    end

    languages = hash.map do |k,v|
      { language: k, repos: v }
    end

    render json: languages
  end

end
