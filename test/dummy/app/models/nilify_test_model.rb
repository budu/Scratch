
class NilifyTestModel < ActiveRecord::Base

  nilify except: [:foo, :baz]
  nilify only: :baz, predicate: :odd?, before: :save

end
