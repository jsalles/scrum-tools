defmodule Velocity.Team do
  @vssp %{
    name: "Service Platform",
    key: "sp",
    members: [
      {"Joao Salles", "joao.salles@check24.de", ~N[2020-03-01 00:00:00.000]},
      {"David Molnar", "david.molnar@check24.de", ~N[2020-03-01 00:00:00.000]},
      {"Alina Ignat", "alina.ignat@check24.de", ~N[2020-03-01 00:00:00.000]},
      {"Thomas Stohl", "thomas.stohl@check24.de", ~N[2020-07-16 00:00:00.000]}
    ],
    board_id: 1979,
    first_sprint_id: 0,
    done_story_status: "Done",
    ignored_sprints: [10393]
  }

  @bo %{
    name: "Backoffice",
    key: "bo",
    members: [
      {"Anton Vasilenko", "anton.vasilenko@check24.de", ~N[2019-05-13 00:00:00.000]},
      {"Dominik Voss", "dominik.voss@check24.de", ~N[2019-10-01 00:00:00.000]},
      {"Julia Tcukanova", "julia.tcukanova@check24.de", ~N[2019-10-01 00:00:00.000]},
      {"Maja Korajcevic", "maja.korajcevic@check24.de", ~N[2019-05-13 00:00:00.000]},
      {"Nicolas Bresson", "nicolas.bresson@check24.de", ~N[2020-06-15 00:00:00.000]},
      {"Roman Gantverg", "roman.gantverg@check24.de", ~N[2020-04-01 00:00:00.000]},
      {"Soroush Torkzadeh", "soroush.torkzadeh@check24.de", ~N[2019-06-04 00:00:00.000]}
    ],
    board_id: 1668,
    first_sprint_id: 6104,
    done_story_status: "Closed",
    ignored_sprints: []
  }

  @bot %{
    name: "BOT",
    key: "bot",
    members: [
      {"Denis Bardadym", "denis.bardadym@check24.de", ~N[2020-01-01 00:00:00.000Z]},
      {"Dzheni Pavlova", "dzheni.pavlova@check24.de", ~N[2020-01-01 00:00:00.000Z]},
      {"Sergej Koschkin", "sergej.koschkin@check24.de", ~N[2020-01-01 00:00:00.000Z]},
      {"Mikhail Slivinskiy", "mikhail.slivinskiy@check24.de", ~N[2020-01-01 00:00:00.000Z]},
      {"Jiri Dvorak", "jiri.dvorak@check24.de", ~N[2020-01-01 00:00:00.000Z]}
    ],
    board_id: 850,
    first_sprint_id: 0,
    done_story_status: "Done",
    ignored_sprints: []
  }

  @veve %{
    name: "VEVE",
    key: "veve",
    members: [
      {"Fabian Zintgraf", "fabian.zintgraf@check24.de", ~N[2020-01-01 00:00:00.000Z]},
      {"Maksym Kondratiuk", "maksym.kondratiuk@check24.de", ~N[2020-01-01 00:00:00.000Z]},
      {"Patrick Blickling", "patrick.blickling@check24.de", ~N[2020-01-01 00:00:00.000Z]},
      {"Rodrigo Santos da Silva", "rodrigo.santos@check24.de", ~N[2020-01-01 00:00:00.000Z]},
      {"Alexander Potapov", "alexander.potapov@check24.de", ~N[2020-10-01 00:00:00.000Z]},
      {"Slim Tebourski", "slim.tebourski@check24.de", ~N[2020-10-01 00:00:00.000Z]},
      {"Mariia Tiurina", "mariia.tiurina@check24.de", ~N[2020-04-01 00:00:00.000Z]},
      {"Ugurcan Sengit", "ugurcan.sengit@check24.de", ~N[2021-01-01 00:00:00.000Z]},
      {"Travis Tang", "yiu.tang@check24.de@check24.de", ~N[2021-01-01 00:00:00.000Z]},
      {"Daniel Daneshi", "daniel.daneshi@check24.de", ~N[2021-03-01 00:00:00.000Z]},
      {"Denis Rodin", "denis.rodin@check24.de", ~N[2021-02-01 00:00:00.000Z]}
    ],
    board_id: 443,
    first_sprint_id: 0,
    done_story_status: "Done",
    ignored_sprints: [3661, 10282, 10461]
  }

  def list(), do: [@vssp, @bo, @bot, @veve]

  def get("sp"),
    do: @vssp

  def get("bo"),
    do: @bo

  def get("bot"),
    do: @bot

  def get("veve"), do: @veve
end
