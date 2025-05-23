name = "Reg - DHPModified"
description = [[
Original mod: https://steamcommunity.com/sharedfiles/filedetails/?id=1217385169
From update version: 1 Dec 2017

A robot with a human-like appearance that Riko found in the abyss, but had lost its memory.

I tried to make this character work individually without co-op characters.
]]
author = "PhucDH410"
version = "1.2"
api_version = 6
api_version_dst = 10
dst_compatible = true
priority = 0
dont_starve_compatible = false
reign_of_giants_compatible = false
all_clients_require_mod = true
icon_atlas = "modicon.xml"
icon = "modicon.tex"
forumthread = ""
server_filter_tags = {"character", "art"}

configuration_options = {
  {
      name = "regExhaust",
      label = "Exhaustion",
      hover = "Reg is tired when using the hat.",
      options = {
          {description = "Enabled", data = true, hover = "Reg gets exhausted when using the hat."},
          {description = "Disabled", data = false, hover = "Reg does not get exhausted when using the hat."},
      },
      default = true,
  },
}