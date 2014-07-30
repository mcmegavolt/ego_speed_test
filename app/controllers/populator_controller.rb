class PopulatorController < ApplicationController

	def populate

		# Collect params
		users_count = params[:users].to_i
		records_count = params[:records].to_i
		comments_count = params[:comments].to_i
		
		# How many records to create for each user
		records_to_create = records_count/users_count
		# How many comments to create for each record
		comments_to_create = comments_count/records_to_create
		
		records_created = 0
		comments_created = 0


		# First creating users
		new_users = []
		users_count.times do
			new_user = User.create name: Faker::Name.name, login: Faker::Internet.user_name
			new_users << new_user
		end

		
		# Creating records for each new user
		new_users.each do |user|
			
			records_to_create.times do
				# Create record for current user
				record = user.records.create  title: Faker::Name.title, body: Faker::Lorem.paragraph(10..15)
				records_created += 1

				# Set how many comments to create for this record
				comments_to_create = comments_count/records_to_create

				# Create root comments
				root_comments = []
				comments_to_create.times do
					comment = record.comments.create body: Faker::Lorem.paragraph(1..3) + " (root)", user_id: new_users.sample.id
					root_comments << comment
					comments_created += 1
				end

				# Create child comments
				comments_to_create -= comments_created
				root_comments.each do |root|
					1..2.times do
						child_root = root.child_comments.create body: Faker::Lorem.paragraph(1..3) + " (child)", user_id: new_users.sample.id, record_id: record.id
						comments_created += 1
						1..2.times do
							second_child_root = child_root.child_comments.create body: Faker::Lorem.paragraph(1..3) + " (child)", user_id: new_users.sample.id, record_id: record.id
							comments_created += 1
							# 1..2.times do
							# 	second_child_root.child_comments.create body: Faker::Lorem.paragraph(1..3) + " (child)", user_id: new_users.sample.id, record_id: record.id
							# 	comments_created += 1
							# end
						end
					end
				end
				
			end

		end

		flash[:success] = "Populated with #{params[:users]} users, #{records_created} records and #{comments_created} comments"
		redirect_to root_url

	end

	def new
	end

	def drop
		if User.destroy_all
			flash[:success] = "Database was dropped succesfully."
		else
			flash[:error] = "Can't drop it, sorry :("
		end
		redirect_to root_url
	end

end
