
class StripifyTestModel < ActiveRecord::Base

  stripify except: :foo

end
