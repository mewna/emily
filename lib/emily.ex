defmodule Emily do
  @moduledoc """
  thank mr cregg
  """

  alias Emily.Util

  def handle(payload) do
    with {:ok, body} <- payload,
    do: {:ok, Poison.decode!(body)}
  end

  # Sending regular messages
  def create_message(channel_id, content) when is_binary(content) do
    request(:post, Util.channel_messages(channel_id), %{content: content, tts: false})
    |> handle
  end

  # Embeds
  def create_message(channel_id, [content: c, embed: e]) do
    request(:post, Util.channel_messages(channel_id), %{content: c, embed: e, tts: false})
    |> handle
  end

  # Files
  def create_message(channel_id, [file_name: c, file: f]) do
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
