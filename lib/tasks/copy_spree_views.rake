namespace :spree do
  desc "Copy Spree Admin and Storefront views to app/views"
  task copy_views: :environment do
    gems = {
      "spree_admin" => "5.0.2",
      "spree_storefront" => "5.0.0"
    }

    gems.each do |gem_name, version|
      source_path = Bundler.rubygems.gem_dir + "/gems/#{gem_name}-#{version}/app/views/"
      dest_path = Rails.root.join("app/views")

      puts "Copying views from #{source_path} to #{dest_path}"
      FileUtils.cp_r(Dir.glob("#{source_path}*"), dest_path, verbose: true)
    end

    puts "Done!"
  end
end
