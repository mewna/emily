defmodule Emily do
  @moduledoc """
  thank mr cregg
  """

  alias Emily.Util

  def handle(payload) do
    with {:ok, body} <- payload,
    do: {:ok, Poison.decode!(body)}
  end

  # Helper methods so that the REST functions can be used in chained function calls, ex.
  # embed()
  # |> title("Test embed")
  # |> desc("This is a test of the emergency embed system")
  # |> color(0xFFFFFF)
  # |> Emily.create_message(channel_id)

  def create_message(content, channel_id) when is_binary(content) do
    request(:post, Util.channel_messages(channel_id), %{content: content, tts: false})
    |> handle
  end

  def create_message(embed, channel_id) when is_map(embed) do
    request(:post, Util.channel_messages(channel_id), %{content: "", embed: embed, tts: false})
    |> handle
  end

  def create_message({content, embed}, channel_id) when is_binary(content) and is_map(embed) do
    request(:post, Util.channel_messages(channel_id), %{content: content, embed: embed, tts: false})
    |> handle
  end

  # Ported Nostrum stuff

  # Sending regular messages
  def n_create_message(channel_id, content) when is_binary(content) do
    request(:post, Util.channel_messages(channel_id), %{content: content, tts: false})
    |> handle
  end

  # Embeds
  def n_create_message(channel_id, [content: c, embed: e]) do
    request(:post, Util.channel_messages(channel_id), %{content: c, embed: e, tts: false})
    |> handle
  end

  # Files
  # TODO: This is broken, see the latest PRs on Nostrum for how it was fixed
  def n_create_message(channel_id, [file_name: c, file: f]) do
    request_multipart(:post, Util.channel_messages(channel_id), %{content: c, file: f, tts: false})
    |> handle
  end

  def edit_message(channel_id, message_id, content) when is_binary(content) do
    request(:patch, Util.channel_message(channel_id, message_id), %{content: content})
    |> handle
  end

  def edit_message(channel_id, message_id, [content: c, embed: e]) do
    request(:patch, Util.channel_message(channel_id, message_id), %{content: c, embed: e})
    |> handle
  end

  # HTTPosion defaults to `""` for an empty body, so it's safe to do so here
  def request(method, route, body \\ "", options \\ []) do
    request = %{
      method: method,
      route: route,
      body: body,
      options: options,
      headers: [{"content-type", "application/json"}]
    }
    GenServer.call(Ratelimiter, {:queue, request, nil}, :infinity)
  end

  def request_multipart(method, route, body \\ "", options \\ []) do
    request = %{
      method: method,
      route: route,
      # Hello hackney documentation :^)
      body: {:multipart, [{"content", body.content}, {:file, body.file}, {"tts", body.tts}]},
      options: options,
      headers: [{"content-type", "multipart/form-data"}]
    }
    GenServer.call(Ratelimiter, {:queue, request, nil}, :infinity)
  end

  #@doc false
  #def bangify(to_bang) do
  #  case to_bang do
  #    {:error, %{status_code: code, message: message}} ->
  #      raise(Nostrum.Error.ApiError, status_code: code, message: message)
  #    {:ok, body} ->
  #      body
  #    {:ok} ->
  #      {:ok}
  #  end
  #end
end
