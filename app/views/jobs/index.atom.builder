atom_feed do |feed|
  feed.title(AppConfig.site_name)
  unless @jobs.empty?
    feed.updated((@jobs.first.created_at))
  end

  @jobs.each do |job|
    feed.entry(job) do |entry|
      entry.title(job.feed_title.to_s)
      entry.content(job.feed_html+apply_html(job), :type => 'html')
    end
  end
end