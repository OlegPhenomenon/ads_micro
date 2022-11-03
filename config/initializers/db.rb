# Code execution order is important during Sequel initialization process.
# See http://sequel.jeremyevans.net/rdoc/files/doc/code_order_rdoc.html

url = 'postgresql://ads:password@localhost/ads_microservice_production'
Sequel.connect(url || Settings.db.to_hash)

Sequel::Model.db.extension(:pagination)

Sequel::Model.plugin :validation_helpers
Sequel::Model.plugin :timestamps, update_on_create: true

Sequel.default_timezone = :utc
