class StudentsController < ApplicationController
  def index
    students = Student.all
    obj = students.collect do |student|
      JSON.parse(UserSerializer.new(student.user).to_serialized_json)
    end
    render json: obj
  end

  def show
    student = Student.find_by(id: params[:id])
    render json: UserSerializer.new(student.user).to_serialized_json
  end

  def create
    student = Student.all.find do |student|
      student.user.username == params[:user_attributes][:username]
    end

    if student
      render json: {message: "failure"}
    else
      student = Student.create(student_params)
      user = User.new(student_params[:user_attributes])
      user.assign_attributes(userable: student)

      render json: UserSerializer.new(student.user).to_serialized_json
    end
  end

private
    def student_params
      params.require(:student).permit(:major, :gpa, user_attributes: [:name, :username, :address])
    end
end
