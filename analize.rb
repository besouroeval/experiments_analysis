#!/usr/bin/ruby

puts

besouro_dir = ARGV[0] + ".besouro/"

session_dirs = Dir.entries(besouro_dir)
session_dirs.delete(".")
session_dirs.delete("..")

session_dir = session_dirs[0]

actions_file = besouro_dir + session_dir + "/actions.txt"
zorro_file = besouro_dir + session_dir + "/zorroEpisodes.txt"
disagreements_file = besouro_dir + session_dir + "/disagreements.txt"

disagreements_count = 0
episodes_count = 0

File.open(disagreements_file) do |disagreements|
		
	while dis_line = disagreements.gets
		disagreement_fields = dis_line.split(" ")

		episodes_count = 0
		File.open(zorro_file) do |zorros|
			
			while zorro_line = zorros.gets
				
				episodes_count +=1
				zorro_fields = zorro_line.split(" ")
			
				if (zorro_fields[0] == disagreement_fields[0])
				
					if (zorro_fields[1] != disagreement_fields[1] or zorro_fields[4] != disagreement_fields[4])
						puts "  #{zorro_fields[0]}: actual disagreement #{zorro_fields[1]}/#{zorro_fields[4]} ~~~ #{disagreement_fields[1]}/#{disagreement_fields[4]}"
						disagreements_count += 1
					end
				
				end
			
			end
			
		end
		
	end
		

end

puts
puts "  Total episodes: #{episodes_count}"
puts "  Total disagreements: #{disagreements_count}"

File.open(actions_file) do |f|
	first_line = f.gets
	
	t0 = first_line.split(" ")[1].to_i
	
	last_line = nil
	
	while line = f.gets
		last_line = line
	end
	
	tf = last_line.split(" ")[1].to_i
	
	puts "  Total time: #{(tf-t0)/1000.0} seconds"
	
end

puts 

