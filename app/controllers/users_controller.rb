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
    # github_user = client.user
    # render json: [ location: github_user.location,
    #                following: github_user.following,
    #                followers: github_user.followers,
    #                website: github_user.blog,
    #                repos: github_user.public_repos,
    #                gists: github_user.public_gists,
    #             ]
  end

  def language_chart
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

  def activity
    act = client.user_events(current_user.username, per_page: 30)
    hash = Hash.new(0)
    act.each do |repo|
      repo.type.slice!("Event")
      if repo.type.scan(/[A-Z][a-z]+/).count > 1
        repo.type = repo.type.scan(/[A-Z][a-z]+/).join(" ")
      end
      hash[repo.type] += 1
    end

    activity = hash.map do |k,v|
      { activity: k, number: v }
    end

    render json: activity
  end

  def client
    Octokit::Client.new(:access_token => current_user.token)
  end

end
