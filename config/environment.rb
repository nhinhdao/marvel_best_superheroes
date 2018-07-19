require 'bundler'
Bundler.require
require 'pry'
require 'nokogiri'
require 'open-uri'
require 'colorize'

require_relative '../lib/marvel_best_superheroes/version'
require_relative '../lib/marvel_best_superheroes/scraper'
require_relative '../lib/marvel_best_superheroes/cli'
require_relative '../lib/marvel_best_superheroes/superhero'
