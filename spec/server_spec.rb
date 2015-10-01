require "spec_helper"


RSpec.describe Server do
	let(:env_success){ 
		latex = "\\frac{a}{b}"
		env = {}
		env["PATH_INFO"] = "http://localhost:8080/formula/#{URI::encode(latex)}/size/5"
		env
	}

	let(:env_with_slash){ 
		latex = "a/b"
		env = {}
		env["PATH_INFO"] = "http://localhost:8080/formula/#{URI::encode(latex)}/size/5"
		env
	}

	let(:env_with_dollar){ 
		latex = "\\$10,00"
		env = {}
		env["PATH_INFO"] = "http://localhost:8080/formula/#{URI::encode(latex)}/size/5"
		env
	}

	let(:env_error){ 
		latex = "\\frac{a"
		env = {}
		env["PATH_INFO"] = "http://localhost:8080/formula/#{URI::encode(latex)}/size/5"
		env
	}



	subject{ Server.new } 

	it "\\frac{a}{b}" do
	 expect(subject.call(env_success).first).to eq 200
	end

	it "a/b" do
		expect(subject.call(env_with_slash).first).to eq 200
	end

	it "\\$10,00" do
		debugger
		expect(subject.call(env_with_dollar).first).to eq 200
	end

	it "\\frac{a" do
		expect(subject.call(env_error).first).to eq 422
	end

end