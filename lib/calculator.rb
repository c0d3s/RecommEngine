module Suadeo
  class Calculator
    attr_reader :data, :subject, :comparate

    def initialize(data:, subject:, comparate:)
      @data = data
      @subject = subject
      @comparate = comparate
    end
  end
end
