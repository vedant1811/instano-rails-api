# see https://gist.github.com/dmilisic/38fcd407044ace7514df

module ActiveRecord
  module RailsAdminEnum
    def enum(definitions)
      super

      definitions.each do |name, values|
        define_method("#{ name }_enum") { self.class.send(name.to_s.pluralize).to_a }

        define_method("#{ name }=") do |value|
          if value.kind_of?(String) and value.to_i.to_s == value
            super value.to_i
          else
            super value
          end
        end
      end
    end
  end
end
ActiveRecord::Base.send(:extend, ActiveRecord::RailsAdminEnum)

class RailsAdminPgArray < RailsAdmin::Config::Fields::Base
  register_instance_option :formatted_value do
    value.join(',')
  end
end

class RailsAdminPgStringArray < RailsAdminPgArray
  def parse_input(params)
    if params[name].is_a?(::String)
      params[name] = params[name].split(',')
    end
  end
end

class RailsAdminPgIntArray < RailsAdminPgArray
  def parse_input(params)
    if params[name].is_a?(::String)
      params[name] = params[name].split(',').collect{|x| x.to_i}
    end
  end
end

RailsAdmin::Config::Fields::Types::register(:pg_string_array, RailsAdminPgStringArray)
RailsAdmin::Config::Fields::Types::register(:pg_int_array, RailsAdminPgIntArray)

RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :admin_user
  end
  config.current_user_method(&:current_admin_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  config.audit_with :paper_trail, 'AdminUser', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
