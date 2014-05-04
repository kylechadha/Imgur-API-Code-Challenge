Rails.application.config.middleware.use OmniAuth::Builder do
  # Normally you would never leave these exposed
  provider :twitter, 'EGtAiRXlnFzX90MPtkHA', 'OkDiA6C0Ej2yBg9Jh6Rdhoxc25b5aMfQLRwbY1Mw0U'
end