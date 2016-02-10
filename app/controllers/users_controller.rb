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
    # render json: client.repositories
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

end
