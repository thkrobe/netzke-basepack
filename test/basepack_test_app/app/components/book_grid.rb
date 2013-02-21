class BookGrid < Netzke::Basepack::Grid
  def configure(c)
    c.model = "Book"
    c.title = I18n.t('books', :default => "Books")

    super
  end

  column :author__name do |c|
    c.sorting_scope = :sorted_by_author_name
  end

  # crafting a static combobox column; TODO: include a prebuilt one in Basepack
  column :rating do |c|
    c.editor = {
      :trigger_action => :all,
      :xtype => :combo,
      :store => [[0, "---"], [1, "Good"], [2, "Average"], [3, "Poor"]]
    }

    c.renderer = "function(v){return ['', 'Good', 'Average', 'Poor'][v];}"
  end
end
