//
//  Images.swift
//  Router
//
//  Created by Gaea on 2023/02/24.
//

import Foundation

let symbolName = ["figure.walk",
                  "figure.walk.circle",
                  "figure.walk.circle.fill",
                  "figure.walk.diamond",
                  "figure.walk.diamond.fill",
                  "figure.run",
                  "figure.run.circle",
                  "figure.run.circle.fill",
                  "figure.run.square.stack",
                  "figure.run.square.stack.fill",
                  "figure.roll",
                  "figure.roll.runningpace",
                  "figure.american.football",
                  "figure.archery",
                  "figure.australian.football",
                  "figure.badminton",
                  "figure.barre",
                  "figure.baseball",
                  "figure.basketball",
                  "figure.bowling",
                  "figure.boxing",
                  "figure.climbing",
                  "figure.cooldown",
                  "figure.core.training",
                  "figure.cricket",
                  "figure.skiing.crosscountry",
                  "figure.cross.training",
                  "figure.curling",
                  "figure.dance",
                  "figure.disc.sports",
                  "figure.skiing.downhill",
                  "figure.elliptical",
                  "figure.equestrian.sports",
                  "figure.fencing",
                  "figure.fishing",
                  "figure.flexibility",
                  "figure.strengthtraining.functional",
                  "figure.golf",
                  "figure.gymnastics",
                  "figure.hand.cycling",
                  "figure.handball",
                  "figure.highintensity.intervaltraining",
                  "figure.hiking",
                  "figure.hockey",
                  "figure.hunting",
                  "figure.indoor.cycle",
                  "figure.jumprope",
                  "figure.kickboxing",
                  "figure.lacrosse",
                  "figure.martial.arts",
                  "figure.mind.and.body",
                  "figure.mixed.cardio",
                  "figure.open.water.swim",
                  "figure.outdoor.cycle",
                  "oar.2.crossed",
                  "figure.pickleball",
                  "figure.pilates",
                  "figure.play",
                  "figure.pool.swim",
                  "figure.racquetball",
                  "figure.rolling",
                  "figure.rower",
                  "figure.rugby",
                  "figure.sailing",
                  "figure.skating",
                  "figure.snowboarding",
                  "figure.soccer",
                  "figure.socialdance",
                  "figure.softball",
                  "figure.squash",
                  "figure.stair.stepper",
                  "figure.stairs",
                  "figure.step.training",
                  "figure.surfing",
                  "figure.table.tennis",
                  "figure.taichi",
                  "figure.tennis",
                  "figure.track.and.field",
                  "figure.strengthtraining.traditional",
                  "figure.volleyball",
                  "figure.water.fitness",
                  "figure.waterpolo",
                  "figure.wrestling",
                  "figure.yoga",
                  "baseball.diamond.bases",
                  "dumbbell",
                  "dumbbell.fill",
                  "sportscourt",
                  "sportscourt.fill",
                  "sportscourt.circle",
                  "sportscourt.circle.fill",
                  "lane",
                  "1.lane",
                  "2.lane",
                  "3.lane",
                  "4.lane",
                  "5.lane",
                  "6.lane",
                  "7.lane",
                  "8.lane",
                  "9.lane",
                  "10.lane",
                  "11.lane",
                  "12.lane",
                  "soccerball",
                  "soccerball.inverse",
                  "soccerball.circle",
                  "soccerball.circle.inverse",
                  "soccerball.circle.fill",
                  "soccerball.circle.fill.inverse",
                  "baseball",
                  "baseball.fill",
                  "baseball.circle",
                  "baseball.circle.fill",
                  "basketball",
                  "basketball.fill",
                  "basketball.circle",
                  "basketball.circle.fill",
                  "football",
                  "football.fill",
                  "football.circle",
                  "football.circle.fill",
                  "tennis.racket",
                  "tennis.racket.circle",
                  "tennis.racket.circle.fill",
                  "hockey.puck",
                  "hockey.puck.fill",
                  "hockey.puck.circle",
                  "hockey.puck.circle.fill",
                  "cricket.ball",
                  "cricket.ball.fill",
                  "cricket.ball.circle",
                  "cricket.ball.circle.fill",
                  "tennisball",
                  "tennisball.fill",
                  "tennisball.circle",
                  "tennisball.circle.fill",
                  "volleyball",
                  "volleyball.fill",
                  "volleyball.circle",
                  "volleyball.circle.fill",
                  "trophy",
                  "trophy.fill",
                  "trophy.circle",
                  "trophy.circle.fill",
                  "medal",
                  "medal.fill",
                  "water.waves",
                  "water.waves.slash",
                  "water.waves.and.arrow.up",
                  "water.waves.and.arrow.down",
                  "water.waves.and.arrow.down.trianglebadge.exclamationmark",
                  "flag.checkered",
                  "flag.checkered.circle",
                  "flag.checkered.circle.fill",
                  "flag.2.crossed",
                  "flag.2.crossed.fill",
                  "flag.2.crossed.circle",
                  "flag.2.crossed.circle.fill",
                  "flag.filled.and.flag.crossed",
                  "flag.and.flag.filled.crossed",
                  "flag.checkered.2.crossed",
                  "gamecontroller",
                  "gamecontroller.fill",
                  "folder.badge.person.crop",
                  "folder.fill.badge.person.crop",
                  "externaldrive.badge.person.crop",
                  "externaldrive.fill.badge.person.crop",
                  "person",
                  "person.fill",
                  "person.circle",
                  "person.circle.fill",
                  "person.fill.turn.right",
                  "person.fill.turn.down",
                  "person.fill.turn.left",
                  "person.fill.checkmark",
                  "person.fill.xmark",
                  "person.fill.questionmark",
                  "person.badge.plus",
                  "person.fill.badge.plus",
                  "person.badge.minus",
                  "person.fill.badge.minus",
                  "person.badge.clock",
                  "person.badge.clock.fill",
                  "person.badge.key",
                  "person.badge.key.fill",
                  "person.badge.shield.checkmark",
                  "person.badge.shield.checkmark.fill",
                  "shareplay",
                  "shareplay.slash",
                  "rectangle.inset.filled.and.person.filled",
                  "shared.with.you",
                  "shared.with.you.slash",
                  "person.and.arrow.left.and.arrow.right",
                  "person.fill.and.arrow.left.and.arrow.right",
                  "person.2",
                  "person.2.fill",
                  "person.2.circle",
                  "person.2.circle.fill",
                  "person.2.slash",
                  "person.2.slash.fill",
                  "person.2.gobackward",
                  "person.2.badge.gearshape",
                  "person.2.badge.gearshape.fill",
                  "person.wave.2",
                  "person.wave.2.fill",
                  "person.2.wave.2",
                  "person.2.wave.2.fill",
                  "person.line.dotted.person",
                  "person.line.dotted.person.fill",
                  "person.3",
                  "person.3.fill",
                  "person.3.sequence",
                  "person.3.sequence.fill",
                  "person.crop.circle",
                  "person.crop.circle.fill",
                  "person.crop.circle.badge.plus",
                  "person.crop.circle.fill.badge.plus",
                  "person.crop.circle.badge.minus",
                  "person.crop.circle.fill.badge.minus",
                  "person.crop.circle.badge.checkmark",
                  "person.crop.circle.fill.badge.checkmark",
                  "person.crop.circle.badge.xmark",
                  "person.crop.circle.fill.badge.xmark",
                  "person.crop.circle.badge.questionmark",
                  "person.crop.circle.badge.questionmark.fill",
                  "person.crop.circle.badge.exclamationmark",
                  "person.crop.circle.badge.exclamationmark.fill",
                  "person.crop.circle.badge.moon",
                  "person.crop.circle.badge.moon.fill",
                  "person.crop.circle.badge.clock",
                  "person.crop.circle.badge.clock.fill",
                  "person.crop.circle.badge",
                  "person.crop.circle.badge.fill",
                  "person.crop.circle.dashed",
                  "person.crop.square",
                  "person.crop.square.fill",
                  "person.crop.artframe",
                  "person.bust",
                  "person.bust.fill",
                  "person.crop.rectangle.stack",
                  "person.crop.rectangle.stack.fill",
                  "person.2.crop.square.stack",
                  "person.2.crop.square.stack.fill",
                  "person.crop.rectangle",
                  "person.crop.rectangle.fill",
                  "person.crop.rectangle.badge.plus",
                  "person.crop.rectangle.badge.plus.fill",
                  "square.on.square.badge.person.crop",
                  "square.on.square.badge.person.crop.fill",
                  "arrow.up.and.person.rectangle.portrait",
                  "arrow.up.and.person.rectangle.turn.right",
                  "arrow.up.and.person.rectangle.turn.left",
                  "person.crop.square.filled.and.at.rectangle",
                  "person.crop.square.filled.and.at.rectangle.fill",
                  "person.text.rectangle",
                  "person.text.rectangle.fill",
                  "person.and.background.dotted",
                  "figure.stand",
                  "figure.stand.line.dotted.figure.stand",
                  "figure.dress.line.vertical.figure",
                  "figure.arms.open",
                  "figure.2.arms.open",
                  "figure.2.and.child.holdinghands",
                  "figure.and.child.holdinghands",
                  "figure.walk.arrival",
                  "figure.walk.departure",
                  "figure.walk.motion",
                  "figure.wave",
                  "figure.wave.circle",
                  "figure.wave.circle.fill",
                  "figure.fall",
                  "figure.fall.circle",
                  "figure.fall.circle.fill",
                  "person.icloud",
                  "person.icloud.fill",
                  "lungs",
                  "lungs.fill",
                  "tshirt",
                  "tshirt.fill",
                  "shoeprints.fill",
                  "face.smiling",
                  "face.smiling.inverse",
                  "face.dashed",
                  "face.dashed.fill",
                  "eye",
                  "eye.fill",
                  "eye.circle",
                  "eye.circle.fill",
                  "eye.square",
                  "eye.square.fill",
                  "eye.slash",
                  "eye.slash.fill",
                  "eye.slash.circle",
                  "eye.slash.circle.fill",
                  "eye.trianglebadge.exclamationmark",
                  "eye.trianglebadge.exclamationmark.fill",
                  "eyes",
                  "eyes.inverse",
                  "eyebrow",
                  "nose",
                  "nose.fill",
                  "mustache",
                  "mustache.fill",
                  "mouth",
                  "mouth.fill",
                  "brain.head.profile",
                  "brain",
                  "ear",
                  "ear.badge.checkmark",
                  "ear.trianglebadge.exclamationmark",
                  "ear.and.waveform",
                  "ear.fill",
                  "hearingdevice.ear",
                  "hearingdevice.ear.fill",
                  "hearingdevice.and.signal.meter",
                  "hearingdevice.and.signal.meter.fill",
                  "hand.raised",
                  "hand.raised.fill",
                  "hand.raised.circle",
                  "hand.raised.circle.fill",
                  "hand.raised.square",
                  "hand.raised.square.fill",
                  "hand.raised.app",
                  "hand.raised.app.fill",
                  "hand.raised.slash",
                  "hand.raised.slash.fill",
                  "hand.raised.fingers.spread",
                  "hand.raised.fingers.spread.fill",
                  "hand.thumbsup",
                  "hand.thumbsup.fill",
                  "hand.thumbsup.circle",
                  "hand.thumbsup.circle.fill",
                  "hand.thumbsdown",
                  "hand.thumbsdown.fill",
                  "hand.thumbsdown.circle",
                  "hand.thumbsdown.circle.fill",
                  "hand.point.up.left",
                  "hand.point.up.left.fill",
                  "hand.draw",
                  "hand.draw.fill",
                  "hand.tap",
                  "hand.tap.fill",
                  "rectangle.and.hand.point.up.left",
                  "rectangle.and.hand.point.up.left.fill",
                  "rectangle.filled.and.hand.point.up.left",
                  "rectangle.and.hand.point.up.left.filled",
                  "hand.point.left",
                  "hand.point.left.fill",
                  "hand.point.right",
                  "hand.point.right.fill",
                  "hand.point.up",
                  "hand.point.up.fill",
                  "hand.point.up.braille",
                  "hand.point.up.braille.fill",
                  "hand.point.down",
                  "hand.point.down.fill",
                  "hand.wave",
                  "hand.wave.fill",
                  "hands.clap",
                  "hands.clap.fill",
                  "hands.sparkles",
                  "hands.sparkles.fill",
                  "person.fill.viewfinder",
                  "rectangle.badge.person.crop",
                  "rectangle.fill.badge.person.crop",
                  "rectangle.stack.badge.person.crop",
                  "rectangle.stack.badge.person.crop.fill",
                  "globe.americas",
                  "globe.americas.fill",
                  "globe.europe.africa",
                  "globe.europe.africa.fill",
                  "globe.asia.australia",
                  "globe.asia.australia.fill",
                  "globe.central.south.asia",
                  "globe.central.south.asia.fill",
                  "sun.min",
                  "sun.min.fill",
                  "sun.max",
                  "sun.max.fill",
                  "sun.max.circle",
                  "sun.max.circle.fill",
                  "sun.max.trianglebadge.exclamationmark",
                  "sun.max.trianglebadge.exclamationmark.fill",
                  "sunrise",
                  "sunrise.fill",
                  "sunrise.circle",
                  "sunrise.circle.fill",
                  "sunset",
                  "sunset.fill",
                  "sunset.circle",
                  "sunset.circle.fill",
                  "sun.and.horizon",
                  "sun.and.horizon.fill",
                  "sun.and.horizon.circle",
                  "sun.and.horizon.circle.fill",
                  "sun.dust",
                  "sun.dust.fill",
                  "sun.dust.circle",
                  "sun.dust.circle.fill",
                  "sun.haze",
                  "sun.haze.fill",
                  "sun.haze.circle",
                  "sun.haze.circle.fill",
                  "moonphase.new.moon",
                  "moonphase.waxing.crescent",
                  "moonphase.first.quarter",
                  "moonphase.waxing.gibbous",
                  "moonphase.full.moon",
                  "moonphase.waning.gibbous",
                  "moonphase.last.quarter",
                  "moonphase.waning.crescent",
                  "moonphase.new.moon.inverse",
                  "moonphase.waxing.crescent.inverse",
                  "moonphase.first.quarter.inverse",
                  "moonphase.waxing.gibbous.inverse",
                  "moonphase.full.moon.inverse",
                  "moonphase.waning.gibbous.inverse",
                  "moonphase.last.quarter.inverse",
                  "moonphase.waning.crescent.inverse",
                  "moon",
                  "moon.fill",
                  "moon.circle",
                  "moon.circle.fill",
                  "moon.haze",
                  "moon.haze.fill",
                  "moon.haze.circle",
                  "moon.haze.circle.fill",
                  "sparkles",
                  "moon.stars",
                  "moon.stars.fill",
                  "moon.stars.circle",
                  "moon.stars.circle.fill",
                  "cloud",
                  "cloud.fill",
                  "cloud.circle",
                  "cloud.circle.fill",
                  "cloud.drizzle",
                  "cloud.drizzle.fill",
                  "cloud.drizzle.circle",
                  "cloud.drizzle.circle.fill",
                  "cloud.rain",
                  "cloud.rain.fill",
                  "cloud.rain.circle",
                  "cloud.rain.circle.fill",
                  "cloud.heavyrain",
                  "cloud.heavyrain.fill",
                  "cloud.heavyrain.circle",
                  "cloud.heavyrain.circle.fill",
                  "cloud.fog",
                  "cloud.fog.fill",
                  "cloud.fog.circle",
                  "cloud.fog.circle.fill",
                  "cloud.hail",
                  "cloud.hail.fill",
                  "cloud.hail.circle",
                  "cloud.hail.circle.fill",
                  "cloud.snow",
                  "cloud.snow.fill",
                  "cloud.snow.circle",
                  "cloud.snow.circle.fill",
                  "cloud.sleet",
                  "cloud.sleet.fill",
                  "cloud.sleet.circle",
                  "cloud.sleet.circle.fill",
                  "cloud.bolt",
                  "cloud.bolt.fill",
                  "cloud.bolt.circle",
                  "cloud.bolt.circle.fill",
                  "cloud.bolt.rain",
                  "cloud.bolt.rain.fill",
                  "cloud.bolt.rain.circle",
                  "cloud.bolt.rain.circle.fill",
                  "cloud.sun",
                  "cloud.sun.fill",
                  "cloud.sun.circle",
                  "cloud.sun.circle.fill",
                  "cloud.sun.rain",
                  "cloud.sun.rain.fill",
                  "cloud.sun.rain.circle",
                  "cloud.sun.rain.circle.fill",
                  "cloud.sun.bolt",
                  "cloud.sun.bolt.fill",
                  "cloud.sun.bolt.circle",
                  "cloud.sun.bolt.circle.fill",
                  "cloud.moon",
                  "cloud.moon.fill",
                  "cloud.moon.circle",
                  "cloud.moon.circle.fill",
                  "cloud.moon.rain",
                  "cloud.moon.rain.fill",
                  "cloud.moon.rain.circle",
                  "cloud.moon.rain.circle.fill",
                  "cloud.moon.bolt",
                  "cloud.moon.bolt.fill",
                  "cloud.moon.bolt.circle",
                  "cloud.moon.bolt.circle.fill",
                  "smoke",
                  "smoke.fill",
                  "smoke.circle",
                  "smoke.circle.fill",
                  "wind",
                  "wind.circle",
                  "wind.circle.fill",
                  "wind.snow",
                  "wind.snow.circle",
                  "wind.snow.circle.fill",
                  "snowflake",
                  "snowflake.circle",
                  "snowflake.circle.fill",
                  "snowflake.slash",
                  "tornado",
                  "tornado.circle",
                  "tornado.circle.fill",
                  "tropicalstorm",
                  "tropicalstorm.circle",
                  "tropicalstorm.circle.fill",
                  "hurricane",
                  "hurricane.circle",
                  "hurricane.circle.fill",
                  "thermometer.sun",
                  "thermometer.sun.fill",
                  "thermometer.sun.circle",
                  "thermometer.sun.circle.fill",
                  "thermometer.snowflake",
                  "thermometer.snowflake.circle",
                  "thermometer.snowflake.circle.fill",
                  "humidity",
                  "humidity.fill",
                  "drop",
                  "drop.fill",
                  "drop.circle",
                  "drop.circle.fill",
                  "drop.degreesign",
                  "drop.degreesign.fill",
                  "drop.degreesign.slash",
                  "drop.degreesign.slash.fill",
                  "drop.triangle",
                  "drop.triangle.fill",
                  "flame",
                  "flame.fill",
                  "flame.circle",
                  "flame.circle.fill",
                  "bolt",
                  "bolt.fill",
                  "bolt.circle",
                  "bolt.circle.fill",
                  "bolt.square",
                  "bolt.square.fill",
                  "bolt.shield",
                  "bolt.shield.fill",
                  "bolt.slash",
                  "bolt.slash.fill",
                  "bolt.slash.circle",
                  "bolt.slash.circle.fill",
                  "bolt.badge.clock",
                  "bolt.badge.clock.fill",
                  "bolt.badge.a",
                  "bolt.badge.a.fill",
                  "bolt.trianglebadge.exclamationmark",
                  "bolt.trianglebadge.exclamationmark.fill",
                  "mountain.2",
                  "mountain.2.fill",
                  "mountain.2.circle",
                  "mountain.2.circle.fill",
                  "allergens",
                  "allergens.fill",
                  "microbe",
                  "microbe.fill",
                  "microbe.circle",
                  "microbe.circle.fill",
                  "hare",
                  "hare.fill",
                  "tortoise",
                  "tortoise.fill",
                  "lizard",
                  "lizard.fill",
                  "bird",
                  "bird.fill",
                  "ant",
                  "ant.fill",
                  "ant.circle",
                  "ant.circle.fill",
                  "ladybug",
                  "ladybug.fill",
                  "fish",
                  "fish.fill",
                  "fish.circle",
                  "fish.circle.fill",
                  "pawprint",
                  "pawprint.fill",
                  "pawprint.circle",
                  "pawprint.circle.fill",
                  "leaf",
                  "leaf.fill",
                  "leaf.circle",
                  "leaf.circle.fill",
                  "leaf.arrow.triangle.circlepath",
                  "laurel.leading",
                  "laurel.trailing",
                  "camera.macro",
                  "camera.macro.circle",
                  "camera.macro.circle.fill",
                  "tree",
                  "tree.fill",
                  "tree.circle",
                  "tree.circle.fill",
                  "carrot",
                  "carrot.fill",
                  "atom",
                  "fossil.shell",
                  "fossil.shell.fill"]
let colorHexs = ["FFC0CB",
                 "FFB6C1",
                 "FF69B4",
                 "FF1493",
                 "DB7093",
                 "C71585",
                 "FFA07A",
                 "FA8072",
                 "E9967A",
                 "F08080",
                 "CD5C5C",
                 "DC143C",
                 "B22222",
                 "8B0000",
                 "FF0000",
                 "FF4500",
                 "FF6347",
                 "FF7F50",
                 "FF8C00",
                 "FFA500",
                 "FFFF00",
                 "FFFFE0",
                 "FFFACD",
                 "FAFAD2",
                 "FFEFD5",
                 "FFE4B5",
                 "FFDAB9",
                 "EEE8AA",
                 "F0E68C",
                 "BDB76B",
                 "FFD700",
                 "FFF8DC",
                 "FFEBCD",
                 "FFE4C4",
                 "FFDEAD",
                 "F5DEB3",
                 "DEB887",
                 "D2B48C",
                 "BC8F8F",
                 "F4A460",
                 "DAA520",
                 "B8860B",
                 "CD853F",
                 "D2691E",
                 "8B4513",
                 "A0522D",
                 "A52A2A",
                 "800000",
                 "556B2F",
                 "808000",
                 "6B8E23",
                 "9ACD32",
                 "32CD32",
                 "00FF00",
                 "7CFC00",
                 "7FFF00",
                 "ADFF2F",
                 "00FF7F",
                 "00FA9A",
                 "90EE90",
                 "98FB98",
                 "8FBC8F",
                 "3CB371",
                 "2E8B57",
                 "228B22",
                 "008000",
                 "006400",
                 "66CDAA",
                 "00FFFF",
                 "E0FFFF",
                 "AFEEEE",
                 "7FFFD4",
                 "40E0D0",
                 "48D1CC",
                 "00CED1",
                 "20B2AA",
                 "5F9EA0",
                 "008B8B",
                 "008080",
                 "B0C4DE",
                 "B0E0E6",
                 "ADD8E6",
                 "87CEEB",
                 "87CEFA",
                 "00BFFF",
                 "1E90FF",
                 "6495ED",
                 "4682B4",
                 "4169E1",
                 "0000FF",
                 "0000CD",
                 "00008B",
                 "000080",
                 "191970",
                 "E6E6FA",
                 "D8BFD8",
                 "DDA0DD",
                 "EE82EE",
                 "DA70D6",
                 "FF00FF",
                 "BA55D3",
                 "9370DB",
                 "8A2BE2",
                 "9400D3",
                 "9932CC",
                 "8B008B",
                 "800080",
                 "4B0082",
                 "483D8B",
                 "663399",
                 "6A5ACD",
                 "7B68EE",
                 "FFFFFF",
                 "FFFAFA",
                 "F0FFF0",
                 "F5FFFA",
                 "F0FFFF",
                 "F0F8FF",
                 "F8F8FF",
                 "F5F5F5",
                 "FFF5EE",
                 "F5F5DC",
                 "FDF5E6",
                 "FFFAF0",
                 "FFFFF0",
                 "FAEBD7 ",
                 "FAF0E6",
                 "FFF0F5",
                 "FFE4E1",
                 "DCDCDC",
                 "D3D3D3",
                 "C0C0C0",
                 "A9A9A9",
                 "808080",
                 "696969",
                 "778899",
                 "708090",
                 "2F4F4F",
                 "000000"]
