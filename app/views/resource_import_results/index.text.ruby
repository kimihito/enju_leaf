CSV.generate(col_sep: "\t", row_sep: "\r\n") do |csv|
  @resource_import_results.each do |result|
    csv << result.body.split("\t")
  end
end
