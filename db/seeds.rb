# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

Task.destroy_all
List.destroy_all
Reminder.destroy_all
User.destroy_all

puts 'Creating users'

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

leclerc = List.create!(
  name: 'Leclerc',
  category: 'courses',
  user_id: morgane.id,
)

ski = List.create!(
  name: 'Ski',
  category: 'vacances',
  user_id: jb.id,
)

bricolage = List.create!(
  name: 'Bricolage',
  category: 'maison',
  user_id: thib.id,
)

impôts = List.create!(
  name: 'Impôts',
  category: 'administratif',
  user_id: dono.id,
)

puts 'Finished!'
p "Created #{List.count} lists"

puts 'Creating reminders'

reminder = Reminder.create!(
  end_date: "06/12/2024 17:00",
  description: 'RDV Dr Papax',
  user_id: morgane.id,
)

reminder = Reminder.create!(
  end_date: "06/12/2024 09:00",
  description: 'Déposer colis',
  user_id: morgane.id,
)

reminder = Reminder.create!(
  end_date: "06/12/2024 15:00",
  description: 'Acheter fleurs',
  user_id: morgane.id,
)

reminder = Reminder.create!(
  end_date: "06/12/2024 11:30",
  description: 'Arroser jardin',
  user_id: morgane.id,
)

reminder = Reminder.create!(
end_date: "06/12/2024 09:00",
description: 'Ranger maison',
user_id: morgane.id,
)

reminder = Reminder.create!(
end_date: "02/12/2024 15:00",
description: 'Acheter fleurs',
user_id: morgane.id,
)

reminder = Reminder.create!(
end_date: "02/12/2024 11:30",
description: 'Arroser plantes',
user_id: morgane.id,
)

reminder = Reminder.create!(
  end_date: "12/06/2024 22:00",
  description: 'Récupérer colis',
  user_id: jb.id,
)

reminder = Reminder.create!(
  end_date: "02/12/2024 09:00",
  description: 'Déposer colis',
  user_id: jb.id,
)

reminder = Reminder.create!(
  end_date: "02/12/2024 17:00",
  description: 'Acheter fleurs',
  user_id: jb.id,
)

reminder = Reminder.create!(
  end_date: "02/12/2024 19:30",
  description: 'Arroser plantes',
  user_id: jb.id,
)

reminder = Reminder.create!(
  end_date: "12/08/2024 11:00",
  description: 'Acheter fleurs',
  user_id: thib.id,
)

reminder = Reminder.create!(
  end_date: "12/02/2024 09:00",
  description: 'Déposer colis',
  user_id: thib.id,
)

reminder = Reminder.create!(
  end_date: "12/02/2024 15:00",
  description: 'Acheter fleurs',
  user_id: thib.id,
)

reminder = Reminder.create!(
end_date: "12/02/2024 11:30",
description: 'Arroser plantes',
user_id: thib.id,
)

reminder = Reminder.create!(
end_date: "12/10/2024 09:00",
description: 'Récupérer Kévin',
user_id: dono.id,
)

reminder = Reminder.create!(
end_date: "12/02/2024 09:00",
description: 'Déposer colis',
user_id: dono.id,
)

reminder = Reminder.create!(
end_date: "12/02/2024 15:00",
description: 'Acheter fleurs',
user_id: dono.id,
)

reminder = Reminder.create!(
end_date: "12/02/2024 11:30",
description: 'Arroser plantes',
user_id: dono.id,
)

puts 'Finished!'
p "Created #{Reminder.count} reminders"

puts 'Creating tasks'

task = Task.create!(
label: "Oeufs",
list_id: leclerc.id,
)

task = Task.create!(
  label: "Tomates",
  list_id: leclerc.id,
)

task = Task.create!(
  label: "Salade",
  list_id: leclerc.id,
)

task = Task.create!(
  label: "Entrecôte",
  list_id: leclerc.id,
)

task = Task.create!(
  label: "Pizza",
  list_id: leclerc.id,
)

task = Task.create!(
  label: "Louer skis",
  list_id: ski.id,
)

task = Task.create!(
  label: "Acheter forfait",
  list_id: ski.id,
)

task = Task.create!(
  label: "Repeindre cuisine",
  list_id: bricolage.id,
)

task = Task.create!(
  label: "Tondre pelouse",
  list_id: bricolage.id,
)

puts 'Finished!'
p "Created #{Task.count} tasks"
