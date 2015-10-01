ROOT =  File.dirname __FILE__
require 'rubygems'
require 'rack'
#require 'byebug'
require "latex_to_png"
require "#{ROOT}/server"
require "#{ROOT}/logger"

Env = ENV['RACK_ENV'] || 'development'
Logger.env = Env
use Rack::CommonLogger,  Logger
run Server.new