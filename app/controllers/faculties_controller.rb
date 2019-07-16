class FacultiesController < ApplicationController
  def index
    faculties = Faculty.all
    obj = faculties.collect do |faculty|
      JSON.parse(UserSerializer.new(faculty.user).to_serialized_json)
    end
    render json: obj
  end

  def show
    faculty = Faculty.find_by(id: params[:id])
    render json: UserSerializer.new(faculty.user).to_serialized_json
  end

  def create
    faculty = Faculty.all.find do |faculty|
      faculty.user.username == params[:user_attributes][:username]
    end

    if faculty
      render json: {message: "failure"}
    else
      faculty = Faculty.create(faculty_params)
      user = User.new(faculty_params[:user_attributes])
      user.assign_attributes(userable: faculty)

      render json: UserSerializer.new(faculty.user).to_serialized_json
    end
  end

private
    def faculty_params
      params.require(:faculty).permit(:years_of_service, user_attributes: [:name, :username, :address])
    end
end
