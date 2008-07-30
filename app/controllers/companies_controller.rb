class CompaniesController < ApplicationController  
  
  # GET /companies
  def index
    @companies = Job.companies_count
  end
  
  # GET /jobs_at/1
  def jobs_at
    @company = Job.find_company(params[:company])
    @jobs = @company ? Job.find_all_by_company(@company) : nil
  end
end
