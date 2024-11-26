# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

Task.destroy_all
List.destroy_all
Reminder.destroy_all
User.destroy_all

puts 'Creating users'

Morgane = User.create!(
  username: 'Morgane',
  email: 'morgane87@taskit.fr',
  password: 'azerty',
)

JB = User.create!(
  username: 'JB',
  email: 'jb33@taskit.fr',
  password: 'azerty',
)

Thib = User.create!(
  username: 'Thib',
  email: 'thib33@taskit.fr',
  password: 'azerty',
)

Dono = User.create!(
  username: 'Dono',
  email: 'dono@taskit.fr',
  password: 'azerty',
)

puts 'Finished!'
p "Created #{User.count} users"

puts 'Creating lists'

Leclerc = List.create!(
  name: 'Leclerc',
  category: 'Courses',
  user_id: Morgane.id,
)

Ski = List.create!(
  name: 'Ski',
  category: 'Vacances',
  user_id: JB.id,
)

Bricolage = List.create!(
  name: 'Bricolage',
  category: 'Maison',
  user_id: Thib.id,
)

Impôts = List.create!(
  name: 'Impôts',
  category: 'Administratif',
  user_id: Dono.id,
)

puts 'Finished!'
p "Created #{List.count} lists"

puts 'Creating reminders'

reminder = Reminder.create!(
  end_date: "12/06/2024 17:00",
  description: 'RDV Dr Papax',
  user_id: Morgane.id,
)

reminder = Reminder.create!(
  end_date: "12/06/2024 22:00",
  description: 'Récupérer colis',
  user_id: JB.id,
)

reminder = Reminder.create!(
  end_date: "12/08/2024 11:00",
  description: 'Acheter fleurs',
  user_id: Thib.id,
)

reminder = Reminder.create!(
  end_date: "12/10/2024 09:00",
  description: 'Récupérer Kévin',
  user_id: Dono.id,
)

reminder = Reminder.create!(
  end_date: "12/06/2024 09:00",
  description: 'Déposer colis',
  user_id: Morgane.id,
)

reminder = Reminder.create!(
  end_date: "12/08/2024 15:00",
  description: 'Acheter fleurs',
  user_id: Morgane.id,
)

reminder = Reminder.create!(
  end_date: "12/13/2024 11:30",
  description: 'Arroser plantes',
  user_id: Morgane.id,
)

puts 'Finished!'
p "Created #{Reminder.count} reminders"

puts 'Creating tasks'

task = Task.create!(
  label: "Oeufs",
  list_id: Leclerc.id,
)

task = Task.create!(
  label: "Tomates",
  list_id: Leclerc.id,
)

task = Task.create!(
  label: "Salade",
  list_id: Leclerc.id,
)

task = Task.create!(
  label: "Entrecôte",
  list_id: Leclerc.id,
)

task = Task.create!(
  label: "Pizza",
  list_id: Leclerc.id,
)

task = Task.create!(
  label: "Louer skis",
  list_id: Ski.id,
)

task = Task.create!(
  label: "Acheter forfait",
  list_id: Ski.id,
)

task = Task.create!(
  label: "Repeindre cuisine",
  list_id: Bricolage.id,
)

task = Task.create!(
  label: "Tondre pelouse",
  list_id: Bricolage.id,
)

puts 'Finished!'
p "Created #{Task.count} tasks"
