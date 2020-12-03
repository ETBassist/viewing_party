class Review
  attr_reader :author,
              :description

  def initialize(details)
    @author = details[:author]
    @description = details[:content]
  end
end
