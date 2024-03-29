class GroupsController < ApplicationController

  #before_filter :check_auth, :accept => [:new, :edit, :join]

  #------------------------------
  # CREATE
  #------------------------------
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(params[:group])
    @group.initialize_owner(current_user)

    if @group.save
      redirect_to group_path(@group.gid)
    else
      flash.now[:error] = "Something went wrong - please check your fields and try again."
      render :new
    end
    
  end


  #------------------------------
  # READ
  #------------------------------
  def index
    @groups = current_user.groups
  end

  def show
    @group = Group.find_by_gid(params[:id])
  end


  #------------------------------
  # UPDATE
  #------------------------------
  def edit
    @group = Group.find_by_gid(params[:id])
    redirect_to groups_path unless current_user == @group.owner
  end

  def update
    @group = Group.find_by_gid(params[:id])
   
    if @group.update_attributes(params[:group])
      flash[:success] = "Group successfully updated."
      redirect_to groups_path      
    else
      flash.now[:error] = "Something went wrong - please check your fields and try again."
      render :edit
    end
  end


  #------------------------------
  # DELETE
  #------------------------------
  def destroy   
    # Need to destroy group, but preserve user accounts
    # TODO - destroy associations correctly

    group = Group.find_by_gid(params[:id])
    group.destroy
    flash[:success] = "Group successfully deleted"
    redirect_to groups_path
  end


  #------------------------------
  # JOIN/LEAVE
  #------------------------------
  def join
    # View  
  end

  def add
    # Processing
    group = Group.find_by_gid(params[:gid])

    if group && group.authenticate(params[:password])
      if group.users.include? current_user
        flash.now[:error] = "You already belong to that group!"
        render :join
      else
        group.users << current_user
        flash[:success] = "You are now a member of #{group.title}!"
        redirect_to groups_path
      end
    else
      flash.now[:error] = "Invalid ID/Password combination."
      render :join
    end
  end

end
