class SomeTabPanel < Netzke::Basepack::TabPanel
  # This component will be rendered immediately in the first tab
  #
  component :tab_one do |c|
    c.klass = SimplePanel
    c.title = "Panel Zero"
  end

  # This component will be dynamically loaded on expanding the second accordion pane
  component :simple_panel do |c|
    c.update_text = "Update for Panel Two"
    c.title = "Panel Two"
    c.header = false
    c.border = false

    # optionally, you can force a certain component to be eagerly loaded:
    # c.eager_loading = true
  end

  def configure(c)
    c.title = "Some Tab Panel"
    c.active_tab = 0

    c.items = [
      :tab_one,
      { :html => "I'm a simple Ext.Panel", :title => "Panel One" },
      :simple_panel
    ]
    super
  end
end
