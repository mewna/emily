defmodule Emily.Base do
  @version Emily.Mixfile.project[:version]

  use HTTPoison.Base

  alias Emily.Util

  defp process_url(url) do
    Util.base_url <> url
  end

  defp process_request_body(""),
    do: ""
  defp process_request_body({:multipart, _} = body),
    do: body
  defp process_request_body(body),
    do: Poison.encode!(body)

  defp process_request_headers(headers) do
    user_agent = [{"User-Agent", "DiscordBot (https://github.com/queer/emily, #{@version})"} | headers]
    token = System.get_env("BOT_TOKEN")
    [{"Authorization", "Bot " <> token} | user_agent]
  end

  defp process_response_body(body) do
    body
  end
end
