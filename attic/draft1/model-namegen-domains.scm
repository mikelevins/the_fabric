;;;; ***********************************************************************
;;;; FILE IDENTIFICATION
;;;;
;;;; Name:          namegen-domains.scm
;;;; Project:       The Fabric: a far-future MMORPG
;;;; Purpose:       input data for the name generator
;;;; Author:        mikel evins
;;;; Copyright:     2014 by mikel evins
;;;;
;;;; ***********************************************************************

(module-export domain-name-lists)

(require 'list-lib)
(require "util-general.scm")
(require "model-frame.scm")

(define (domain-indexes) (iota 256))

(define (domain0-names)
  '("" "Adam" "Adlai" "Agatha" "Ahmed" "Alan" "Alastair" "Albert" "Alexander" "Alexis" "Alfred"
    "Alison" "Alvin" "Amanda" "Amir" "Amos" "Anatoly" "Andrea" "Andreas" "Andrew" "Angela"
    "Angus" "Anton" "Antonio" "Arne" "Arnold" "Arthur" "Audrey" "Avery" "Barbara" "Barney"
    "Barton" "Benjamin" "Benson" "Bernard" "Bertrand" "Beverly" "Bjorne" "Blaine" "Blair" "Blake"
    "Bradley" "Brandon" "Brendan" "Brent" "Bret" "Brian" "Brooke" "Bruce" "Bruno" "Bryce"
    "Caleb" "Calvin" "Carl" "Carlos" "Carol" "Carolyn" "Carsten" "Carter" "Cary" "Casey"
    "Casper" "Catherine" "Celeste" "Claire" "Clarence" "Clarissa" "Clark" "Claudia" "Claudio" "Cole"
    "Conrad" "Constantine" "Corey" "Cynthia" "Cyrus" "Donovan" "Dorothy" "Douglas" "Dylan" "Edgar"
    "Edith" "Eli" "Elias" "Elijah" "Elizabeth" "Elvis" "Elwood" "Emil" "Emily" "Emma"
    "Eric" "Ernst" "Erwin" "Ethan" "Eugene" "Eva" "Evan" "Evelyn" "Fay" "Felix"
    "Fletcher" "Florian" "Francisco" "Fred" "Fritz" "Gabriel" "Gail" "Gary" "Geoffrey" "George"
    "Giovanni" "Gordon" "Graham" "Gregor" "Heather" "Hector" "Horatio" "Howard" "Hubert" "Hugh"
    "Hunter" "Ilya" "Ira" "Isaac" "Izumi" "Janos" "Jared" "Jeremy" "Jerome" "Jesse"
    "Jin" "Jiri" "Joel" "Jonathan" "Jose" "Klaus" "Knut" "Konrad" "Laurel" "Lee"
    "Leigh" "Len" "Lester" "Lev" "Lex" "Lila" "Lindsay" "Lois" "Louis" "Louise"
    "Luc" "Lucas" "Lucius" "Luis" "Luke" "Magnus" "Manuel" "Marco" "Marcus" "Marek"
    "Margot" "Maria" "Mario" "Marlena" "Marnie" "Martha" "Martin" "Marvin" "Mason" "Matthias"
    "Max" "Michael" "Miles" "Milo" "Miriam" "Mohammad" "Molly" "Morgan" "Moses" "Myron"
    "Nanda" "Naomi" "Narendra" "Nathaniel" "Neville" "Nguyen" "Niall" "Nicholas" "Nigel" "Nils"
    "Noam" "Nora" "Oleg" "Oliver" "Omar" "Oscar" "Owen" "Pablo" "Pia" "Piet"
    "Pilar" "Prakash" "Ragnar" "Rainer" "Ram" "Ramon" "Ramsey" "Raphael" "Raul" "Ravi"
    "Ray" "Rex" "Rhys" "Roberto" "Robin" "Roland" "Roman" "Roxanne" "Rudolf" "Rupert"
    "Ruth" "Sabrina" "Sally" "Samir" "Samuel" "Sandeep" "Sanjay" "Saul" "Sergio" "Seth"
    "Simon" "Skip" "Sofia" "Sriram" "Sunil" "Suresh" "Susan" "Takao" "Terence" "Timothy"
    "Tobias" "Valentin" "Valerie" "Victoria" "Vijay" "Vinod" "Vladimir" "Walter" "Wendy" "Wilhelm"
    "William" "Winifred" "Winston" "Wolfgang" "Woody"))

(define (domain1-names) (domain-indexes))

(define (domain2-names)
  '("" "Almond" "Amaranth" "Amber" "Apple" "Apricot" "Aqua" "Aquamarine" "Artichoke" "Asparagus" "Auburn"
    "Avocado" "Azure" "Banana" "Bazaar" "Beaver" "Beef" "Beige" "Bisque" "Bistre" "Bitter" "Bittersweet"
    "Black" "Bland" "Blonde" "Blue" "Blueberry" "Bluebonnet" "Blush" "Bole" "Bone" "Boysenberry" "Brassy"
    "Brick" "Bronzed" "Brown" "Butter" "Buff" "Burgundy" "Cadet" "Camel" "Canary" "Capri" "Caramel" "Cardinal"
    "Carmine" "Carnelian" "Carrot" "Catawba" "Cedar" "Ceil" "Celadon" "Celery" "Cerise" "Cerulean" "Chamoisee"
    "Champagne" "Charcoal" "Chartreuse" "Cherry" "Chestnut" "Chicken" "Chocolate" "Cinereous" "Cinnabar"
    "Cinnamon" "Citron" "Claret" "Coconut" "Coffee" "Coquelicot" "Coral" "Cordovan" "Corn" "Cornflower"
    "Cornsilk" "Cream" "Crimson" "Cyan" "Daffodil" "Dandelion" "Deer" "Denim" "Desert" "Desire" "Dirt"
    "Drab" "Ebony" "Ecru" "Eggplant" "Eggshell" "Eminence" "Eucalyptus" "Fallow" "Fandango" "Fawn" "Feldgrau"
    "Fern" "Firebrick" "Fish" "Flame" "Flattery" "Flavescent" "Flax" "Flirt" "Folly" "Forest" "Fuchsia"
    "Fulvous" "Gainsboro" "Gamboge" "Ginger" "Glaucous" "Glitter" "Golden" "Goldenrod" "Grape" "Grapefruit"
    "Gray" "Green" "Grullo" "Harlequin" "Heliotrope" "Honeydew" "Iceberg" "Icterine" "Imperial" "Inchworm"
    "Indigo" "Iris" "Irresistible" "Isabelline" "Ivory" "Jasmine" "Jet" "Jonquil" "Keppel" "Khaki" "Kobi"
    "Lace" "Lava" "Lavender" "Lemon" "Liberty" "Licorice" "Lilac" "Lime" "Linen" "Lion" "Liver" "Livid"
    "Lumber" "Lust" "Magenta" "Magnolia" "Mahogany" "Maize" "Malt" "Manatee" "Mango" "Mantis" "Maroon"
    "Mauve" "Mauvelous" "Melon" "Mindaro" "Mint" "Moccasin" "Moss" "Mulberry" "Mustard" "Navy" "Nutmeg"
    "Nyanza" "Ochre" "Olive" "Onyx" "Orange" "Orchid" "Pansy" "Papaya" "Paprika" "Peach" "Pear" "Pearl"
    "Pepper" "Peridot" "Periwinkle" "Persimmon" "Pink" "Pistachio" "Phlox" "Pineapple" "Plum" "Powder"
    "Prune" "Puce" "Pumpkin" "Purple" "Raspberry" "Red" "Redwood" "Regalia" "Rhythm" "Rose" "Rosewood"
    "Ruber" "Rubine" "Ruddy" "Rufous" "Russet" "Rust" "Saffron" "Sage" "Salmon" "Salt" "Sand" "Sangria"
    "Scarlet" "Seashell" "Sepia" "Sienna" "Smalt" "Smoke" "Snow" "Soap" "Sour" "Strawberry" "Sweet" "Tan"
    "Tangerine" "Taupe" "Teal" "Terracotta" "Thistle" "Tomato" "Truffle" "Tulip" "Tumbleweed" "Turquoise"
    "Ultramarine" "Umber" "Urobilin" "Vanilla" "Verdigris" "Vermilion" "Veronica" "Viridian" "Violet" "Wenge"
    "Wheat" "White" "Wine" "Wintergreen" "Wisteria" "Yellow"))

(define (domain3-names)
  '("" "Actinium" "Agate" "Alabaster" "Almandine" "Aluminium" "Amalgum" "Americium" "Amethyst" "Amphibole"
    "Anthracite" "Antimony" "Argon" "Arsenic" "Astatine" "Aventurine" "Azurite" "Barite" "Barium" "Bauxite"
    "Berkelium" "Beryl" "Beryllium" "Bismuth" "Borax" "Boron" "Brass" "Bromine" "Bronze" "Cadmium" "Caesium"
    "Calcite" "Calcium" "Californium" "Carbon" "Cerium" "Chalcedony" "Chlorine" "Chlorite" "Chromite" "Chromium"
    "Chrysoberyl" "Chrysoprase" "Chrysotile" "Citrine" "Coal" "Cobalt" "Cobaltite" "Colloid" "Copper" "Corundum"
    "Cryolite" "Crystal" "Curium" "Diamond" "Diatomite" "Dolomite" "Dysprosium" "Edingtonite" "Einsteinium"
    "Electrum" "Emerald" "Emery" "Erbium" "Erythrite" "Euclase" "Eucryptite" "Europium" "Fabianite" "Feldspar"
    "Fermium" "Ferricrete" "Ferropericlase" "Fluorene" "Fluorite" "Fluorspar" "Francium" "Gadolinium" "Galaxite"
    "Galena" "Gallium" "Garnet" "Gas" "Germanium" "Glass" "Gold" "Graphite" "Gypsum" "Hafnium" "Halite"
    "Hectorite" "Heliodor" "Helium" "Hematite" "Hepatizon" "Holeum" "Holmium" "Hornblende" "Hyalite"
    "Hydrogen" "Hyperon" "Hypertriton" "Ice" "Idocrase" "Indium" "Invar" "Iodine" "Iridium" "Iron" "Jade"
    "Jasper" "Kovar" "Krypton" "Lanthanite" "Lanthanum" "Lapis" "Lazulite" "Lead" "Leucite" "Lignite"
    "Limonite" "Liquid" "Litharge" "Lithium" "Lodestone" "Lutetium" "Magma" "Magnesia" "Magnesium" "Magnetite"
    "Malachite" "Manganese" "Manganite" "Meerschaum" "Mercury" "Mesolite" "Mica" "Microcline" "Microlite"
    "Molybdenum" "Morganite" "Nacrite" "Natron" "Neodymium" "Neon" "Nephrite" "Neptunium" "Neutronium"
    "Nichrome" "Nickel" "Niobium" "Nitinol" "Nitrogen" "Oligoclase" "Olivine" "Omphacite" "Opal"
    "Orthochrysotile" "Orthoclase" "Osmium" "Oxygen" "Palladium" "Peat" "Periclase" "Petalite" "Petzite"
    "Pewter" "Phosporus" "Pitchblende" "Plasma" "Platinum" "Plutonium" "Polarite" "Polonium" "Polycrase"
    "Polyhalite" "Potash" "Potassium" "Praseodymium" "Promethium" "Protactinium" "Pumice" "Pyrite"
    "Pyrochlore" "Pyrolusite" "Pyromorphite" "Pyrope" "Pyroxene" "Quartz" "Radium" "Radon" "Rhenium"
    "Rhodium" "Rhodochrosite" "Rhodonite" "Rhomboclase" "Rubidium" "Ruby" "Ruthenium" "Rutile" "Safflorite"
    "Samarium" "Samsonite" "Sapphire" "Sard" "Scandium" "Schorl" "Selenium" "Silicon" "Silver" "Smaltite"
    "Smectite" "Smithsonite" "Soapstone" "Sodalite" "Sodium" "Solid" "Sphalerite" "Sphene" "Spinel" "Steel"
    "Sterling" "Stibnite" "Stichtite" "Strontium" "Sulfur" "Superfluid" "Talc" "Tantalite" "Tantalum"
    "Technetium" "Tellurium" "Terbium" "Tetrahedrite" "Thallium" "Thorite" "Thorium" "Thulium" "Tin"
    "Titanium" "Topaz" "Tourmaline" "Tungsten" "Tyrolite" "Uranium" "Vanadium" "Vauxite" "Vermiculite"
    "Wolframite" "Wormhole" "Xenon" "Ytterbium" "Yttrium" "Zinc" "Zircon" "Zirconium"))

(define (domain4-names)
  '("" "Accepts" "Amuses" "Announces" "Apologises" "Appears" "Appreciates" "Arranges" "Attempts" "Avoids"
    "Backs" "Bakes" "Bears" "Becomes" "Begets" "Begins" "Bleachs" "Blesses" "Blots" "Blows" "Bolts"
    "Bombs" "Boxes" "Brakes" "Bursts" "Buzzes" "Calculates" "Casts" "Charges" "Chews" "Chokes" "Claims"
    "Clips" "Coils" "Communicates" "Competes" "Completes" "Concentrates" "Consists" "Contains" "Continues"
    "Costs" "Coughs" "Counts" "Covers" "Cracks" "Creeps" "Cries" "Curls" "Cycles" "Dams" "Decays" "Decides"
    "Decorates" "Destroys" "Digs" "Disagrees" "Disarms" "Draws" "Drips" "Drives" "Drops" "Drums" "Dusts"
    "Educates" "Encourages" "Escapes" "Exercises" "Expands" "Expects" "Explains" "Explodes" "Falls" "Fastens"
    "Faxes" "Fetches" "Fills" "Fires" "Flees" "Flies" "Follows" "Forgets" "Forsakes" "Founds" "Frames"
    "Frightens" "Fries" "Glows" "Glues" "Grabs" "Greets" "Grips" "Groans" "Hands" "Handles" "Hangs" "Happens"
    "Harasses" "Has" "Hews" "Hits" "Holds" "Hovers" "Hugs" "Hums" "Improves" "Injects" "Interests" "Invents"
    "Itches" "Jokes" "Judges" "Juggles" "Kisses" "Knits" "Launches" "Lends" "Levels" "Licenses" "Lightens"
    "Lists" "Locks" "Makes" "Marks" "Matches" "Means" "Measures" "Moors" "Moves" "Nails" "Needs" "Nods"
    "Observes" "Offers" "Orders" "Overflows" "Paddles" "Pastes" "Pats" "Peels" "Pinches" "Pines" "Places"
    "Pokes" "Polishes" "Prays" "Preaches" "Precedes" "Prepares" "Presses" "Pretends" "Promises" "Proves"
    "Pulls" "Punctures" "Punishes" "Queues" "Rains" "Raises" "Reaches" "Receives" "Records" "Rejoices"
    "Relies" "Remembers" "Reminds" "Removes" "Repeats" "Reports" "Retires" "Rides" "Rings" "Risks" "Ruins"
    "Rules" "Scares" "Scatters" "Scolds" "Scratches" "Scrubs" "Seals" "Sees" "Settles" "Sews" "Shears"
    "Shocks" "Shoots" "Shows" "Shrugs" "Sighs" "Sings" "Sits" "Slays" "Sleeps" "Slings" "Slows" "Snatches"
    "Sneaks" "Sneezes" "Sniffs" "Sows" "Spares" "Sparkles" "Speeds" "Spreads" "Squeals" "Stands" "Stares"
    "Staves" "Stays" "Steers" "Steps" "Straps" "Stretches" "Strews" "Strikes" "Strips" "Strives" "Strokes"
    "Supplies" "Suspends" "Sweats" "Takes" "Talks" "Taps" "Teaches" "Tears" "Telephones" "Terrifies" "Thinks"
    "Times" "Tips" "Tugs" "Turns" "Unlocks" "Unpacks" "Ups" "Visits" "Walks" "Wants" "Warms" "Waters" "Weds"
    "Weeps" "Whistles" "Wins" "Winks" "Wipes" "Wishes" "Wobbles" "Works" "Worries" "Wraps" "Wriggles" "Writes"
    "Zips")) 

(define (domain5-names)
  '("" "Alcyone" "Aldebaran" "Algol" "Alioth" "Alkaid" "Altair" "Amphitrite" "Andromeda" "Antares"
    "Aquarius" "Arcturus" "Ariel" "Aries" "Atlas" "Aurora" "Bellatrix" "Betelgeuse" "Bootes" "Callisto"
    "Cancer" "Canopus" "Capella" "Capricornus" "Cassiopeia" "Castor" "Centaurus" "Cepheus" "Ceres" "Cetus"
    "Columba" "Corvus" "Cybele" "Cygnus" "Cynosure" "Delphinus" "Deneb" "Dione" "Draco" "Earth" "Electra"
    "Enceladus" "Epimetheus" "Eridanus" "Eris" "Eugenia" "Eunomia" "Euphrosyne" "Europa" "Fomalhaut" "Fornax"
    "Fortuna" "Ganymede" "Gemini" "Giedi" "Haumea" "Hebe" "Hektor" "Hercules" "Hermione" "Hydra" "Hygeia"
    "Hyperion" "Iapetus" "Io" "Istanbul" "Ixion" "Janus" "Juno" "Jupiter" "Lacerta" "Lachesis" "Leo" "Libra"
    "Luna" "Lupus" "Lyra" "Maia" "Makemake" "Markab" "Mars" "Metis" "Mimas" "Miranda" "Mizar" "Monoceros"
    "Nemesis" "Neptune" "Oberon" "Octans" "Ophiucus" "Orcus" "Orion" "Pallas" "Pegasus" "Perseus" "Phoebe"
    "Phoenix" "Pictor" "Pisces" "Pleione" "Pluto" "Polaris" "Pollux" "Procyon" "Prometheus" "Propus"
    "Proteus" "Psyche" "Ptolemy" "Pyxis" "Quaoar" "Rana" "Regulus" "Reticulum" "Rhea" "Rigel" "Sagittarius"
    "Saturn" "Scorpius" "Scutum" "Sedna" "Serpens" "Sextans" "Sirius" "Taurus" "Tethys" "Themis" "Thisbe"
    "Titan" "Titania" "Triangulum" "Trifid" "Triton" "Tucana" "Umbriel" "Uranus" "Ursula" "Vanth" "Varuna"
    "Vega" "Venus" "Vesta" "Virgo" "Asia" "Europe" "Africa" "America" "Antarctica" "Australia" "Afghanistan"
    "Albania" "Algeria" "Argentina" "Armenia" "Belgium" "Belize" "Brazil" "Burma" "Cameroon" "Canada" "China"
    "Colombia" "Cyprus" "Denmark" "Djibouti" "Ecuador" "Egypt" "Ethiopia" "Fiji" "Finland" "France" "Germany"
    "Greece" "Guatemala" "Haiti" "Hungary" "Iceland" "Ireland" "Italy" "Jamaica" "Japan" "Jordan" "Kenya"
    "Latvia" "Lithuania" "Macedonia" "Madagascar" "Malta" "Mexico" "Mongolia" "Morocco" "Namibia" "Nauru"
    "Nepal" "Norway" "Oman" "Peru" "Poland" "Portugal" "Romania" "Russia" "Serbia" "Singapore" "Somalia"
    "Sweden" "Switzerland" "Spain" "Syria" "Tanzania" "Tunisia" "Turkey" "Uruguay" "Uzbekistan" "Vanuatu"
    "Venezuela" "Yemen""Zambia" "Zimbabwe" "Amsterdam" "Athens" "Beijing" "Berlin" "Boston" "Budapest"
    "Cairo" "Cardiff" "Chicago" "Copenhagen" "Dallas" "Denver" "Dublin" "Edinburgh" "Helsinki" "Johannesburg"
    "Kiev" "London" "Minneapolis" "Monaco" "Montreal" "Moscow" "Nairobi" "Oslo" "Paris" "Philadelphia"
    "Prague" "Rome" "Seattle" "Stockholm" "Sydney" "Tokyo" "Toronto" "Tulsa" "Vienna" "Warsaw" "Zagreb"))

(define (domain6-names)
  '("" "Abnormally" "Absentmindedly" "Actively" "Advanced" "Adventurous" "Affectionate" "Agitated"
    "Agonizing" "Agreeable" "Alienated" "Altruistic" "Always" "Amazingly" "Anchored" "Arctic" "Around"
    "Artistic" "Athletic" "Authentic" "Bare" "Barely" "Bashfully" "Bewilderingly" "Bewitched"
    "Boastfully" "Bogus" "Brazen" "Brutally" "Carefully" "Charmingly" "Cheap" "Cheerful" "Clumsily"
    "Clumsy" "Colorless" "Colossal" "Commonly" "Completely" "Concerned" "Confused" "Corny" "Crazily"
    "Customarily" "Dangerously" "Dapper" "Darkly" "Decently" "Defiant" "Definitive" "Delectable"
    "Descriptive" "Discrete" "Disfigured" "Docilely" "Droopy" "Efficiently" "Elderly" "Embellished"
    "Eminent" "Enchanted" "Enough" "Equal" "Equally" "Even" "Exalted" "Excitable" "Extra"
    "Extraordinarily" "Fair" "False" "Few" "Fickle" "Flaky" "Flawed" "Flowery" "Fluid" "Fond"
    "Forked" "Formally" "Frankly" "Fresh" "Frilly" "Frozen" "Fully" "Gentle" "Genuinely" "Glaring"
    "Gleeful" "Glittering" "Gracious" "Granular" "Grim" "Grimy" "Grimly" "Gripping" "Grubby"
    "Gruesome" "Handily" "Harsh" "Healthily" "Hence" "High" "Ideal" "Ill" "Imaginary" "Immeasurably"
    "Imperturbable" "Impolite" "Impressionable" "Incorrectly" "Infinite" "Informal" "Innocently"
    "Insubstantial" "Intelligently" "Intensely" "Internally" "Invariably" "Invisibly" "Inwardly"
    "Irritably" "Jittery" "Joyfully" "Jumbo" "Justly" "Knowledgeably" "Kosher" "Last" "Lazily"
    "Leading" "Left" "Legitimate" "Limping" "Limply" "Lonely" "Long" "Longingly" "Lopsided" "Loud"
    "Lovely" "Lovingly" "Luminous" "Mealy" "Meaningfully" "Medical" "Medium" "Miserable" "Monstrous"
    "Naturally" "Neighboring" "Nightly" "Nonstop" "Normal" "Notable" "Noteworthy" "Nowadays" "Obediently"
    "Obligingly" "Oblong" "Obnoxiously" "Offbeat" "Old" "Only" "Orderly" "Outgoing" "Overjoyed" "Overseas"
    "Paradoxically" "Parched" "Patiently" "Pensive" "Pessimistic" "Physical" "Plaintive" "Powerless"
    "Proper" "Properly" "Puzzlingly" "Quaint" "Qualified" "Questionable" "Questioningly" "Quintessential"
    "Radiant" "Reassuringly" "Recent" "Remorseful" "Repentant" "Reponsibly" "Restfully" "Rigidly" "Robust"
    "Rotten" "Satisfied" "Scarce" "Scarily" "Secret" "Serene" "Several" "Shadowy" "Shakily" "Shoddy"
    "Sincerely" "Skeletal" "Slow" "Slushy" "Snarling" "Solely" "Somber" "Somewhere" "Sorrowful" "Sparse"
    "Spasmodically" "Specifically" "Splendidly" "Sporadically" "Stained" "Strident" "Striped" "Strong"
    "Stupidly" "Superficial" "Supremely" "Svelte" "Systematically" "Tasty" "Taut" "Tepidly" "Terrible"
    "That" "This" "Tired" "Traumatic" "Trustworthy" "Ultimately" "Untrue" "Utilized" "Villainous"
    "Visually" "Vivid" "Webbed" "Weighty" "When" "Where" "Which" "While" "Whirlwind" "Wide" "Wilted"
    "Winged" "Wiry" "Wonderful" "Worthy" "Wry" "Yesterday"))

(define (domain7-names)
  '("" "Abbott" "Abelson" "Ackermann" "Adler" "Aho" "Alcubierre" "Ambrose" "Amdahl" "Ampère" "Appel"
    "Archimedes" "Aristarchus" "Aristotle" "Avogadro" "Babbage" "Backus" "Becquerel" "Bell" "Benthem"
    "Bernays" "Berners-Lee" "Bernoulli" "Bernstein" "Bernus" "Boehm" "Bohm" "Bohr" "Boltzmann" "Booch"
    "Boole" "Bose" "Bosscha" "Bothe" "Bouchet" "Bourbaki" "Bourne" "Bowen" "Boyer" "Boyle" "Bresenham"
    "Brooks" "Butler" "Campbell" "Cantor" "Cardelli" "Carnap" "Carroll" "Casimir" "Cavendish" "Cerf"
    "Chadwick" "Chaitin" "Chamberlain" "Chandra" "Chandrasekhar" "Chrysippus" "Church" "Cicero" "Clausius"
    "Colmerauer" "Compton" "Coriolis" "Coulomb" "Cox" "Cray" "Curie" "Curry" "Dalton" "Darwin" "Democritus"
    "Denning" "Diffie" "Dijkstra" "Diogenes" "Dirac" "Doppler" "Dyson" "Eccles" "Eddington" "Edison" "Eich"
    "Eigen" "Einstein" "Elkins" "Engelbart" "Epictetus" "Euler" "Eötvös" "Fahlman" "Fahrenheit" "Faraday"
    "Feigenbaum" "Feinberg" "Fermi" "Feynman" "Field" "Fine" "Finkel" "Foucault" "Fourier" "Franklin" "Franz"
    "Freud" "Frege" "Fresnel" "Gabbay" "Gauss" "Geiger" "Gelernter" "Gibbons" "Goddard" "Goldberg"
    "González" "Gosling" "Griswold" "Guha" "Gödel" "Hall" "Hamilton" "Harrington" "Hawking" "Hegel"
    "Heisenberg" "Helmholtz" "Hertz" "Hewitt" "Higgs" "Hilbert" "Hindley" "Hoare" "Hofstadter" "Holzmann"
    "Hooke" "Hopper" "Hoyle" "Hubble" "Huffman" "Hume" "Huxley" "Huygens" "Ingalls" "Iverson" "Jacobson"
    "Josephson" "Jung" "Kay" "Kepler" "Kernighan" "Kiczales" "Kleene" "Knuth" "Kolmogorov" "Lagrange"
    "Lambert" "Lavrentyev" "Lawrence" "Leibniz" "Liskov" "Lomonosov" "Lorentz" "Mach" "Marconi" "Marshall"
    "Maxwell" "McCarthy" "Mendenhall" "Michelson" "Milner" "Minsky" "Moler" "Montague" "Montgomery"
    "Moodera" "Moon" "Moore" "Moravec" "Morley" "Naur" "Newton" "Nygaard" "Ockham" "Ohm" "Oppenheimer"
    "Pagels" "Pascal" "Pauli" "Peano" "Peirce" "Penrose" "Perlis" "Philo" "Planck" "Plato" "Podolsky"
    "Poincaré" "Poisson" "Popper" "Prigogine" "Quine" "Rabin" "Randall" "Rayleigh" "Reed" "Reynolds"
    "Richardson" "Ritchie" "Rosen" "Rucker" "Russell" "Rutherford" "Röntgen" "Sagan" "Sakharov"
    "Schrödinger" "Schwarzschild" "Seneca" "Shockley" "Simpson" "Skolem" "Socrates" "Sokolov"
    "Solovay" "Steele" "Strachey" "Susskind" "Sussman" "Sutherland" "Tanenbaum" "Tarjan" "Tarski"
    "Teller" "Tesla" "Tesler" "Theophrastus" "Thompson" "Torvalds" "Turing" "Tyson" "Venn" "Venturi"
    "Volta" "Von Braun" "Wadler" "Warren" "Watt" "Weizenbaum" "Wheeler" "Whitehead" "Wilks" "Winograd"
    "Wirth" "Wittgenstein" "Zeno" "Zermelo" "Zinovyev"))

(define (domain-name-lists)
  (list (domain0-names) (domain1-names) (domain2-names) (domain3-names)
        (domain4-names) (domain5-names) (domain6-names) (domain7-names)))
