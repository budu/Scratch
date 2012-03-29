
class NilifyTestModel < ActiveRecord::Base

  nilify except: [:foo, :baz]
  nilify only: :baz, when: :odd?, before: :save

end
