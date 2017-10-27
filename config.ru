ROOT =  File.dirname __FILE__
require 'rubygems'
require 'rack'
#require 'byebug'
require "latex_to_png"
require "#{ROOT}/server"

Env = ENV['RACK_ENV'] || 'development'
run Server.new Env
