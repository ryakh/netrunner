require 'csv'
require 'date'

hb       = Faction.create(name: 'Haas-Bioroid',       is_corporation: true)
jinteki  = Faction.create(name: 'Jinteki',            is_corporation: true)
nbn      = Faction.create(name: 'NBN',                is_corporation: true)
weyland  = Faction.create(name: 'Weyland Consorioum', is_corporation: true)
anarch   = Faction.create(name: 'Anarch',             is_runner:      true)
criminal = Faction.create(name: 'Criminal',           is_runner:      true)
shaper   = Faction.create(name: 'Shaper',             is_runner:      true)

identities = [
  { name: 'Cerebral Imaging: Infinite Frontiers',        faction_id: hb.id },
  { name: 'Custom Biotics: Engineered for Success',      faction_id: hb.id },
  { name: 'Haas-Bioroid: Engineering the Future',        faction_id: hb.id },
  { name: 'Haas-Bioroid: Stronger Together',             faction_id: hb.id },
  { name: 'NEXT Design: Guarding the Net',               faction_id: hb.id },
  { name: 'Jinteki: Personal Evolution',                 faction_id: jinteki.id },
  { name: 'Jinteki: Replicating Perfection',             faction_id: jinteki.id },
  { name: 'Harmony Medtech: Biomedical Pioneer',         faction_id: jinteki.id },
  { name: 'Nisei Division: The Next Generation',         faction_id: jinteki.id },
  { name: 'Tennin Institute: The Secrets Within',        faction_id: jinteki.id },
  { name: 'NBN: Making News',                            faction_id: nbn.id },
  { name: 'NBN: The World is Yours*',                    faction_id: nbn.id },
  { name: 'GRNDL: Power Unleashed',                      faction_id: weyland.id },
  { name: 'Weyland Consortium: Because We Built It',     faction_id: weyland.id },
  { name: 'Weyland Consortium: Building a Better World', faction_id: weyland.id },
  { name: 'Noise: Hacker Extraordinaire',                faction_id: anarch.id },
  { name: 'Reina Roja: Freedom Fighter',                 faction_id: anarch.id },
  { name: 'Whizzard: Master Gamer',                      faction_id: anarch.id },
  { name: 'Andromeda: Dispossessed Ristie',              faction_id: criminal.id },
  { name: 'Gabriel Santiago: Consummate Professional',   faction_id: criminal.id },
  { name: 'Iain Stirling: Retired Spook',                faction_id: criminal.id },
  { name: 'Ken “Express” Tenma: Disappeared Clone',      faction_id: criminal.id },
  { name: 'Laramy Fisk: Savvy Investor',                 faction_id: criminal.id },
  { name: 'Silhouette: Stealth Operative',               faction_id: criminal.id },
  { name: 'Chaos Theory: Wünderkind',                    faction_id: shaper.id },
  { name: 'Exile: Streethawk',                           faction_id: shaper.id },
  { name: 'Kate “Mac” McCaffrey: Digital Tinker',        faction_id: shaper.id },
  { name: 'Rielle “Kit” Peddler: Transhuman',            faction_id: shaper.id },
  { name: 'The Professor: Keeper of Knowledge',          faction_id: shaper.id }
]

users = [
  { fullname: 'Konco',    email: 'konco@netrunner.io' },
  { fullname: 'David',    email: 'david@netrunner.io' },
  { fullname: 'Peekay',   email: 'peekay@netrunner.io', is_judge: true },
  { fullname: 'Miro',     email: 'miro@netrunner.io' },
  { fullname: 'Lubo',     email: 'lubo@netrunner.io' },
  { fullname: 'Peta',     email: 'peta@netrunner.io' },
  { fullname: 'Mato',     email: 'mato@netrunner.io' },
  { fullname: 'Noro',     email: 'noro@netrunner.io' },
  { fullname: 'Zdeno',    email: 'zdeno@netrunner.io' },
  { fullname: 'Valika',   email: 'valika@netrunner.io' },
  { fullname: 'Ruslan',   email: 'ruslan@netrunner.io', is_judge: true },
  { fullname: 'Ivan',     email: 'ivan@netrunner.io' },
  { fullname: 'Silma',    email: 'silma@netrunner.io' },
  { fullname: 'Nero',     email: 'nero@netrunner.io' },
  { fullname: 'Miso',     email: 'miso@netrunner.io' },
  { fullname: 'Jakub',    email: 'jakub@netrunner.io' },
  { fullname: 'Mino',     email: 'mino@netrunner.io' },
  { fullname: 'Konco',    email: 'konco@netrunner.io' },
  { fullname: 'Dusan',    email: 'dusan@netrunner.io' },
  { fullname: 'Brano',    email: 'brano@netrunner.io' },
  { fullname: 'Laco',     email: 'laco@netrunner.io' },
  { fullname: 'Celo',     email: 'celo@netrunner.io' },
  { fullname: 'Veronika', email: 'veronika@netrunner.io' }
]

identities.each do |identity|
  Identity.create(identity)
end

users.each do |user|
  user[:password] = 'password'
  User.create(user)
end

class MatchSeeder
  def self.set_event(date, season)
    played_on = date.to_datetime
    started_at = played_on.beginning_of_week
    finished_at = played_on.end_of_week

    guessed_event = Event.find_by(started_at: started_at, finished_at: finished_at)

    if guessed_event.nil?
      event = Event.create(
        season: season,
        started_at: started_at,
        finished_at: finished_at,
        is_closed: true
      )
    else
      event = guessed_event
    end

    return event
  end
end

seasons = %w(season_1 season_2 season_3 season_4)

seasons.each do |s|
  season = Season.create(name: s.gsub('_', ' ').capitalize, is_active: true)
  puts "Creating #{s}"

  csv_text = File.read("db/seeds/#{s}.csv")

  csv = CSV.parse(csv_text, headers: false)
  csv.each do |row|
    match = row[0].split(';')
    puts "Creating match: #{row}"
    event = MatchSeeder.set_event(Date::strptime(match[0], '%d/%m/%y'), season)

    match = Match.create(
      played_on:                        Date::strptime(match[0], '%d/%m/%y'),
      first_player_id:                  User.find_by(fullname: match[1]).id,
      second_player_id:                 User.find_by(fullname: match[2]).id,
      first_player_corporation_id:      Identity.find_by(name: match[3]).id,
      second_player_runner_id:          Identity.find_by(name: match[4]).id,
      first_player_corporation_points:  match[5].to_i,
      second_player_runner_points:      match[6].to_i,
      first_player_runner_id:           Identity.find_by(name: match[7]).id,
      second_player_corporation_id:     Identity.find_by(name: match[8]).id,
      first_player_runner_points:       match[9].to_i,
      second_player_corporation_points: match[10].to_i
    )

    match.update_attribute(:event_id, event.id)
    match.save
  end

  season.events.order('finished_at ASC').each do |event|
    event.generate_standings
  end

  season.close
  puts "========================================"
end
