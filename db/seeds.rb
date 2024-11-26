# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts 'Creating users'
User.destroy_all
List.destroy_all
Reminder.destroy_all
Task.destroy_all

morgane = User.create!(
  username: 'Morgane',
  email: 'morgane87@taskit.fr',
  password: 'azerty',
)

jb = User.create!(
  username: 'JB',
  email: 'jb33@taskit.fr',
  password: 'azerty',
)

thib = User.create!(
  username: 'Thib',
  email: 'thib33@taskit.fr',
  password: 'azerty',
)

dono = User.create!(
  username: 'Dono',
  email: 'dono@taskit.fr',
  password: 'azerty',
)

puts 'Finished!'
p "Created #{User.count} users"



puts 'Creating lists'
list = List.create!(
  name: 'Leclerc',
  category: 'Courses',
  user: ,
)

list = List.create!(
  name: 'Ski',
  category: 'Vacances',
  user_id: 2,
)

list = List.create!(
  name: 'Bricolage',
  category: 'Maison',
  user_id: 3,
)

list = List.create!(
  name: 'Impôts',
  category: 'Administratif',
  user_id: 4,
)

puts 'Finished!'
p "Created #{List.count} lists"



puts 'Creating reminders'

reminder = Reminder.create!(
  end_date: "12/06/2024 17:00",
  description: 'RDV Dr Papax',
  user_id: 1,
)

reminder = Reminder.create!(
  end_date: "12/06/2024 22:00",
  description: 'Récupérer colis',
  user_id: 2,
)

reminder = Reminder.create!(
  end_date: "12/08/2024 11:00",
  description: 'Acheter fleurs',
  user_id: 3,
)

reminder = Reminder.create!(
  end_date: "12/10/2024 09:00",
  description: 'Récupérer Kévin',
  user_id: 4,
)

reminder = Reminder.create!(
  end_date: "12/06/2024 09:00",
  description: 'Déposer colis',
  user_id: 1,
)

reminder = Reminder.create!(
  end_date: "12/08/2024 15:00",
  description: 'Acheter fleurs',
  user_id: 1,
)

reminder = Reminder.create!(
  end_date: "12/13/2024 11:30",
  description: 'Arroser plantes',
  user_id: 1,
)

puts 'Finished!'
p "Created #{Reminder.count} reminders"



puts 'Creating tasks'

task = Task.create!(
  label: "Oeufs",
  list_id: 1,
)

task = Task.create!(
  label: "Tomates",
  list_id: 1,
)

task = Task.create!(
  label: "Salade",
  list_id: 1,
)

task = Task.create!(
  label: "Entrecôte",
  list_id: 1,
)

task = Task.create!(
  label: "Pizza",
  list_id: 1,
)

task = Task.create!(
  label: "Louer skis",
  list_id: 2,
)

task = Task.create!(
  label: "Acheter forfait",
  list_id: 2,
)

task = Task.create!(
  label: "Repeindre cuisine",
  list_id: 2,
)

task = Task.create!(
  label: "Tondre pelouse",
  list_id: 2,
)

puts 'Finished!'
p "Created #{Task.count} tasks"
