module Netzke
  class UserForm < Component::FormPanel
    def config
      {
        :model => 'User',
        :title => 'Users',
        :record_id => User.first.id,
        # :items => [{:name => :first_name}, {:name => :last_name}]
        # :items => [
          # {:name => :first_name, :disabled => true}, {:name => :last_name}, 
          # { 
          #   :xtype => 'tabpanel', :items => [{
          #     :layout => 'form',
          #     :title => "Main",
          #     :padding => 5,
          #     :auto_height => true,
          #     :items => [{:name => :first_name}]
          #   },{
          #     :layout => 'form',
          #     :title => "Extra",
          #     :padding => 5,
          #     :auto_height => true,
          #     :items => [{:name => :last_name}]
          #   }],
          #   :active_tab => 0
          # },
        #   { :xtype => 'fieldset', :checkbox_toggle => false, :title => "Fieldset", :items => [{:name => :first_name}, {:name => :last_name}]},
        #   { :name => :created_at }
        # ]
      }.deep_merge super
    end
    
  end
end