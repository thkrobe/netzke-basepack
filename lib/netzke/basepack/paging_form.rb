module Netzke
  module Basepack
    # A Form with paging toolbar. Allows browsing and editing records one-by-one.
    #
    # == Configuration
    # Besides +Netzke::Basepack::Form+ config options, accepts:
    # * +scope+ - specifies how the data should be filtered.
    #   When it's a symbol, it's used as a scope name.
    #   When it's a string, it's a SQL statement (passed directly to +ActiveRecord::Relation#where+).
    #   When it's a hash, it's a conditions hash (passed directly to +ActiveRecord::Relation#where+).
    #   When it's an array, it's expanded into an SQL statement with arguments (passed directly to +ActiveRecord::Relation#where+), e.g.:
    #
    #     :scope => ["id > ?", 100])
    #
    #   When it's a Proc, it's passed the model class, and is expected to return an ActiveRecord::Relation, e.g.:
    #
    #     :scope => { |rel| rel.where(:id.gt => 100).order(:created_at) }
    #
    # == ToDo
    # * Update the number of records after form submit
    class PagingForm < Form
      js_configure do |c|
        c.mixin
      end

      # override
      def record
        @record ||= data_adapter.first
      end

      def js_configure(c)
        super
        # Pass total records amount and the first record to the JS constructor
        c.total_records = total_records
      end

      endpoint :get_data do |params, this|
        @record = data_adapter.get_records(params).first
        record_hash = @record && js_record_data
        this.merge!(:records => record_hash && [record_hash] || [], :total => total_records(params))
      end

      action :search do |a|
        a.icon = :find
        a.select = true
      end

      def configure_bbar(c)
        super
        c[:bbar] << :search
      end

      component :search_form do |c|
        c.klass = SearchWindow
        c.model = config[:model]
        c.fields = fields
      end

    protected

      def total_records(params = {})
        @total_records ||= data_adapter.count_records(params, [])
      end
    end
  end
end
