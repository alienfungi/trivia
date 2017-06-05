class AnswersController < ApplicationController
  authorize_resource

  def create
    @question = current_user.question
    @answer = @question.blank_answer
    answer_type = @answer.class.name.underscore.to_sym
    @answer.assign_attributes(answer_params(answer_type))
    if @answer.invalid?
      render :new
    else
      if @question.check? @answer
        current_user.answered_correctly!
        flash.now[:notice] = 'Correct!'
      else
        current_user.answered_incorrectly!
        flash.now[:alert] = 'Wrong!'
      end
      @question.users.delete(current_user)
    end
  end

  def new
    unless current_user.assign_question { Question.retrieve }
      flash.now[:alert] = 'It looks like you didn\'t finish answering your last question.'
    end
    @question = current_user.question
    if @question
      @answer = @question.blank_answer
    else
      flash[:alert] = 'No questions available'
      redirect_to root_path
    end
  end

  private

  def answer_params(answer_type)
    params.require(answer_type).permit!
  end
end
