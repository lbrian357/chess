#!/bin/bash

#creates GEMFILE
echo -e "source 'https://rubygems.org'\n
gem 'rspec'" > Gemfile

#make filesystem
mkdir spec
mkdir lib

#executes GEMFILE
bundle install --path .bundle

#message
printf "script done\n run 'bundle exec rspec' to test\n"
