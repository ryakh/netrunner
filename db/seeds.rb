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
  { name: 'Ken "Express" Tenma: Disappeared Clone',      faction_id: criminal.id },
  { name: 'Laramy Fisk: Savvy Investor',                 faction_id: criminal.id },
  { name: 'Silhouette: Stealth Operative',               faction_id: criminal.id },
  { name: 'Chaos Theory: Wünderkind',                    faction_id: shaper.id },
  { name: 'Exile: Streethawk',                           faction_id: shaper.id },
  { name: 'Kate "Mac" McCaffrey: Digital Tinker',        faction_id: shaper.id },
  { name: 'Rielle "Kit" Peddler: Transhuman',            faction_id: shaper.id },
  { name: 'The Professor: Keeper of Knowledge',          faction_id: shaper }
]

identities.each do |identity|
  Identity.create(identity)
end
