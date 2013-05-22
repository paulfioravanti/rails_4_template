def create_rails_locales
  comment "# Create activerecord locale file"
  copy_from_repo 'config/locales/activerecord/activerecord.en.yml'

  comment "# Create flash locale file"
  copy_from_repo 'config/locales/flash/flash.en.yml'
end

def create_app_locales
  comment "# Create helpers locale file"
  copy_from_repo 'config/locales/helpers/helpers.en.yml'

  comment "# Create layouts locale file"
  copy_from_repo 'config/locales/layouts/layouts.en.yml', erb: true

  comment "# Create shared locale file"
  copy_from_repo 'config/locales/shared/shared.en.yml'

  comment "# Create pages locale file"
  copy_from_repo 'config/locales/pages/pages.en.yml', erb: true

  comment "# Create sessions locale file"
  copy_from_repo 'config/locales/sessions/sessions.en.yml'

  comment "# Create users locale file"
  copy_from_repo 'config/locales/users/users.en.yml'
end

def create_vendor_locales
  comment "# Create faker locale file under vendor/"
  copy_from_repo 'config/locales/vendor/faker.en.yml'

  comment "# Replace generated simple_form locale file for one under vendor/"
  copy_from_repo 'config/locales/vendor/simple_form.en.yml'
  remove_file 'config/locales/simple_form.en.yml'

  comment "# Create will_paginate locale file under vendor/"
  copy_from_repo 'config/locales/vendor/will_paginate.en.yml'
end