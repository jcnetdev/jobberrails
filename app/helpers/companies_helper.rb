module CompaniesHelper
  def companies_tag_cloud(companies, classes)
    max, min = 0, 0
    companies.each { |t|
      max = t.count.to_i if t.count.to_i > max
      min = t.count.to_i if t.count.to_i < min
    }

    divisor = ((max - min) / classes.size) + 1

    companies.each { |t|
      yield t.name, t.count, url_encode(t.name), classes[(t.count.to_i - min) / divisor]
    }

  end
end
