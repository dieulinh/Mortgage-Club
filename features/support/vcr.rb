require "vcr"

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir     = "features/cassettes"
  c.default_cassette_options = {record: :new_episodes}
end

VCR.cucumber_tags do |t|
  t.tag "@vcr"
  t.tag "@vcr-select-rates"
  t.tag "@vcr-full-contact-api"
end
