class Logger

	def self.env= env
		@env = env
	end

	def self.env
		@env
	end

	def self.write msg
      file = File.new("log/#{self.env}.log","a")
      file.write msg
      file.close
	end
end