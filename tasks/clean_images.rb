task :clean_images do
	puts "cleaning public/* dir"

	FileUtils.rm_r(["#{BASE_DIR}/public/formula"], :force => true)
end
