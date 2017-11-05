ROOT =  File.dirname __FILE__
require 'rubygems'
require 'rack'
require "latex_to_png"
require "newrelic_rpm"
require "./server"

GC::Profiler.enable


Env = ENV['RACK_ENV'] || 'development'
run Server.new Env
