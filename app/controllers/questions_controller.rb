class QuestionsController < ApplicationController
  before_action :set_type

  authorize_resource

  def create
    @question = klass.new(question_params)
    @question.user_id = current_user.id
    if @question.save
      flash[:notice] = 'Successfully created question'
      redirect_to [:new, @type.underscore.to_sym]
    else
      flash.now[:alert] = 'Failed to create question'
      render 'new'
    end
  end

  def new
    @question = klass.new
  end

  private

  def klass
    @type.constantize
  end

  def question_params
    params.require(@type.underscore.to_sym).permit(:body, :category_list, *klass.options_whitelist)
  end

  def set_type
    type = params[:type]
    if Question.question_types.include? type
      @type = type
    else
      raise ActiveRecord::RecordNotFound
    end
  end
end
