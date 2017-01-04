json.array!(@reports) do |report|
  json.extract! report, :id, :article
  json.photo image_path(report.image_url)
  json.url report_url(report, format: :json)
end
