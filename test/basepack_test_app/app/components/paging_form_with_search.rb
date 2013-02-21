# OUTDATED
class PagingFormWithSearch < Netzke::Basepack::BorderLayoutPanel
  def default_config
    super.tap do |s|
      s[:model] = "Book"
      s[:items] = [
        :paging_form_panel.component(:region => :center),
        :search_panel.component(:region => :west, :width => 600, :split => true)
      ]
    end
  end

  component :paging_form_panel do
    {
      :class_name => "Netzke::Basepack::PagingForm",
      :model => config[:model]
    }
  end

  component :search_panel do
    {
      :class_name => "Netzke::Basepack::SearchPanel",
      :model => config[:model],
      :bbar => [:apply],
      :preset_query => []
    }
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();

      this.getChildComponent('search_panel').on('conditionsupdate', function(query){
        this.getChildComponent('paging_form_panel').getStore().baseParams.query = Ext.encode(query);
        this.getChildComponent('paging_form_panel').getStore().load();
      }, this);
    }
  JS

end
