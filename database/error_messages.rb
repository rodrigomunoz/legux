class Sequel::Model
  plugin :validation_helpers
  # Override error messages
  # TODO: not using these error messages
  Sequel::Plugins::ValidationHelpers::DEFAULT_OPTIONS.merge!(
    :exact_length=>{:message=>lambda{|exact| I18n.t("sequel.ERROR_EXACT_LENGTH", :exact => exact)}},
    :nil_message=>{:message=> I18n.t("sequel.ERROR_NOT_PRESENT")}
  )
end