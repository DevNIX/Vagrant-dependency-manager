#!/usr/bin/ruby
# @Author: Dev_NIX
# @Date:   2016-03-07 14:24:11
# @Last Modified by:   Dev_NIX
# @Last Modified time: 2016-03-07 16:36:38

def check_plugins(dependencies)
	if ['up', 'reload'].include? ARGV[0]
		installed_dependencies = []

		puts "\033[1m" << "Checking dependencies..." << "\e[0m"

		raw_output = `vagrant plugin list`
		raw_list = raw_output.split("\n")

		raw_list.each do |plugin| 
			if plugin.index("\e[0m") != nil
				first = plugin.index("\e[0m")  + 4
			else
				first = 0
			end
			installed_dependencies.push plugin.slice((first)..(plugin.index("(")-1)).strip
		end

		no_missing = false

		dependencies.each_with_index do |dependency, index|
			if not installed_dependencies.include? dependency
				puts "\033[33m" << " - Missing '#{dependency}'!" << "\e[0m"
				if not system "vagrant plugin install #{dependency}"
					puts "\n\033[33m" << " - Could not install plugin '#{dependency}'. " << "\e[0m\033[41m" <<"Stopped." << "\e[0m"
					exit -1
				end

				if no_missing == nil
					no_missing = false
				end
			else
				if no_missing == nil
					no_missing = true
				end
			end
		end

		if no_missing
			puts "\033[1m\033[36m" << " - All dependencies already satisfied" << "\e[0m"
		else
			puts "\033[1m\033[32m" << " - Dependencies installed" << "\e[0m"
		end
	end
end
