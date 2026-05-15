Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.public_file_server.headers = { "Cache-Control" => "public, max-age=31536000" }
  config.active_storage.service = :local
  config.log_level = :info
  config.active_support.report_deprecations = false
end
