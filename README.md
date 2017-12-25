# Emily

A port of the [Nostrum](https://github.com/Kraigie/nostrum) Discord REST API 
client, adapated to be redis-backed. All credit goes to ~~Cregg~~ Craig for the
original. 

## Installation

```elixir
def deps do
  [
    {:emily, github: "queer/emily"}
  ]
end
```
```Bash
BOT_TOKEN="a token goes here, probably"
```

Then configure workers for `Lace.Redis` and `Emily.Ratelimiter`. 
