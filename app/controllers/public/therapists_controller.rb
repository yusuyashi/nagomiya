class Public::TherapistsController < ApplicationController
  def index
    @therapists = Therapist.all
  end

end
