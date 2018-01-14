defmodule Emily.Embed do
  @moduledoc """
  Utility methods for pipe-building embeds
  """

  @zwsp <<0x20, 0x0E>>

  def embed do
    %{}
  end

  def title(embed, title) when is_map(embed) do
    embed |> Map.put("title", title)
  end

  def desc(embed, desc) when is_map(embed) do
    embed |> Map.put("description", desc)
  end

  def url(embed, url) when is_map(embed) do
    embed |> Map.put("url", url)
  end

  def color(embed, color) when is_map(embed) do
    embed |> Map.put("color", color)
  end

  def field(embed, name, value, inline) when is_map(embed) and is_boolean(inline) do
    embed = unless Map.has_key?(embed, "fields") do
              embed |> Map.put("fields", [])
            else
              embed
            end
    fields = embed["fields"]
    embed |> Map.put("fields", fields ++ [%{"name" => name, "value" => value, "inline" => inline}])
  end

  def field(embed, inline) when is_map(embed) and is_boolean(inline) do
    embed = unless Map.has_key?(embed, "fields") do
              embed |> Map.put("fields", [])
            else
              embed
            end
    fields = embed["fields"]
    embed |> Map.put("fields", fields ++ [%{"name" => @zwsp, "value" => @zwsp, "inline" => inline}])
  end

  def thumbnail(embed, url) when is_map(embed) do
    embed |> Map.put("thumbnail", %{"url" => url})
  end
end