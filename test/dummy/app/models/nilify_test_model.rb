
class NilifyTestModel < ActiveRecord::Base

  nilify except: [:foo, :baz]
  nilify only: :baz, pred: :odd?, before: :save

end
